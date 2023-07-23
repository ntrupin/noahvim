-- plugins.lua
-- self-explanatory

-- plugins
local plugins = {
  -- dependencies
  { "nvim-lua/plenary.nvim" },

  -- appearance
  {
    "sainnhe/everforest", -- colorscheme
    config = require("configs.colorschemes.everforest").config
  },
  { "nvim-tree/nvim-web-devicons" }, -- icons
  {
    "norcalli/nvim-colorizer.lua", -- highlighter
    config = require("configs.colorizer").config
  },
  {
    "windwp/nvim-autopairs", -- autopairs
    event = "InsertEnter",
    opts = {}
  },
  {
    "akinsho/bufferline.nvim", -- tab bar
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = require("configs.bufferline").config
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = require("configs.lualine").config
  },

  -- better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    config = require("configs.treesitter").config
  },

  -- telescope fuzzy finder and associated utils
  {
    "nvim-telescope/telescope.nvim", --telescope
    tag = "0.1.2"
  },
  { "nvim-telescope/telescope-file-browser.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    config = require("configs.tree").config
  },

  -- lsp
  { "neovim/nvim-lspconfig" }, -- nvim-lsp
  {
    "williamboman/mason.nvim", -- lsp manager
    build = ":MasonUpdate",
    config = require("configs.mason").config
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = require("configs.masonlsp").config
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  {
    "hrsh7th/nvim-cmp",
    config = require("configs.cmp").config
  },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" }

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
