-- plugins.lua
-- self-explanatory

-- plugins
local plugins = {
  -- dependencies
  { "nvim-lua/plenary.nvim" },

  -- appearance
  { 
    "sainnhe/sonokai", -- colorscheme
    config = function()
      vim.cmd("colorscheme sonokai")
    end
  },

  -- better syntax highlighting
  { "nvim-treesitter/nvim-treesitter" }
}

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)
