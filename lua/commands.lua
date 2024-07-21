-- cmds.lua
-- Noahvim commands

local M = {}

-- llm
M.noahvim_llm = function(model_name)
  local model = model_name or "llama3-70b-8192"
  local llm = require("util.llm")
  llm.invoke({
    url = "https://api.groq.com/openai/v1/chat/completions",
    model = model,
    api_key_name = "GROQ_API_KEY",
    system_prompt = "You should replace the code that you are send, only following the comments. Do not talk at all. Only output valid code. Do not use any backticks around your code. Never output backticks like this ```. Any comment asking you for something should be removed after you satisfy it. Other comments should be ignored. Do not output backticks."
  }, llm.make_groq_request, llm.handle_groq_response)
end

vim.api.nvim_create_user_command("NGroq", M.noahvim_llm, { nargs = "?" })

-- noahvim menu + command
M.noahvim_menu = function()
  require("util.picker").create("Noahvim Menu", {
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

-- git menu + command
M.git_menu = function()
  require("util.picker").create("Noahvim Git Menu", {
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

-- terminal menu + command
M.term_menu = function()
  require("util.picker").create("Noahvim Terminal Menu", {
    { "Open with Horizontal Split", "split | term" },
    { "Open with Vertical Split", "vsplit | term" }
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
  return require("util.window").create({ filepath = keymapsdoc })
end

-- show help window + command
M.help_window = function()
  M.create_window_from_file("docs/noahvim-help.md")
end

vim.api.nvim_create_user_command("NoahvimHelp", M.help_window, { nargs = 0 })

-- show info window + command
M.changelog_window = function()
  M.create_window_from_file("CHANGELOG.md")
end

vim.api.nvim_create_user_command("NoahvimChangelog", M.changelog_window, { nargs = 0 })

-- show credits + command
M.credits_window = function()
  M.create_window_from_file("docs/noahvim-credits.md")
end

vim.api.nvim_create_user_command("NoahvimCredits", M.credits_window, { nargs = 0 })

-- notepad command
vim.api.nvim_create_user_command("Notepad", require("ui.notepad").launch, { nargs = 0 })

return M
