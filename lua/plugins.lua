-- plugins.lua
-- self-explanatory

-- plugins
local plugins = {
  -- dependencies
  { "nvim-lua/plenary.nvim" },

  -- appearance
  --[[{
    "sainnhe/everforest",
    config = require("config.colorschemes.everforest").setup
  },]]--
  { 
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = require("config.colorschemes.catppuccin").setup
  },
  { "nvim-tree/nvim-web-devicons" }, -- icons
  {
    "norcalli/nvim-colorizer.lua", -- highlighter
    config = require("config.colorizer").setup
  },
  {
    "windwp/nvim-autopairs", -- autopairs
    event = "InsertEnter",
    opts = {}
  },
  --[[{
    "akinsho/bufferline.nvim", -- tab bar
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = require("config.bufferline").setup
  },]]--
  --[[{
    "nvim-lualine/lualine.nvim", -- statusline
    dependencies = "nvim-tree/nvim-web-devicons",
    config = require("config.lualine").setup
  },]]--
  {
    "rcarriga/nvim-notify", -- notifications
    config = require("config.notify").setup
  },
  {
    "lewis6991/gitsigns.nvim",
    config = require("config.gitsigns").setup
  },

  -- better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    config = require("config.treesitter").setup
  },

  -- telescope fuzzy finder and associated utils
  {
    "nvim-telescope/telescope.nvim", --telescope
    tag = "0.1.2",
    config = require("config.telescope").setup
  },
  { "nvim-telescope/telescope-file-browser.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    config = require("config.tree").setup
  },

  -- lsp
  { "neovim/nvim-lspconfig" }, -- nvim-lsp
  {
    "williamboman/mason.nvim", -- lsp manager
    build = ":MasonUpdate",
    config = require("config.mason").setup
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = require("config.masonlsp").setup
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  {
    "hrsh7th/nvim-cmp",
    config = require("config.cmp").setup
  },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- writing
  {
    "lervag/vimtex",
    config = require("config.vimtex").setup,
    ft = { "plaintex", "tex" }
  }
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
