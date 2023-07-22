-- tree.lua
-- nvim-tree configuration

local M = {}

M.config = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup()
end

return M
