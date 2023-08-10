-- oxocarbon.lua
-- oxocarbon theme config

local M = {}

M.config = function()
  vim.opt.background = "dark" -- set this to dark or light
  vim.cmd("colorscheme oxocarbon")
end

return M
