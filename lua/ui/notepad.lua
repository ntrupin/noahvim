-- notepad.lua
-- temporary scratch buffer

local M = {}

M.loaded = false
local note_buf, note_win

M.launch = function()
  if not M.loaded or not vim.api.nvim_win_is_valid(note_win) then

    if not note_buf or not vim.api.nvim_buf_is_valid(note_buf) then
      note_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(note_buf, "bufhidden", "hide") -- wipe buffer on hide
      vim.api.nvim_buf_set_option(note_buf, "filetype", "markdown") -- markdown file
      vim.api.nvim_buf_set_lines(note_buf, 0, -1, false, {
        "# Notepad " .. os.date("%Y-%m-%d %H:%M:%S"),
        "",
        "This buffer clears when you close your Neovim session."
      }) -- welcome message
    end

    note_win = require("util.window").create({
      buf = note_buf,
      winblend = 30,
      spell = true
    })

    local keymap_opts = {
      silent = true,
      buffer = note_buf
    }
    vim.keymap.set("n", "<ESC>", M.launch, keymap_opts)
    vim.keymap.set("n", "q", M.launch, keymap_opts)

  else
    vim.api.nvim_win_hide(note_win)
  end
  M.loaded = not M.loaded
end

return M
