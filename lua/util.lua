-- util.lua
-- misc utility functions

local M = {}

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
  return vim.fn.system({"git", "rev-parse", "--abbrev-ref", "HEAD"})
end

return M
