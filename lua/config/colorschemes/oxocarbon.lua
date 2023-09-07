-- oxocarbon.lua
-- oxocarbon theme config

local M = {}

M.setup = function()
  vim.opt.background = "dark" -- set this to dark or light
  vim.cmd("colorscheme oxocarbon")

  -- patch comment font
  vim.api.nvim_set_hl(0, "Comment", {
    fg = require("oxocarbon.colorutils")["blend-hex"]("#161616", "#ffffff", 0.6),
    bg = "NONE",
    italic = true
  })
end

return M
