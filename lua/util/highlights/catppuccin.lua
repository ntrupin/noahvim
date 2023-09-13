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

  NoahvimNormal = {bg = palette.green, fg = palette.text, bold = true},
  NoahvimInsert = {bg = palette.peach, fg = palette.text, bold = true},
  NoahvimVisual = {bg = palette.red, fg = palette.text, bold = true},
  NoahvimReplace = {bg = palette.yellow, fg = palette.text, bold = true},
  NoahvimCommand = {bg = palette.sapphire, fg = palette.text, bold = true},
  NoahvimTerminal = {bg = palette.lavender, fg = palette.text, bold = true},
  NoahvimInactive = {bg = palette.subtext0, fg = palette.text, bold = true},

  NoahvimNormalInverse = {fg = palette.green, bold = true},
  NoahvimInsertInverse = {fg = palette.peach, bold = true},
  NoahvimVisualInverse = {fg = palette.red, bold = true},
  NoahvimReplaceInverse = {fg = palette.yellow, bold = true},
  NoahvimCommandInverse = {fg = palette.sapphire, bold = true},
  NoahvimTerminalInverse = {fg = palette.lavender, bold = true},
  NoahvimInactiveInverse = {fg = palette.subtext0, bold = true},

  NoahvimRed = {fg = palette.red},
  NoahvimYellow = {fg = palette.yellow},
  NoahvimGreen = {fg = palette.green},
  NoahvimBlue = {fg = palette.blue},
  NoahvimPurple = {fg = palette.lavender},
  NoahvimGrey = {fg = palette.subtext0},
  NoahvimLightGrey = {fg = palette.subtext1},

  NoahvimRedBold = {fg = palette.red, bold = true},
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
