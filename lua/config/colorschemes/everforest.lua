-- everforest.lua
-- everforest colorscheme confirgurations

local M = {}

M.setup = function()
  vim.opt.background = "dark"
  vim.g.everforest_background = "hard"
  vim.g.everforest_better_performance = 1
  vim.cmd("colorscheme everforest")
end

return M
