-- configs/treesitter.lua
-- custom configuration for nvim-treesitter

local M = {}

M.setup = function()
  local treesitter = require("nvim-treesitter.configs")

  treesitter.setup({
    -- parsers that should always be installed
    ensure_installed = { "bash", "c", "lua", "markdown", "python", "vim" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_fsize = 100 * 1024 -- don't highlight files > 100kb
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_fsize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false
    }
  })
end

return M
