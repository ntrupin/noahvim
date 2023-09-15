-- util.lua
-- misc utility functions

local M = {}

local bit32 = require("ffi.bit32")

-- find buffer by name
M.find_buffer_by_name = function(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name == name then
      return buf
    end
  end
  return -1
end

-- get current git branch
M.get_current_branch_name = function()
  local output = vim.fn.system({"git", "rev-parse", "--abbrev-ref", "HEAD"})
  -- remove trailing linebreak
  local clean = string.gsub(output, "\n$", "")
  return clean
end

-- darken hex color
M.darken_hex_color = function(color)

  -- trim # if exists
  if color:sub(1, 1) == "#" then
    color = color:sub(2, #color)
  end

  -- validate hex string
  if not color:match("^%x%x%x%x%x%x$") then
    vim.notify("Invalid hex color " .. color .. " provided.")
    return nil
  end

  -- darken
  local number = tonumber(color, 16)
  number = bit32.bor(
    bit32.rshift(bit32.band(number, 0x7E7E7E), 1),
    bit32.band(number, 0x808080)
  )

  -- convert back to string
  color = string.format("#%X", number)

  vim.notify(color)

  return color
end

return M
