-- tree.lua
-- nvim-tree configuration

local M = {}

-- custom on_attach function 
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- default keybinds
  api.config.mappings.default_on_attach(bufnr)
end

M.config = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    -- don't show directories in live filter 
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = false
    },
    on_attach = on_attach
  })

  -- open nvim tree
  local function open_nvim_tree(data)
    -- is real file
    local real_file = vim.fn.filereadable(data.file) == 1
    -- is [No Name] buffer
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
    -- is directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- return if [No Name] or unknown
    if no_name or (not real_file and not directory) then
      return
    end

    -- change to directory, if directory
    if directory then
      vim.cmd.cd(data.file)
    else
      -- open the tree, find file (without focusing)
      require("nvim-tree.api").tree.toggle({
        focus = false,
        find_file = true
      })
    end

  end

  -- create autocmd for startup
  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
end

-- keybinds
M.keybinds = {
  { "n", "<leader>t", "<CMD>NvimTreeToggle<CR>", "[t]oggle: toggle file explorer" }
}

return M
