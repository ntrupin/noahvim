-- cmds.lua
-- Noahvim commands

local M = {}

-- Noahvim menu
M.noahvim_menu = function()
  require("noahvim.picker").create("Noahvim Menu", {
    { "Toggle File Explorer",  "NvimTreeToggle" },
    { "Noahvim Git Menu", "NoahvimGit" },
    { "Noahvim Help Page", "NoahvimHelp" },
    { "Noahvim Changelog", "NoahvimChangelog" }
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
    { "Git Branch Commits", "Telescope git_bcommits" },
    { "Git Branches", "Telescope git_branches" },
    { "Git Diff Buffer", "Git diffthis" },
  }, require("telescope.themes").get_ivy({
    layout_config = {
      height = 10
    }
  }))
end

vim.api.nvim_create_user_command("NoahvimGit", M.git_menu, { nargs = 0 })

-- terminal menu + autocmd
M.term_menu = function()
  require("noahvim.picker").create("Noahvim Terminal Menu", {
    { "Bottom", "bot " .. math.ceil(vim.fn.winheight(0) * 0.25) .. "sp | term" },
    { "Left", "top " .. math.ceil(vim.fn.winwidth(0) * 0.25) .. "vs | term" },
    { "Right",  "bot " .. math.ceil(vim.fn.winwidth(0) * 0.25) .. "vs | term" },
    { "Top", "top" .. math.ceil(vim.fn.winheight(0) * 0.25) .. "sp | term" }
  }, require("telescope.themes").get_ivy({
    layout_config = {
      height = 10
    }
  }))
end

vim.api.nvim_create_user_command("NoahvimTerm", M.term_menu, { nargs = 0 })

-- create window helper
M.create_window_from_file = function(filename)
  local keymapsdoc = vim.api.nvim_get_runtime_file(filename, false)[1]
  return require("noahvim.window").create_with_md_file(keymapsdoc)
end

-- show help window + autocmd
M.help_window = function()
  M.create_window_from_file("docs/noahvim-help.md")
end

vim.api.nvim_create_user_command("NoahvimHelp", M.help_window, { nargs = 0 })

-- show info window + autocmd
M.changelog_window = function()
  M.create_window_from_file("CHANGELOG.md")
end

vim.api.nvim_create_user_command("NoahvimChangelog", M.changelog_window, { nargs = 0 })

return M
