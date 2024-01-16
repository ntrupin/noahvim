-- catppuccin.lua
-- colorscheme config

local M = {}

M.setup = function()
  require("catppuccin").setup({
    flavour = "mocha",
    color_overrides = {
      mocha = {
        base = "#152029",
        mantle = "#152029",
        crust = "#152029"
      }
    }
  })

  vim.cmd("colorscheme catppuccin")
end

return M
