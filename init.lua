-- unpack polyfill
if not table.unpack then
  table.unpack = unpack
end

-- load modules
require("opts")
require("keybinds")
require("plugins")
require("commands")

-- setup dashboard
require("ui.dashboard").setup()
