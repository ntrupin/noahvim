-- scratch.lua
-- notepad

local M = {}

M.loaded = false
local scratch_buf, scratch_win

M.launch = function()
  if not M.loaded or not vim.api.nvim_win_is_valid(scratch_win) then

    if not scratch_buf or not vim.api.nvim_buf_is_valid(scratch_buf) then
      scratch_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(scratch_buf, "bufhidden", "hide") -- wipe buffer on hide
      vim.api.nvim_buf_set_option(scratch_buf, "filetype", "markdown") -- markdown file
    end

    local height = math.ceil(vim.o.lines * 0.8)
    local width = math.ceil(vim.o.columns * 0.8)

    -- center window
    local x = math.ceil((vim.o.columns - width) * 0.5)
    local y = math.ceil((vim.o.lines - height) * 0.5) - 1

    local win_opts = {
      border = "rounded",
      relative = "editor",
      style = "minimal",
      width = width,
      height = height,
      row = y,
      col = x
    }

    scratch_win = vim.api.nvim_open_win(scratch_buf, true, win_opts);
    vim.api.nvim_win_set_option(scratch_win, "winblend", 30)

    local keymap_opts = {
      silent = true,
      buffer = scratch_buf
    }
    vim.keymap.set("n", "<ESC>", M.launch, keymap_opts)
    vim.keymap.set("i", "<ESC>", M.launch, keymap_opts)
    vim.keymap.set("n", "q", M.launch, keymap_opts)

    vim.opt_local.spell = true

    vim.cmd("startinsert") -- enter insert mode
  else
    vim.cmd("stopinsert") -- exit insert mode
    vim.api.nvim_win_hide(scratch_win)
  end
  M.loaded = not M.loaded
end

return M
