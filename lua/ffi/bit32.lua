-- bit32.lua
-- ffi for bit32.c

local ffi = require("ffi")

ffi.cdef [[
int bor(int, int);
int band(int, int);
int rshift(int, int);
]]

return ffi.load("build/bit32.so")
