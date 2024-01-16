-- bit32.lua
-- ffi for bit32.c

local ffi = require("ffi")

ffi.cdef [[
  int bor(int, int);
  int band(int, int);
  int rshift(int, int);
]]

return ffi.load(os.getenv("HOME") .. "/.config/nvim/build/bit32.so")
