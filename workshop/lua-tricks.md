# Lua Tricks

## Lua Overview

[Lua](https://www.lua.org/) is a scripting language which is typically [embedded](https://stackoverflow.com/questions/4448835/alternatives-to-lua-as-an-embedded-language) into C++ [programs](https://blog.cloudflare.com/pushing-nginx-to-its-limit-with-lua/) for automation purposes.

You use Lua when there are no other options but the language is fun to learn and makes it possible to be productive.

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

Numbers are stored as **doubles**.

## Variables

### Variable Scope

By default, all variables are **global**.

* Global scope

```lua
NAME = 'St Petersburg'
AGE  = 316
AREA = 1439.5
CAPITAL = false
COORD = nil
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

## UTF Support

To convert encode `CP-1251` string as UTF, we use [utf.lua](./resources/utf.lua)

```lua
local str = -- CP-1251 string
local utf_str = utf.cp1251_utf8(str)
```

## Syntax Highlights

* Tilde in negative equality check. `~=` instead of `!=`

```lua
obj ~= nil
```

* Array size using hash.

```lua
local tsize = #my_array
```

* Array index starts with `1` instead of `0`

```lua
local arr = {"a", "b"}
 -- arr[1] returns a
```

* Unary operators.

`++` et al is not supported. Incrementing by 1 is verbose.

```lua
count = count + 1
```

* Ternary operator.

`?` is not supported.

```lua
-- illegal
local limit = count > 5 ? 20 : 10
```

Workaround is verbose and not readable.

```lua
local limit = count > 5 and 20 or 10
```

* Control flow.

There is no `continue` operator to skip the block in a loop.

```lua
for i = 1, 10 do
  if i == 3 then
    -- do something on even numbers
    -- and skip the rest of the cycle???
  end
end
```

Verbose workaround for Lua `5.2+` using `goto`.

```lua
for i = 1, 10 do
  if i == 3 then
    -- do something
    -- and skip the rest of the cycle???
    goto continue
  end
  --
  ::continue::  
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

Basic comparison functions to replace checks such as `x == 0` with `eq(x, 0)`.

```lua
EPSILON=1e-14

function eq(x, y)
  -- faster than math.abs(x - y) < EPSILON
  local diff = x - y
  return diff < EPSILON and diff > -EPSILON
end

function gt(x, y)
  return x - y > EPSILON
end

function gte(x, y)
  return x - y >= -EPSILON
end

function is_zero(x)
  -- faster than math.abs(x) < EPSILON
  return x < EPSILON and x > -EPSILON
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

The `os.date` functions accepts Unix **seconds** as the optional second argument.

```lua
local unix_seconds = 1559837000
print(os.date("!%Y-%m-%dT%H:%M:%SZ", unix_seconds))
```

```txt
2019-06-06T16:03:20Z
```

However, `os.date` ignores fractional seconds. Use a workaround by formatting seconds to date and appending fractions.

Be ready for online ads when searching for info on Lua [date](https://www.lua.org/pil/22.1.html) functions.

![](./images/lua-date-ads.png)

## Re-using Code

Define shared, re-usable functions in a separate file, for example `util.lua`.

```lua
function round(x)
  return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
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

function publicClass.round(x)
  return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
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
John
nil
```

### Private Functions

To hide some of the functions in the shared library, define them with `local` scope **before** the public package functions.

```lua
------- private functions -------

local function roundDec(x, prec)
  local mult = 10^prec
  return (x >= 0 and math.floor(x * mult + 0.5) or math.ceil(x * mult - 0.5))/mult
end

------- public functions  -------

local publicClass={};

-- local function publicClass.name is not allowed

function publicClass.roundInt(x)
  return roundDec(x, 0)
end

return publicClass;
```

### Tables and Arrays

Both arrays and tables are stored internally in **tables** as evidenced by the `type()` function.

```lua
local my_array  = {"a", "b"}
local my_table  = {f1 = "hello", f2 = "world"}

print(my_array)
print(my_table)
```

```txt
table: 0x7f80ad409750
table: 0x7f80ad4096b0
```

The table uses **two** different structures: one for storing indexed elements with integer indices starting at `1`, and the other for storing hashed key-value pairs.

The unary `#` operator is provided to get the size of the collection but it only returns the size of the first structure (indexed elements).

```lua
local arr = {"hello", "world"}
print(#arr)

local tab = {f1 = "hello", f2 = "world"}
print(#tab)

local arrtab = {"hello", f1 = "hello", f2 = "world"}
print(#arrtab)
```

```txt
2 -- the indexed part of arr contains two elements.
0 -- the indexed part of tab contains no elements. f1 and f2 are in hash part.
1 -- the indexed part of arrtab contains only one element: "hello"
```

## Tables and Arrays

Arrays are implemented as tables. The built-in index starts at `1` (not at `0`).

## Arrays

```lua
local my_array  = {"a", "b"}
print(my_array[1])
```

```txt
a
```

## Tables

```lua
local my_table = {a=1, b=2, 3=3}
print(my_table.a)
print(my_table["a"])
print(my_table[1])
```

```txt
a
1
1
nil
```

### Array Size

`#` operator retrieves the count of elements in the indexed part of the table (in the array itself).

```lua
local size = #my_array
```

The `ipairs` function returns an iterator which is not always equal to size counted with `pairs` iterator.

```lua
local arrtab = {"a", nil, "b", f1 = "hello", f2 = "world"}
local count = 0
for idx,val in ipairs(arrtab) do
  print(tostring(idx) .. '=' .. tostring(val))
  count = count + 1
end

print(#arrtab .. ' / ' .. count)
```

```txt
1=a
3 / 1
```

Reason is that `ipairs` function stops when it encounters the first `nil` element.

The `pairs` function returns elements from both structures in the table: first the indexed elements, then key-value pairs. The `mil` elements are skipped from **both** structures.

```lua
local arrtab = {"a", nil, "b", f1 = "hello", f2 = nil, f3 = "world"}
local count = 0
for idx,val in pairs(arrtab) do
  print(tostring(idx) .. '=' .. tostring(val))
  count = count + 1
end

print(#arrtab .. ' / ' .. count)
```

```txt
1=a
3=b
f2=world
f1=hello
3 / 4
```

### Viewing All Elements in Array

Beware of the unusual iterator behavior if the array contains a `nil` value.

```lua
local my_array  = {"a", "b", nil, "d"}
```

* `ipairs` ignores `nil` values and stops at the first `nil` value. Subsequent elements are not printed.

```lua
for idx,val in ipairs(my_array) do
  print(tostring(idx) .. '=' .. tostring(val))
end
```

```txt
1=a
2=b
```

* `pairs` ignores `nil` values.

```lua
for idx,val in pairs(my_array) do
  print(tostring(idx) .. '=' .. tostring(val))
end
```

```txt
1=a
2=b
4=d
```

* To view **all** elements, access them by index.

```lua
for i=1,#my_array do
  local val = my_array[i]
  print(tostring(i) .. '=' .. tostring(val))
end
```

```txt
1=a
2=b
3=nil
4=d
```

### Add Element To Array

```lua
my_array[#my_array+1] = "c"
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
    end
    -- note that find function returns two variables: start and end, which can be null
    s, e = url:find('http')
    if s == nil or s > 1 then
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

## Benchmarking

`os.time()` precision is limited to seconds.

Use `os.clock()` to measure intervals with sub-second precision.

```lua
local start_clock = os.clock()
local start_time = os.time()
for i=1,1000000 do
  my_func(math.random(), math.random())
end
local end_clock = os.clock()
local end_time = os.time()

print((end_clock - start_clock) .. ' / ' .. (end_time - start_time))
```

```txt
2.003726 / 2
```