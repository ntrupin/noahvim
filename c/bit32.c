// bit32.c
//
// A drop-in replacement for Lua's bit32 library,
// designed for Noahvim.
//
// This file does not contain the necessary boilerplate
// for use with Lua's C API. Instead, use this library
// with LuaJIT's FFI library.
//
// Licensed under the MIT License (see LICENSE).
//
// Noah Trupin
// September 14, 2023

int bor(int lhs, int rhs) {
    return lhs | rhs;
}

int band(int lhs, int rhs) {
    return lhs & rhs;
}

int rshift(int lhs, int rhs) {
    return lhs >> rhs;
}
