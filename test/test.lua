pcall(require, "luacov")

local split       = require "split"
local utils       = require "utils"
local TEST_CASE   = require "lunit".TEST_CASE

local pcall, error, type, table, tostring, print, debug = pcall, error, type, table, tostring, print, debug
local RUN = utils.RUN
local IT, CMD, PASS, SKIP_CASE = utils.IT, utils.CMD, utils.PASS, utils.SKIP_CASE
local nreturn, is_equal = utils.nreturn, utils.is_equal

local ENABLE = true

local _ENV = TEST_CASE'split.api' if ENABLE then

if not split._URL then test = SKIP_CASE'#TODO update library' else

local it = IT(_ENV or _M)

it('should have API 1', function()
  assert_function(split.split)
  assert_function(split.spliterator)
  assert_string(split._VERSION)
  assert_string(split._AUTHOR)
  assert_string(split._URL)
  assert_string(split._LICENSE)
end)

it('should have API 2', function()
  assert_function(split.split)
  assert_function(split.each)
  assert_function(split.first)
  assert_function(split.unpack)
  assert_pass(function() split('a',';') end)
  assert_string(split._VERSION)
  assert_string(split._AUTHOR)
  assert_string(split._URL)
  assert_string(split._LICENSE)
end)

end end

local function basic_split_test(name, split)

local _ENV = TEST_CASE(name)

local it = IT(_ENV or _M)

it("split using plain text", function()
  local s = assert_table(split.split("ab.cd", ".", true))
  assert_equal("ab", s[1])
  assert_equal("cd", s[2])
  assert_nil(s[3])

  assert_equal("ab.cd", table.concat(s, '.'))
end)

it("split using plain text2", function()
  local s = assert_table(split.split("ab.?cd", ".?", true))
  assert_equal("ab", s[1])
  assert_equal("cd", s[2])
  assert_nil(s[3])

  assert_equal("ab.?cd", table.concat(s, '.?'))
end)

it("split using regex", function()
  local s = assert_table(split.split("ab||", "|+"))
  assert_equal("ab", s[1])
  assert_equal("",   s[2])
  assert_nil(        s[3])
end)

it("split empty string", function()
  local s = assert_table(split.split("", "|", true))
  assert_equal("",   s[1])
  assert_nil(        s[2])

  assert_equal("", table.concat(s, '|'))
end)

it("split empty string with double sep", function()
  local s = assert_table(split.split("", "||", true))
  assert_equal("",   s[1])
  assert_nil(        s[2])

  assert_equal("", table.concat(s, '||'))
end)

it("split string without sep", function()
  local s = assert_table(split.split("ab", "|", true))
  assert_equal("ab", s[1])
  assert_nil(        s[2])

  assert_equal("ab", table.concat(s, '|'))
end)

it("split string ending with sep", function()
  local s = assert_table(split.split("ab|", "|", true))
  assert_equal("ab", s[1])
  assert_equal("",   s[2])
  assert_nil(        s[3])

  assert_equal("ab|", table.concat(s, '|'))
end)

it("split string equal to sep", function()
  local s = assert_table(split.split("|", "|", true))
  assert_equal("",   s[1])
  assert_equal("",   s[2])
  assert_nil(        s[3])

  assert_equal("|", table.concat(s, '|'))
end)

it("split string starting with sep", function()
  local s = assert_table(split.split("|ab", "|", true))
  assert_equal("",   s[1])
  assert_equal("ab", s[2])
  assert_nil(        s[3])

  assert_equal("|ab", table.concat(s, '|'))
end)

it("split string with ended double sep", function()
  local s = assert_table(split.split("ab||", "|", true))
  assert_equal("ab", s[1])
  assert_equal("",   s[2])
  assert_equal("",   s[3])
  assert_nil(        s[4])

  assert_equal("ab||", table.concat(s, '|'))
end)

it("split string with double sep", function()
  local s = assert_table(split.split("ab||cd", "|", true))
  assert_equal("ab", s[1])
  assert_equal("",   s[2])
  assert_equal("cd", s[3])
  assert_nil(        s[4])

  assert_equal("ab||cd", table.concat(s, '|'))
end)

it("split string with empty sep", function()
  local s = assert_table(split.split("ab cd", "", true))
  assert_equal("a", s[1])
  assert_equal("b", s[2])
  assert_equal(" ", s[3])
  assert_equal("c", s[4])
  assert_equal("d", s[5])
  assert_nil(       s[6])

  assert_equal("ab cd", table.concat(s))
end)

it("split string with nil sep", function()
  local s = assert_table(split.split("ab cd"))
  assert_equal("ab", s[1])
  assert_equal("cd", s[2])
  assert_nil(        s[3])
end)

end

if ENABLE then basic_split_test('split.basic', split) end

if ENABLE then basic_split_test('split.each.basic', {split = function(...)
  local t = {}
  for ch in split.each(...) do
    t[#t + 1] = ch
  end
  return t
end}) end

local _ENV = TEST_CASE'split.first' if ENABLE then

if not split.first then test = SKIP_CASE'split.first not implemented' else

local it = IT(_ENV or _M)

it("split using plain text", function()
  local n, s1, s2 = nreturn(split.first("ab.cd", ".", true))
  assert_equal(2,    n )
  assert_equal("ab", s1)
  assert_equal("cd", s2)
end)

it("split using regex", function()
  local n, s1, s2 = nreturn(split.first("ab cd", "%s"))
  assert_equal(2,    n )
  assert_equal("ab", s1)
  assert_equal("cd", s2)
end)

it("split string starting with sep", function()
  local n, s1, s2 = nreturn(split.first("|ab", "|", true))
  assert_equal(2,    n )
  assert_equal("",   s1)
  assert_equal("ab", s2)
end)

it("split string ending with sep", function()
  local n, s1, s2 = nreturn(split.first("ab|", "|", true))
  assert_equal(2,    n )
  assert_equal("ab", s1)
  assert_equal("",   s2)
end)

it("split string ending with regex sep", function()
  local n, s1, s2 = nreturn(split.first("ab|", "|", true))
  assert_equal(2,    n )
  assert_equal("ab", s1)
  assert_equal("",   s2)
end)

it("split string without sep", function()
  local n, s1 = nreturn(split.first("ab", "|", true))
  assert_equal(1,    n )
  assert_equal("ab", s1)
end)

it("split empty string", function()
  local n, s1 = nreturn(split.first("", "|", true))
  assert_equal(1,    n )
  assert_equal("",   s1)
end)

it("split with empty separator", function()
  local n, s1, s2 = nreturn(split.first("ab", ""))
  assert_equal(2,    n )
  assert_equal("a",   s1)
  assert_equal("b",   s2)
end)

end end

local _ENV = TEST_CASE'split.each'  if ENABLE then

local it = IT(_ENV or _M)

it("split using plain text", function()
  local n = 0
  for s in split.each("ab.cd", ".", true) do
    n = n + 1
    if n == 1 then assert_equal("ab", s) end
    if n == 2 then assert_equal("cd", s) end
  end
  assert_equal(2, n)
end)

it("split using regex", function()
  local n = 0
  for s in split.each("ab||", "|+") do
    n = n + 1
    if n == 1 then assert_equal("ab", s) end
    if n == 2 then assert_equal("",   s) end
  end
  assert_equal(2, n)
end)

it("split empty string", function()
  local n = 0
  for s in split.each("", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("",   s) end
  end
  assert_equal(1, n)
end)

it("split string without sep", function()
  local n = 0
  for s in split.each("ab", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("ab",   s) end
  end
  assert_equal(1, n)
end)

it("split string ending with sep", function()
  local n = 0
  for s in split.each("ab|", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("ab",   s) end
    if n == 2 then assert_equal("",     s) end
  end
  assert_equal(2, n)
end)

it("split string equal to sep", function()
  local n = 0
  for s in split.each("|", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("",     s) end
    if n == 2 then assert_equal("",     s) end
  end
  assert_equal(2, n)
end)

it("split string starting with sep", function()
  local n = 0
  for s in split.each("|ab", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("",     s) end
    if n == 2 then assert_equal("ab",   s) end
  end
  assert_equal(2, n)
end)

it("split string with ended double sep", function()
  local n = 0
  for s in split.each("ab||", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("ab",   s) end
    if n == 2 then assert_equal("",     s) end
    if n == 3 then assert_equal("",     s) end
  end
  assert_equal(3, n)
end)

it("split string with double sep", function()
  local n = 0
  for s in split.each("ab||cd", "|", true) do
    n = n + 1
    if n == 1 then assert_equal("ab",   s) end
    if n == 2 then assert_equal("",     s) end
    if n == 3 then assert_equal("cd",   s) end
  end
  assert_equal(3, n)
end)

it("split string with empty sep", function()
  local n = 0
  for s in split.each("ab cd", "", true) do
    n = n + 1
    if n == 1 then assert_equal("a",    s) end
    if n == 2 then assert_equal("b",    s) end
    if n == 3 then assert_equal(" ",    s) end
    if n == 4 then assert_equal("c",    s) end
    if n == 5 then assert_equal("d",    s) end
  end
  assert_equal(5, n)
end)

it("split string with double sep", function()
  local n = 0
  for s in split.each("ab;;cd;;", ";;", true) do
    n = n + 1
    if n == 1 then assert_equal("ab",    s) end
    if n == 2 then assert_equal("cd",    s) end
    if n == 3 then assert_equal("",      s) end
  end
  assert_equal(3, n)
end)

it("split string with nil sep", function()
  local n = 0
  for s in split.each("ab cd") do
    n = n + 1
    if n == 1 then assert_equal("ab",   s) end
    if n == 2 then assert_equal("cd",   s) end
  end
  assert_equal(2, n)
end)

end

local _ENV = TEST_CASE'split.error' if ENABLE then

local it = IT(_ENV or _M)

it("split nil as string", function()
  assert_error(function()
    split()
  end)
end)

it("split table as string", function()
  assert_error(function()
    split({})
  end)
end)

it("split string with {} as sep", function()
  assert_error(function()
    split("hello", {})
  end)
end)

it("split sep matched to empty string", function()
  assert_error(function()
    split("hello", '%s*')
  end)
end)

end

local _ENV = TEST_CASE'split.first.error' if ENABLE then

local it = IT(_ENV or _M)

it("split nil as string", function()
  assert_error(function()
    split.first()
  end)
end)

it("split table as string", function()
  assert_error(function()
    split.first({})
  end)
end)

it("split string with {} as sep", function()
  assert_error(function()
    split.first("hello", {})
  end)
end)

it("split sep matched to empty string", function()
  assert_error(function()
    split.first("hello", '%s*')
  end)
end)

end

RUN()

