-- tree.lua
-- nvim-tree configuration

local M = {}

M.config = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup()

  -- automatically open tree if dir is open
  local open_tree = function(data)
    if vim.fn.isdirectory(data.file) ~= 1 then 
      return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end

  -- register autocmd 
  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_tree })
end

return M
