#Lua-Split

[![Build Status](https://travis-ci.org/moteus/lua-split.png)](https://travis-ci.org/moteus/lua-split)
[![Coverage Status](https://coveralls.io/repos/github/moteus/lua-split/badge.svg?branch=master)](https://coveralls.io/github/moteus/lua-split?branch=master)
[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENCE.txt)

***

### Funcionts

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

#### iter(str, [sep, [plain])

Create iterator to iterate over substrings

```Lua
for word in split.iter('hello world', '%s') do
  print(word)
end
```
