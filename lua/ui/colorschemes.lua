-- colorschemes.lua
-- Toggle colorschemes on the fly

local M = {}

M.pick_scheme = function()
  local schemes = require("config.colorschemes").list
  local opts = {}
  for k, v in pairs(schemes) do
    table.insert(opts, { k, v.setup })
  end
  require("util.picker").create("Noahvim Colorschemes", opts, require("telescope.themes").get_ivy({
    layout_config = {
      height = 10
    }
  }))
end


vim.api.nvim_create_user_command("Colorschemes", M.pick_scheme, { nargs = 0 })

return M
