-- cmds.lua
-- Noahvim commands

local M = {}

-- Noahvim menu
M.noahvim_menu = function()
  require("noahvim.picker").create("Noahvim Menu", {
    { "Toggle File Explorer",  "NvimTreeToggle" }
  }, require("telescope.themes").get_ivy({
    layout_config = {
      height = 10
    }
  }))
end

vim.api.nvim_create_user_command("NoahvimMenu", M.noahvim_menu, { nargs = 0 })

-- help/info files
M.keymaps_window = function()
  local keymapsdoc = vim.api.nvim_get_runtime_file("noahvim-docs/noahvim-keymaps.md", false)[1]
  return require("noahvim.window").create_with_md_file(keymapsdoc)
end

vim.api.nvim_create_user_command("NoahvimKeymaps", M.keymaps_window, { nargs = 0 })

return M