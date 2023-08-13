-- windows.lua
-- custom windows

local M = {}

-- reference https://github.com/theopn/theovim/blob/35211730161a6c8a8521f81b325dbc0774dc49d9/lua/theovim/theovim_cmd.lua
M.create = function(opts)
  opts = opts or {}

  local height_mul = opts.height or 0.8
  local height = math.ceil(vim.o.lines * height_mul)

  local width_mul = opts.width or 0.8
  local width = math.ceil(vim.o.columns * width_mul)

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

  -- create buffer
  local buf = vim.api.nvim_create_buf(false, true) -- unlisted, scratch
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe") -- wipe buffer on hide
  vim.api.nvim_buf_set_option(buf, "filetype", opts.filetype or "markdown") -- markdown file
  vim.opt_local.spell = false
  vim.api.nvim_win_set_option(win, "winblend", 0) -- solid

  -- keymaps (exit on quit or escape)
  local keymap_opts = {
    silent = true,
    buffer = buf
  }
  vim.keymap.set("n", "q", "<C-w>q", keymap_opts)
  vim.keymap.set("n", "<ESC>", function()
    vim.api.nvim_win_close(win, true)
  end, keymap_opts)

  -- read file
  -- https://www.reddit.com/r/neovim/comments/s97tja/opening_an_existing_file_in_a_floating_window/
  if opts.filepath ~= nil then
    vim.api.nvim_buf_set_option(0, "modifiable", true)
    vim.cmd("silent 0r" .. opts.filepath)
    vim.api.nvim_buf_set_option(0, "modifiable", false)
  end
end

return M
