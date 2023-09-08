-- highlights.lua
-- custom highlights
-- inspired by theopn/theovim and sainnhe/everforest

local M = {}

local configuration = vim.fn['everforest#get_configuration']()
local palette = vim.fn['everforest#get_palette'](configuration.background, configuration.colors_override)

if configuration.transparent_background == 2 then
  palette.bg1 = palette.none
end

M.create_highlight = function(group, properties)
  vim.api.nvim_set_hl(0, group, properties)
end

M.highlights = {
  NoahvimDefaultBG = {bg = palette.bg0[1]},

  NoahvimNormal = {bg = palette.statusline1[1], fg = palette.bg0[1]},
  NoahvimInsert = {bg = palette.statusline2[1], fg = palette.bg0[1]},
  NoahvimVisual = {bg = palette.statusline3[1], fg = palette.bg0[1]},
  NoahvimReplace = {bg = palette.orange[1], fg = palette.bg0[1]},
  NoahvimCommand = {bg = palette.aqua[1], fg = palette.bg0[1]},
  NoahvimTerminal = {bg = palette.purple[1], fg = palette.bg0[1]},
  NoahvimInactive = {bg = palette.bg1[1], fg = palette.grey1[1]},

  NoahvimRed = {fg = palette.red[1]},
  NoahvimOrange = {fg = palette.orange[1]},
  NoahvimYellow = {fg = palette.yellow[1]},
  NoahvimGreen = {fg = palette.green[1]},
  NoahvimBlue = {fg = palette.blue[1]},
  NoahvimPurple = {fg = palette.purple[1]},
  NoahvimGrey = {fg = palette.grey0[1]}
}

M.setup = function()
  for group, properties in pairs(M.highlights) do
    M.create_highlight(group, properties)
  end
end

return M
