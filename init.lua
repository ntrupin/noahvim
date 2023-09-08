-- unpack polyfill
if not table.unpack then
  table.unpack = unpack
end

-- load modules
require("opts")
require("keybinds")
require("plugins")
require("commands")

-- setup highlights
require("util.highlights").setup()

-- setup dashboard
require("ui.dashboard").setup()

-- setup statusline
require("ui.statusline").setup()

-- setup theme picker
require("ui.colorschemes")
