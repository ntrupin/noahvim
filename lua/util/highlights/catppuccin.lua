-- highlights/catppuccin.lua
-- custom highlights
-- inspired by theopn/theovim and catppuccin/nvim

local M = {}

local palette = require("catppuccin.palettes").get_palette("mocha")

M.create_highlight = function(group, properties)
  vim.api.nvim_set_hl(0, group, properties)
end

M.highlights = {
  NoahvimDefaultBG = {bg = palette.base},

  NoahvimNormal = {bg = palette.green, fg = palette.crust, bold = true},
  NoahvimInsert = {bg = palette.rosewater, fg = palette.crust, bold = true},
  NoahvimVisual = {bg = palette.red, fg = palette.crust, bold = true},
  NoahvimReplace = {bg = palette.yellow, fg = palette.crust, bold = true},
  NoahvimCommand = {bg = palette.sapphire, fg = palette.crust, bold = true},
  NoahvimTerminal = {bg = palette.lavender, fg = palette.crust, bold = true},
  NoahvimInactive = {bg = palette.subtext0, fg = palette.crust, bold = true},

  NoahvimNormalInverse = {fg = palette.green, bold = true},
  NoahvimInsertInverse = {fg = palette.rosewater, bold = true},
  NoahvimVisualInverse = {fg = palette.red, bold = true},
  NoahvimReplaceInverse = {fg = palette.yellow, bold = true},
  NoahvimCommandInverse = {fg = palette.sapphire, bold = true},
  NoahvimTerminalInverse = {fg = palette.lavender, bold = true},
  NoahvimInactiveInverse = {fg = palette.subtext0, bold = true},

  NoahvimRed = {fg = palette.red},
  NoahvimOrange = {fg = palette.peach},
  NoahvimYellow = {fg = palette.yellow},
  NoahvimGreen = {fg = palette.green},
  NoahvimBlue = {fg = palette.blue},
  NoahvimPurple = {fg = palette.lavender},
  NoahvimGrey = {fg = palette.subtext0},
  NoahvimLightGrey = {fg = palette.subtext1},

  NoahvimRedBold = {fg = palette.red, bold = true},
  NoahvimOrangeBold = {fg = palette.peach, bold = true},
  NoahvimYellowBold = {fg = palette.yellow, bold = true},
  NoahvimGreenBold = {fg = palette.green, bold = true},
  NoahvimBlueBold = {fg = palette.blue, bold = true},
  NoahvimPurpleBold = {fg = palette.lavender, bold = true},
  NoahvimGreyBold = {fg = palette.subtext0, bold = true},
  NoahvimLightGreyBold = {fg = palette.subtext1, bold = true},
}

M.setup = function()
  for group, properties in pairs(M.highlights) do
    M.create_highlight(group, properties)
  end
end

return M
