-- cmds.lua
-- Noahvim commands

local M = {}

local util = require("util")

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

-- git menu + autocmd
M.git_menu = function()
  require("noahvim.picker").create("Noahvim Git Menu", {
    { "Git Status", "Telescope git_status" },
    { "Git Commits", "Telescope git_commits" },
    { "Git Diff Buffer", "Git diffthis" },
  }, require("telescope.themes").get_ivy({
    layout_config = {
      height = 10
    }
  }))
end

vim.api.nvim_create_user_command("NoahvimGit", M.git_menu, { nargs = 0 })

-- create window helper
M.create_window_from_file = function(filename)
  local keymapsdoc = vim.api.nvim_get_runtime_file(filename, false)[1]
  return require("noahvim.window").create_with_md_file(keymapsdoc)
end

-- show keymaps window + autocmd
M.keymaps_window = function()
  M.create_window_from_file("noahvim-docs/noahvim-keymaps.md")
end

vim.api.nvim_create_user_command("NoahvimKeymaps", M.keymaps_window, { nargs = 0 })

-- show info window + autocmd
M.info_window = function()
  M.create_window_from_file("noahvim-docs/noahvim-info.md")
end

vim.api.nvim_create_user_command("NoahvimInfo", M.info_window, { nargs = 0 })

return M
