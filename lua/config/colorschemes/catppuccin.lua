-- catppuccin.lua
-- colorscheme config

local M = {}

M.setup = function()
  require("catppuccin").setup({
    flavour = "mocha",
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000"
      }
    }
  })

  vim.cmd("colorscheme catppuccin")
end

return M
