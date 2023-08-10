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

    local height = math.ceil(vim.o.lines * 0.8)
    local width = math.ceil(vim.o.columns * 0.8)

    -- center window
    local x = math.ceil((vim.o.columns - width) * 0.5)
    local y = math.ceil((vim.o.lines - height) * 0.5) - 2

    local win_opts = {
      border = "rounded",
      relative = "editor",
      style = "minimal",
      width = width,
      height = height,
      row = y,
      col = x
    }

    note_win = vim.api.nvim_open_win(note_buf, true, win_opts);
    vim.api.nvim_win_set_option(note_win, "winblend", 30)

    local keymap_opts = {
      silent = true,
      buffer = note_buf
    }
    vim.keymap.set("n", "<ESC>", M.launch, keymap_opts)
    vim.keymap.set("n", "q", M.launch, keymap_opts)

    vim.opt_local.spell = true
  else
    vim.api.nvim_win_hide(note_win)
  end
  M.loaded = not M.loaded
end

return M
