# Lua Tricks

## Lua Overview

1) [Lua](https://www.lua.org/) is a scripting language to use when there are no other options. It is embedded into other [apps](https://blog.cloudflare.com/pushing-nginx-to-its-limit-with-lua/) for automation purposes.

2) Lua is fun to learn and makes it possible to be productive.

3) You do not have to be a Java developer to enjoy some of tricks described in this paper.

## Comments

Single line comment is double dash.

```lua
-- this is comment
print("hello")   -- this is another command
```

Multi-line comment is the following sequence.

```lua
--[[
hello
--]]
```

Usability is on par with [`CDATA`](https://www.w3.org/TR/REC-xml/#syntax) in XML.

```xml
<!--
hello
--->
```

## Data Types

* number
* boolean
* string
* `nil`

## Variables

### Variable Scope

By default, all variables are **global**.

* Global scope

```lua
NAME='John'
AGE=20
THRESHOLD=1.25
REF = nil
```

String literals can be declared with single or double quotes.

* Local scope

```lua
local name = "John"
```

### Declaring Multiple Variables

Enumerate names, then enumerate values, which is unusual.

```lua
name, age, threshold = 'John', 20, 1.25
```

```java
String name = "John"; int age = 20;
```

## Comparison Operators

* `==` - equal
* `~=` - not equal

> `nil == nil` returns `true`
> `10 == '10'` return `false`

```lua
if 0 then
    -- zero evaluates to true in Lua
end
```

To check if variable is not assigned:

```lua
if s ~= nil then

end
```

## Math Functions

The built-in [math package](https://www.lua.org/manual/5.1/manual.html#5.6) lacks some of the commonly used functions.

* Rounds number `x` to the nearest integer.

```lua
function round(x)
  return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end
```

* Rounds number `x` to the specified number of fractional digits.

```lua
function round(x, fractions)
  local mult = 10^fractions
  return (x >= 0 and math.floor(x * mult + 0.5) or math.ceil(x * mult - 0.5))/mult
end
```

The `math` package provides some unusual functions.

* `modf`

Returns two numbers, the integral part of `x` and the fractional part of `x`.

```lua
print(math.modf(3.14))
```

```txt
3  0.14
```

* `fmod`

Returns the remainder of the division of `x` by `y` that rounds the quotient towards zero.

```lua
print(math.fmod(5, 2))
-- same as
print(5 % 2)
```

> `fmod` is probably there for compatibility with legacy versions.

## Comparing Numbers

Lua is dynamically typed, which means the numeric variable is evaluated conditionally based on context.

```lua
-- this evaluates to false
10 == '10'
```

This means, for example, that the result of subtracting results of two **equal** expressions is not necessarily zero.

```lua
print(21 - 300 * 0.07)
```

```txt
-3.5527136788005e-15
```

The [documentation](http://lua-users.org/wiki/FloatingPoint) refers to IEEE 754 epsilon, however `2^52 - 1` (`1.11e-16`) is too small, whereas `1e-14` works.

```lua
-- defined EPSILON as small positive number, e.g.
EPSILON=1e-14
function eq(x, y)
  return math.abs(x - y) < EPSILON
end
```

Using string comparison is possible but verbose and probably slower. The below returns `true`.

```lua
tostring(21) == tostring(300 * 0.07)
```

Basic comparison functions:

```lua
function gt(a, b)
  return a - b > EPSILON
end

function gte(a, b)
  return a - b > EPSILON or math.abs(a - b) < EPSILON
end

function eq(a, b)
  return math.abs(a - b) < EPSILON
end

function is_zero(a)
  return math.abs(a) < EPSILON
end
```

## String Functions

Some basics are missing from the [built-in package](https://www.lua.org/pil/20.html), such as `trim()`. Other less useful functions such as `rep` to repeat string, are present.

> The power of a raw Lua interpreter to manipulate strings is quite limited.

As a result, the Lua wiki has plenty of [competing implementations](http://lua-users.org/wiki/StringTrim), along with benchmarks.

```lua
function trim(s)
    if s ~= nil then
        return s:gsub("^%s*(.-)%s*$", "%1")
    end
    return s
end
```

## Date Functions

```lua
local utc_date = os.date("!*t") -- returns a table in UTC timezone
local unix_seconds = os.time(utc_date)

print(unix_seconds)
print(os.date("%Y-%m-%dT%H:%M:%S"))
print(os.date("!%Y-%m-%dT%H:%M:%SZ"))

for k,val in pairs(utc_date) do
  print(k .. '=' .. val)
end
```

```txt
1559837202
2019-06-06T22:06:42
2019-06-06T19:06:42Z
    hour=19
    min=6
    wday=5
    day=6
    month=6
    year=2019
    sec=42
    yday=157
    isdst=false
```

```lua
function date_to_string(dt)
  if dt == nil then
    return "date is nil"
  end
  if (dt.year == 1601) then
    return "-"
  end
  local res = ("%04d-%02d-%02d %02d:%02d:%02d"):format(dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
  if dt.mcs ~= nil then
    res = res .. "." .. tostring(dt.mcs)
  elseif dt.ms ~= nil then
    res = res .. "." .. tostring(dt.ms)
  end
  return res
end
```

## Re-using Code

Define shared, re-usable functions in a separate file, for example `util.lua`.

```lua
function round(a)
  return a>=0 and math.floor(a+0.5) or math.ceil(a-0.5)
end
```

Place the `util.lua` file into the same directory as the current file and include the file using the [`require`](https://www.lua.org/pil/8.1.html) declaration. Omit the extension from the declaration.

```lua
local util = require("util")

print(round(3.1415))
```

> If necessary add the script directory to the `LUA_PATH` environment setting.

## Package Visibility

To better organize the code, and especially if there is collision risk between functions and variables with the same name, use the following syntax.

* `util.lua`

```lua
local publicClass={};

function publicClass.round(a)
  return a >= 0 and math.floor(a + 0.5) or math.ceil(a - 0.5)
end

return publicClass;
```

* `hello.lua`

Access the imported functions using the package name:

```lua
local util = require("util")

print(util.round(3.1415))
```

An attempt to access a function from the util causes an access error.

```lua
print(round(3.1415))
```

```txt
lua: hello.lua:4: attempt to call global 'round' (a nil value)
```

### Variable Visibility

* `util.lua`

```lua
first_name = "John"
local last_name = "Doe"
```

* `hello.lua`

Variables declared as `local` in the included file are **not** visible in the referencing file. There is **no error** raised. Unknown variables are evaluated to `nil`.

```lua
print(first_name)
print(last_name)
```

```txt
nil
Doe
```

### Private Functions

To hide some of the functions in the shared library, define them with `local` scope **before** the public package functions.

```lua
------- private functions -------

local function roundDec(a, prec)
  local mult = 10^prec
  return (a >= 0 and math.floor(a * mult + 0.5) or math.ceil(a * mult - 0.5))/mult
end

------- public functions  -------

local publicClass={};

-- local function publicClass.name is not allowed

function publicClass.roundInt(a)
  return roundDec(a, 0)
end

return publicClass;
```

## Tables

Arrays are implemented as tables. The built-in index starts at `1` (not at `0`). Tables look like objects.

```lua
local my_list  = {"a", "b"}
local my_table = {a=1, b=2, 3=3}
print(my_list)
print(my_table)
print(my_list[1])
print(my_table.a)
print(my_table["a"])
print(my_table[1])
```

```txt
table: 0x7f80ad4096b0
table: 0x7f80ad409750
a
1
1
nil
```

### Iterate Over Elements

Iterator `ipairs` works for arrays, but returns no elements for tables.

```lua
-- ipairs also works
for idx,val in pairs(my_list) do
  print('idx=' .. tostring(idx) .. ', val=' .. tostring(val))
end
```

```txt
idx=1, val=a
idx=2, val=b
```

```lua
-- only pairs works for table
for idx,val in pairs(my_table) do
  print('idx=' .. tostring(idx) .. ', val=' .. tostring(val))
end
```

```txt
idx=a, val=1
idx=b, val=2
```

### Size

Unusual `#` syntax. Too much sugar?

```lua
local size = #my_table
```

### Add Element To Array

```lua
my_list[#my_list+1] = "c"
```

### Check Value In Array or Table

Need a helper function.

```lua
function has_value(tab, v)
  for idx, value in pairs(tab) do
      if value == v then
          return true
      end
  end
  return false
end
```

### Add Elements

`putAll`

```lua
function putAll(t1, t2)
  -- create copy
  local res = {}
  for i=1,#t1 do
    res[#res+1] = t1[i]
  end  
  -- add new elements at the end
  for i=1,#t2 do
    if not has_value(t1, t2[i]) then
      res[#res+1] = t2[i]
    end
  end
  return res  
end
```

## Functions

### Multiple Value Results

The functions can return multiple values.

```lua
function checkUrl(url)
    if url == nil then
        return 1, 'No url'
    elseif url:find('http') ~= 1 then
        return 2, 'Not an http URL: ' .. url
    else
        return 3, 'Url is OK'
    end
end

local code, msg = checkUrl("ftp://server:8081/page")

print(code)
print(msg)
```

```txt
2
Not an http URL: ftp://server:8081/page
```

### Variable Argument Count

`...` can be passed as `vararg`.

```lua
function log(msg, ...)
  -- also log to file
  print(string.format(msg, ...), 1)
end
```