-- unpack polyfill
if not table.unpack then
  table.unpack = unpack
end

-- load modules
require("plugins")
require("opts")
require("keybinds")
require("commands")

-- setup highlights
require("util.highlights.catppuccin").setup()

-- setup dashboard
require("ui.dashboard").setup()

-- setup lines
require("ui.tabline").setup()
require("ui.statusline").setup()


-- setup theme picker
require("ui.colorschemes")
