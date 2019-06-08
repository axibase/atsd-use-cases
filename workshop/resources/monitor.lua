local socket = require("socket")
local utf = require("utf")
math.randomseed(os.clock() * os.time())

----- functions required to load properties from file -----

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function read_props(file_name)
  local res = {}
  local f = io.open(file_name, "r")
  if f then
      local lines_found = false
      for line in f:lines() do
          -- ignores all lines without equal sign and lines starting with hash
          if line ~= "" and trim(line):find('#') == nil and line:find('=') ~= nil then
            for k, v in string.gmatch(line, "(.+%s*)=(.*)") do
                res[trim(k)] = trim(v)
                lines_found = true
            end
          end
      end
      if lines_found == false then
        error("configuration file has no key=value lines: " .. file_name)
      end
  else
    error("configuration file missing: " .. file_name)
  end
  return res
end

----- read from monitor.lua >> monitor.conf  -----

--[[
ATSD_HOST = 10.102.0.6
ATSD_PORT = 8081
SEND_ASSETS = true
SEND_TRADES = true
]]--

local SCRIPT_PATH = debug.getinfo(1).short_src
local CONF_FILE = SCRIPT_PATH:gsub("\.lua", ".conf")            
local CONF = read_props(CONF_FILE)

local ATSD_HOST = CONF.ATSD_HOST
local ATSD_PORT = tonumber(CONF.ATSD_PORT)
local INTERVAL_SECONDS = CONF.INTERVAL_SECONDS and tonumber(CONF.INTERVAL_SECONDS) > 0 or 5
local ENTITY = CONF.ENTITY or "quik-terminal"
local USERID = CONF.USERID or getInfoParam("USERID")
local TRADE_SEND_TIMEOUT_SECONDS = CONF.TRADE_SEND_TIMEOUT_SECONDS and tonumber(TRADE_SEND_TIMEOUT_SECONDS) > 0 or 1
local TIMEOUT_SECONDS = CONF.TIMEOUT_SECONDS and tonumber(TIMEOUT_SECONDS) > 0 or 3
local SEND_ASSETS = CONF.SEND_ASSETS ~= nil and CONF.SEND_ASSETS == 'true'
local SEND_TRADES = CONF.SEND_TRADES ~= nil and CONF.SEND_TRADES == 'true'

local run_loop = true
local error_count = 0

local info_prefix, table_prefix = "quik-info.", "quik-table."
local numeric_params = {
    "NUMRECORDS", "MESSAGESSENT", "ALLRECV", "ALLSENT", "BYTESSENT", "MESSAGESRECV", "BYTESRECV",
    "MEMORY", "BYTESPERSECSENT", "BYTESPERSECRECV", "AVGSENT", "AVGRECV", "LASTPINGDURATION",
    "AVGPINGDURATION", "MAXPINGDURATION",
    "LASTRECORD"
}

local string_params = {
    "USERID", "VERSION", "ORG",
    --"USER",
    --"SERVER",
    --"SESSIONID",
    "CONNECTION", "IPADDRESS", "IPPORT", "IPCOMMENT",
    "TRADEDATE", "SERVERTIME", "LASTRECORDTIME", "LOCALTIME", "CONNECTIONTIME", "LASTPINGTIME", "MAXPINGTIME",
    "LATERECORD"
}

function OnStop()
    run_loop = false
    return 50
end

local last_trade_num = 0
function OnTrade(trade)
    -- discard duplication notifications
    if SEND_TRADES == true and run_loop == true and last_trade_num ~= trade.trade_num then
        last_trade_num = trade.trade_num
        local tcp = socket.tcp()
        tcp:settimeout(TRADE_SEND_TIMEOUT_SECONDS)
        tcp:connect(ATSD_HOST, ATSD_PORT)
        tcp:send(get_trade_message_command(trade))
        tcp:close()
    end
end

function main()

    message(string.format("Connect to %s:%s as userid %s. assets: %s trades: %s", ATSD_HOST, ATSD_PORT, USERID, tostring(SEND_ASSETS), tostring(SEND_TRADES)))

    local counter = 0
    while run_loop ~= false do

        counter = counter + 1

        local tcp = socket.tcp()
        tcp:settimeout(TIMEOUT_SECONDS)

        local status, error = tcp:connect(ATSD_HOST, ATSD_PORT)
        if status == nil or status ~= 1 then
            error_count = error_count + 1
            message(string.format('Connection to %s:%s failed: %s. status: %s',
                ATSD_HOST, ATSD_PORT, tostring(error), tostring(status)), 3)
            counter = 0
        else
            -- commands must end with line break
            local cmd_info_series = get_info_series_commands(counter)
            local cmd_info_property = get_info_property_commands(counter)
            tcp:send(cmd_info_series .. cmd_info_property)
            if (isConnected()) then
                local cmds_trade_counts = get_trade_count_commands()
                local cmds_depo_limits = get_depolimit_count_commands()
                local cmds_orders = get_order_count_commands()
                local cmds_assets = get_assets_commands()
                -- reset count on successful connect
                error_count = 0
                tcp:send(cmds_trade_counts .. cmds_depo_limits .. cmds_orders .. cmds_assets)
                tcp:close()
                if counter % 100 == 1 then
                    message(cmd_info_series)
                    message(cmd_info_property)
                    message(cmds_trade_counts)
                    message(cmds_depo_limits)
                    message(cmds_orders)
                    message(cmds_assets)
                    message(string.format("Commands sent to %s:%s. counter: %s", ATSD_HOST, ATSD_PORT, counter))
                end
            end
        end

        sleep(INTERVAL_SECONDS * 1000)
    end
end

function get_conn_status()
    local conn = getInfoParam("CONNECTION")
    -- the file must be saved in cp-1251: string.find(conn, 'не установлено') == nil
    local res = 0
    if conn ~= nil and string.find(conn, ' ') ~= 3 then
        res = 1
    end
    return res
end

function get_info_series_commands(counter)
    local command = "series e:" .. ENTITY
    command = command .. " t:protocol=tcp"
    command = command .. string.format(" t:%s=%s", "USERID", USERID)
    command = command .. string.format(" m:%s%s=%s", info_prefix, "CONNECTED", get_conn_status())
    command = command .. string.format(" m:%serror_count=%d", info_prefix, error_count)
    command = command .. string.format(" m:%scounter=%d", info_prefix, counter)
    for _, name in pairs(numeric_params) do
        local val = tonumber(getInfoParam(name))
        if val == nil then
            val = 0
        end
        command = command .. string.format(" m:%s%s=%s", info_prefix, name, val)
    end
    return command .. "\n"
end

function get_info_property_commands(counter)
    local command = "property e:" .. ENTITY
    command = command .. " t:terminal-info k:protocol=tcp"
    command = command .. string.format(" k:%s=\"%s\"", "USERID", USERID)
    command = command .. string.format(" v:%s=\"%s\"", "CONNECTED", get_conn_status())
    command = command .. string.format(" v:%s=\"%s\"", "counter", counter)
    local usr = getInfoParam("USER")
    if usr ~= nil then
        command = command .. string.format(" v:%s=\"%s\"", "USER", usr:gsub("(%d+%u+)", "#####"))
    end
    local sess = getInfoParam("SESSIONID")
    if sess ~= nil then
        command = command .. string.format(" v:%s=\"%s\"", "SESSIONID", sess:gsub("%d", "#"))
    end

    for _, name in pairs(string_params) do
        local pv = getInfoParam(name)
        -- send whitespace to delete tag values after disconnected
        --if pv ~= nil and pv ~= '' then
            command = command .. string.format(" v:%s=\"%s\"", name, utf.cp1251_utf8(getInfoParam(name)))
        --end
    end

    for _, name in pairs(numeric_params) do
        command = command .. string.format(" v:%s=\"%s\"", name, getInfoParam(name))
    end

    return command .. "\n"
end

function get_order_count_commands()

    local buy_t = { active = 0, completed = 0, completed_partial = 0, cancelled = 0 }
    local sell_t = { active = 0, completed = 0, completed_partial = 0, cancelled = 0 }

    local size = getNumberOf("orders")
    for i = 0, size - 1 do
        local order = getItem("orders", i)
        local completed_qty = order.qty - order.balance
        local flags = order.flags
        local t = buy_t
        if bit.test(flags, 2) then
            t = sell_t
        end
        if bit.test(flags, 0) then
            t.active = t.active + 1
        elseif bit.test(flags, 1) then
            if completed_qty > 0 then
                t.completed_partial = t.completed_partial + 1
            else
                t.cancelled = t.cancelled + 1
            end
        else
            t.completed = t.completed + 1
        end
    end

    local commands = ''
    local cmd_template = base_series_template() ..
            " m:%srecord_count=%s t:table_name=orders t:operation=%s t:status=%s\n"
    for k, v in pairs(buy_t) do
        local cmd = string.format(cmd_template, table_prefix, v, 'buy', k)
        commands = commands .. cmd
    end
    for k, v in pairs(sell_t) do
        local cmd = string.format(cmd_template, table_prefix, v, 'sell', k)
        commands = commands .. cmd
    end
    return commands
end

function get_trade_count_commands()

    local buy_cnt = 0
    local sell_cnt = 0
    local buy_amount = 0
    local sell_amount = 0

    local size = getNumberOf("trades")
    for i = 0, size - 1 do
        local trade = getItem("trades", i)
        if bit.test(trade.flags, 2) then
            sell_cnt = sell_cnt + 1
            sell_amount = sell_amount + trade.price
        else
            buy_cnt = buy_cnt + 1
            buy_amount = buy_amount + trade.price
        end
    end

    local cmd_template = base_series_template() .. " m:%srecord_count=%s m:%stotal_price=%s  t:table_name=trades t:operation=%s\n"
    local commands = string.format(cmd_template, table_prefix, buy_cnt, table_prefix, buy_amount, 'buy')
    commands = commands .. string.format(cmd_template, table_prefix, sell_cnt, table_prefix, sell_amount, 'sell')
    return commands
end

function get_depolimit_count_commands()

    local depo_count = 0
    local size = getNumberOf("depo_limits")
    for i = 0, size - 1 do
        local item = getItem("depo_limits", i)
        if item.limit_kind == 2 and item.currentbal > 0 then
            depo_count = depo_count + 1
        end
    end

    local cmd_template = base_series_template() .. " m:%srecord_count=%s t:table_name=depo_limits t:type=2\n"
    local commands = string.format(cmd_template, table_prefix, depo_count, 'buy')
    return commands
end

function base_series_template()
    return "series e:" .. ENTITY .. " t:userid=" .. USERID
end

function get_assets_commands()
    if COLLECT_ASSETS ~= true then
        return ""
    end
    local cmd_template = base_series_template() .. " m:%s%s=%s m:%s%s=%s t:type=T%s\n"
    local asset_prefix = "quik-asset."
    local commands = ""
    local size = getNumberOf("money_limits")
    for i = 0, size - 1 do
        local lim = getItem("money_limits", i)
        if (lim.currcode == 'SUR' and (lim.openbal > 0 or lim.currentbal > 0)) then
            local p_info = getPortfolioInfoEx(lim.firmid, lim.client_code, lim.limit_kind)

            local numeric_values = {}
            numeric_values.openbal = lim.openbal
            numeric_values.currentbal = lim.currentbal
            numeric_values.locked = lim.locked
            numeric_values.unlocked = lim.currentbal - lim.locked

            -- until 8:55 prices are not reported causing all positions to be valued at 0
            if p_info ~= nil and p_info.in_all_assets ~= nil and p_info.in_all_assets - lim.openbal > 0.1 then
                numeric_values.all_assets = p_info.all_assets
                numeric_values.in_all_assets = p_info.in_all_assets
                numeric_values.open_positions = p_info.in_all_assets - lim.openbal
                numeric_values.curr_positions = p_info.all_assets - lim.currentbal
            end

            local text_values = {}
            text_values.currcode = 'SUR'
            text_values.tag = lim.tag
            text_values.limit_kind = tostring(lim.limit_kind)

            commands = commands .. base_series_template()
            for k,v in pairs(numeric_values) do
                commands = commands .. " m:" .. asset_prefix .. k .. "=" .. tostring(v)
            end
            for k,v in pairs(text_values) do
                commands = commands .. " t:" .. k .. "=\"" .. tostring(v) .. "\""
            end
            commands = commands .. "\n"
        end
    end
    return commands;
end

function date_to_string(dt)
    if dt == nil then
      return nil
    end
    if (dt.year == 1601) then
      return nil
    end
    local res = ("%04d-%02d-%02d %02d:%02d:%02d"):format(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
    if dt.mcs ~= nil then
      res = res .. "." .. tostring(dt.mcs)
    elseif dt.ms ~= nil then
      res = res .. "." .. tostring(dt.ms)
    end
    return res
end

local function round(a)
    return a >= 0 and math.floor(a + 0.5) or math.ceil(a - 0.5)
end

function get_trade_message_command(trade)
    local entity = string.format("%s_[%s]", trade.sec_code, trade.class_code)
    local cmd = "message e:" .. entity .. " t:source=quik-terminal t:type=quik m:\"\""
    cmd = cmd .. " t:userid=" .. USERID
    local fields = {"class_code", "order_num", "sec_code", "price", "trade_currency", "trade_num", "trans_id", "value", "exchange_comission", "clearing_comission"}
    for _, k in pairs(fields) do
        local v = trade[k]
        if v ~= nil and v ~= '' then
            cmd = cmd .. " t:" .. tostring(k) .. "=\"" .. utf.cp1251_utf8(tostring(v)) .. "\""
        end
    end
    local operation = bit.test(trade.flags, 2) and "sell" or "buy"
    cmd = cmd .. " t:operation=" .. operation

    local broker_ref = trade.brokerref ~= nil and trade.brokerref:gsub(trade.client_code, "") or trade.brokerref    
    cmd = cmd .. " t:broker_ref=\"" .. utf.cp1251_utf8(tostring(broker_ref)) .. "\""
    
    -- must convert Moscow TZ (dst=false, offset=3*3600) to UTC
    -- subtract 10800 from trade.datetime
    local dt = date_to_string(trade.datetime)
    if dt ~= nil and dt ~= '' then
        cmd = cmd .. " t:trade_date=\"" .. dt .. "\""
    end
    local price = tonumber(trade.price)
    local lots = tonumber(trade.qty)
    local amount = tonumber(trade.value)
    local quantity = round(amount/price)

    cmd = cmd .. " t:lots=" .. tostring(lots)
    cmd = cmd .. " t:quantity=" .. tostring(quantity)

    return cmd .. "\n"
end