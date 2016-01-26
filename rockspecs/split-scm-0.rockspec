package = "split"
version = "scm-0"

source = {
  url = "https://github.com/moteus/lua-split/archive/master.zip",
  dir = "lua-split-master",
}

description = {
  summary = "Implement functions to split strings",
  homepage = "",
  license = "MIT/X11",
}

dependencies = {
  "lua >= 5.1, < 5.4",
}

build = {
  copy_directories = {},

  type = "builtin",

  modules = {
    [ "split" ] = "src/split.lua";
  }
}