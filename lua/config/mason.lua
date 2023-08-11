-- mason.lua
-- mason configurations

local M = {}

M.setup = function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗'
      }
    }
  })
end

return M
