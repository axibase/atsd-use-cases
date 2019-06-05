local socket = require("socket")
local utf = require("utf")

local host, port = "atsd.example.org", 8081
local interval_seconds = 5
local mon_entity = "quik-terminal"
local info_prefix, table_prefix = "quik-info.", "quik-table."
local error_count = 0

local last_trades = {
}

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
end

function OnTrade(trade)
    if (isConnected()) then
        local ft = filtered_trade_table(trade)
        last_trades[ft.trade_num] = ft
    end
end

function main()

    local counter = 0
    while run_loop ~= false do

        counter = counter + 1

        local tcp = socket.tcp()
        tcp:settimeout(5)

        local status, error = tcp:connect(host, port)
        if status == nil or status ~= 1 then
            error_count = error_count + 1
            message(string.format('Connection to %s:%s failed: %s. status: %s',
                    host, port, tostring(error), tostring(status)), 3)
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
                local cmd_trades = last_trades_cmds()
                -- reset count on successful connect
                error_count = 0
                tcp:send(cmds_trade_counts .. cmds_depo_limits .. cmds_orders .. cmds_assets .. cmd_trades)
                tcp:close()

                if counter % 100 == 1 then
                    message(cmd_info_series)
                    message(cmd_info_property)
                    message(cmds_trade_counts)
                    message(cmds_depo_limits)
                    message(cmds_orders)
                    message(cmds_assets)
                    if (cmd_trades ~= "") then
                        message(cmd_trades)
                    end
                    message(string.format("Commands sent to %s:%s. counter: %s", host, port, counter))
                end
            end
        end

        sleep(interval_seconds * 1000)
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
    local command = "series e:" .. mon_entity
    command = command .. " t:protocol=tcp"
    command = command .. string.format(" t:%s=%s", "USERID", getInfoParam("USERID"))
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
    local command = "property e:" .. mon_entity
    command = command .. " t:terminal-info k:protocol=tcp"
    command = command .. string.format(" k:%s=\"%s\"", "USERID", getInfoParam("USERID"))
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
        command = command .. string.format(" v:%s=\"%s\"", name, utf.cp1251_utf8(getInfoParam(name)))
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
    return "series e:" .. mon_entity .. " t:" .. "USERID=" .. getInfoParam("USERID")
end

function get_assets_commands()
    local asset_prefix = "quik-asset."
    local commands = ""
    local size = getNumberOf("money_limits")
    for i = 0, size - 1 do
        local lim = getItem("money_limits", i)
        if (lim.currcode == 'SUR' and (lim.openbal > 0 or lim.currentbal > 0)) then
            local p_info = getPortfolioInfoEx(lim.firmid, lim.client_code, lim.limit_kind)

            local numeric_values = {}
            numeric_values.currentbal = lim.currentbal
            numeric_values.openbal = lim.openbal
            numeric_values.all_assets = p_info.all_assets
            numeric_values.in_all_assets = p_info.in_all_assets
            numeric_values.open_positions = p_info.in_all_assets - lim.openbal
            numeric_values.curr_positions = p_info.all_assets - lim.currentbal

            local text_values = {}
            text_values.currcode = 'SUR'
            text_values.tag = lim.tag
            text_values.limit_kind = tostring(lim.limit_kind)

            commands = commands .. base_series_template()
            for k, v in pairs(numeric_values) do
                commands = commands .. " m:" .. asset_prefix .. k .. "=" .. tostring(v)
            end
            for k, v in pairs(text_values) do
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
    local res = ("%04d-%02d-%02dT%02d:%02d:%02d"):format(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
    if dt.mcs ~= nil then
        res = res .. "." .. string.format("%03d", math.floor(dt.mcs / 1000))
    elseif dt.ms ~= nil then
        res = res .. "." .. string.format("%03d", dt.ms)
    end
    return res .. "+03:00"
end

function round(a)
    return a >= 0 and math.floor(a + 0.5) or math.ceil(a - 0.5)
end

function now_ms()
    local cur_date = os.sysdate()
    return (os.time(cur_date)) * 1000 + math.floor(cur_date.mcs / 1000)
end

function last_trades_cmds()
    local commands = ""
    local now = now_ms()
    for k, v in pairs(last_trades) do
        if ((now - v.ms) > 1000) then
            commands = commands .. get_trade_command(v)
            last_trades[k] = nil
        end
    end
    return commands
end

function get_trade_command(trade)
    local entity = string.format("%s_[%s]", trade.sec_code, trade.class_code)
    local cmd = "message e:" .. entity .. " t:source=quik-terminal t:type=quik m:\"\""
    for k, v in pairs(trade) do
        if (k == "ms") then
            cmd = cmd .. " ms:" .. tostring(v)
        else
            cmd = cmd .. " t:" .. k .. "=" .. "\"" .. utf.cp1251_utf8(tostring(v)) .. "\""
        end
    end
    return cmd .. "\n"
end

function filtered_trade_table(trade)
    local fields = { "class_code", "order_num", "sec_code", "price", "settle_currency", "trade_currency", "trade_num",
                     "trans_id", "value", "exchange_comission", "clearing_comission" }
    local filtered_trade = {}
    filtered_trade.sec_code = trade.sec_code
    filtered_trade.class_code = trade.class_code
    filtered_trade.userid = getInfoParam("USERID")

    for _, k in pairs(fields) do
        local v = trade[k]
        if v ~= nil and v ~= '' then
            filtered_trade[k] = v
        end
    end
    local dt = date_to_string(trade.datetime)
    if dt ~= nil and dt ~= '' then
        filtered_trade.trade_date = dt
    end
    local price = tonumber(trade.price)
    local lots = tonumber(trade.qty)
    local amount = tonumber(trade.value)
    local quantity = round(amount / price)
    local operation = bit.band(trade.flags, 0x4) and "sell" or "buy"
    local broker_ref = trade.brokerref ~= nil and trade.brokerref:gsub(trade.client_code, "") or trade.brokerref

    filtered_trade.lots = tostring(lots)
    filtered_trade.quantity = tostring(quantity)
    filtered_trade.operation = tostring(operation)
    filtered_trade.brokerref = tostring(broker_ref)
    filtered_trade.ms = now_ms()
    return filtered_trade
end