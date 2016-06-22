#Lua-Split

[![Build Status](https://travis-ci.org/moteus/lua-split.png)](https://travis-ci.org/moteus/lua-split)
[![Coverage Status](https://coveralls.io/repos/github/moteus/lua-split/badge.svg?branch=master)](https://coveralls.io/github/moteus/lua-split?branch=master)
[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENCE.txt)

***

### Functions

#### split(str, [sep, [plain])

Split string and returns array

```Lua
t = split('aaa;bbb', ';', true)
-- t = {'aaa', 'bbb'}
```

#### unpack(str, [sep, [plain])

Split string and returns result as multiple values

```Lua
a, b = split.unpack('aaa;bbb', ';', true)
-- a = 'aaa' b = 'bbb'
```

#### first(str, [sep, [plain])

Split first substring result as 2 values

```Lua
key, val = split.first('pass=hello=world', '=', true)
-- key = 'pass' val = 'hello=world'
```

#### each(str, [sep, [plain])

Create iterator to iterate over substrings

```Lua
for word in split.each('hello world', '%s') do
  print(word)
end
```

Example
```Lua
-- decode header value like:
-- `value1;key1=1;key2=2,value2;key1=1;key2=2`
-- result:
-- {
--   {value1,{key=1,key2=2}};
--   {value2,{key=1,key2=2}};
-- }
function decode_header(str)
  local res = {}
  for ext in split.each(str, "%s*,%s*") do
    local name, tail = split.first(ext, '%s*;%s*')
    if #name > 0 then
      local opt  = {}
      if tail then
        for param in split.each(tail, '%s*;%s*') do
          local k, v = split.first(param, '%s*=%s*')
          opt[k] = v
        end
      end
      res[#res + 1] = {name, opt}
    end
  end
  return res
end
```
