-- unpack polyfill
if not table.unpack then
  table.unpack = unpack
end

-- load modules
require("opts")
require("keybinds")
require("plugins")
require("noahvim.cmds")

-- setup dashboard
require("noahvim.dashboard").setup()
