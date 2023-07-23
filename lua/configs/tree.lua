-- tree.lua
-- nvim-tree configuration

local M = {}

-- custom on_attach function 
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true 
    }
  end

  -- default keybinds
  api.config.mapping.default_on_attach(bufnr)

  -- custom mappings

end

M.config = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    -- don't show directories in live filter 
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = false
    }
  })

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
