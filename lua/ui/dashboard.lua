-- dashboard.lua
-- startup dashboard
-- inspired by https://github.com/theopn/theovim/blob/main/lua/ui/dashboard.lua

local M = {}

local header = {
  [[          _      _      _            ]],
  [[        >(.)__ <(.)__ =(.)__         ]],
  [[         (___/  (___/  (___/         ]],
  [[      -------/\-----/\-----/\---     ]]
}

local logo = {
  [[      _     _   _   /7     ()_       ]],
  [[     / \/7,'o|,'o| / \/7/7/7/ \'\    ]],
  [[    /_n_/ |_,'|_,7/n_/|,'///_nn_/    ]],
  "",
  [[ ─────────────────────────────────── ]]
}

local options = {
  { "󰥨 Find File              <leader>ff", cmd = "Telescope find_files" },
  { "󰈙 Recent Files           <leader>fr", cmd = "Telescope oldfiles" },
  { " File Browser           <leader>fb", cmd = "Telescope file_browser" },
  { " Exit Noahvim           <leader>q ", cmd = "quit" }
}

local lazy = {
  [[  ⚡ Loaded %02d plugins in %.1fms   ]]
}


local lazy_stats = require("lazy").stats()

local min_width = #logo[1]
local empty_line = string.rep(" ", min_width)

-- pad empty line
table.insert(header, 1, empty_line)
header[#header + 1] = empty_line
logo[#logo + 1] = empty_line

local min_height = 1 + #header + #logo + (#options * 2) + #lazy + 1 + 1

local render = function()
  -- get dimensions
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  -- check for empty buffer
  if vim.api.nvim_buf_get_name(0) ~= "" then
    return
  end

  -- make sure we have enough room
  if height < min_height then
    vim.notify_once("Dashboard: window size too small")
    return
  end

  -- wipe old buffer
  vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

  -- create new buffer
  local buf = vim.api.nvim_create_buf(false, true) -- listed, scratchbuffer
  vim.api.nvim_win_set_buf(0, buf)
  vim.opt_local.filetype = "NoahvimDashboard"
  vim.opt_local.buflisted = false
  vim.opt_local.list = false
  vim.opt_local.wrap = true
  vim.opt_local.relativenumber = false
  vim.opt_local.number = false
  vim.opt_local.cursorline = false
  vim.opt_local.cursorcolumn = false
  vim.opt_local.colorcolumn = "0"
  vim.opt_local.modifiable = true

  -- pad string
  local add_padding = function(str)
    local pad = (width - vim.fn.strwidth(str)) / 2
    return string.rep(" ", math.floor(pad)) .. str
  end

  -- dashboard contents
  local dashboard = {}

  for _, val in ipairs(header) do
    table.insert(dashboard, add_padding(val))
  end

  for _, val in ipairs(logo) do
    table.insert(dashboard, add_padding(val))
  end

  for _, val in ipairs(options) do
    table.insert(dashboard, add_padding(val[1]))
    table.insert(dashboard, empty_line)
  end
  -- table.remove(dashboard, #dashboard)

  for _, val in ipairs(lazy) do
    table.insert(dashboard, add_padding(
      string.format(val, lazy_stats.loaded, lazy_stats.startuptime)
    ))
  end

  -- set dashboard
  local result = {}
  for i = 1, height do
    result[i] = ""
  end

  local hdr_start_idx_save = math.floor((height / 2) - (#dashboard / 2) - 1)
  local hdr_start_idx = math.floor((height / 2) - (#dashboard / 2) - 1)

  for _, val in ipairs(dashboard) do
    result[hdr_start_idx_save] = val
    hdr_start_idx_save = hdr_start_idx_save + 1
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)

  -- highlight

  -- ducks
  for i = hdr_start_idx, hdr_start_idx + #header - 3 do
    vim.api.nvim_buf_add_highlight(buf, -1, "NoahvimYellowBold", i, 0, -1)
  end

  -- water
  vim.api.nvim_buf_add_highlight(buf, -1, "NoahvimBlueBold", hdr_start_idx + (#header - 3), 0, -1)

  -- name
  for i = hdr_start_idx + #header - 2, hdr_start_idx + #header + #logo - 5 do
    vim.api.nvim_buf_add_highlight(buf, -1, "NoahvimRedBold", i, 0, -1)
  end

  -- lazy
  for i = hdr_start_idx + #dashboard - 2, hdr_start_idx + #dashboard - 2 do
    vim.api.nvim_buf_add_highlight(buf, -1, "NoahvimPurpleBold", i, 0, -1)
  end

  -- set cursor to first char
  local cursor_column_idx = (width > min_width) and (math.floor(width / 2) - 18) or 0
  vim.api.nvim_win_set_cursor(0, { hdr_start_idx + #header + #logo, cursor_column_idx })

  -- button locations
  local curr_btn_line = hdr_start_idx + #header + #logo + 2
  local opts_line_nums = {}

  for _, _ in ipairs(options) do
    table.insert(opts_line_nums, curr_btn_line - 2)
    curr_btn_line = curr_btn_line + 2
  end

  local moveUp = function()
    local curr = vim.fn.line(".")
    local target_line = vim.tbl_contains(opts_line_nums, curr - 2) and curr - 2 or opts_line_nums[#opts_line_nums]
    vim.api.nvim_win_set_cursor(0, { target_line, cursor_column_idx })
  end

  local moveDown = function()
    local curr = vim.fn.line(".")
    local target_line = vim.tbl_contains(opts_line_nums, curr + 2) and curr + 2 or opts_line_nums[1]
    vim.api.nvim_win_set_cursor(0, { target_line, cursor_column_idx })
  end

  local returnKey = function()
    for i, v in ipairs(opts_line_nums) do
      if v == vim.fn.line(".") then
        local action = options[i].cmd
        if type(action) == "string" then
          vim.cmd(action)
        elseif type(action) == "function" then
          action()
        else
          vim.notify("Unknown action. This should never occur.", vim.log.levels.ERROR, {
            title = "Noahvim"
          })
        end
      end
    end
  end

  -- keybinds
  vim.keymap.set("n", "h", "<NOP>", { buffer = true })
  vim.keymap.set("n", "j", moveDown, { buffer = true })
  vim.keymap.set("n", "k", moveUp, { buffer = true })
  vim.keymap.set("n", "l", "<NOP>", { buffer = true })
  vim.keymap.set("n", "<LEFT>", "<NOP>", { buffer = true })
  vim.keymap.set("n", "<DOWN>", moveDown, { buffer = true })
  vim.keymap.set("n", "<UP>", moveUp, { buffer = true })
  vim.keymap.set("n", "<RIGHT>", "<NOP>", { buffer = true })
  vim.keymap.set("n", "<CR>", returnKey, { buffer = true })

  -- prevent modification
  vim.opt_local.modifiable = false
end

-- wait for neovim to say we're safe to render
-- this avoids issues with drawing while resizing
M.opener = function()
  vim.schedule(render)
end

M.setup = function()
  M.opener()

  -- resize function
  local resize = function()
    if vim.bo.filetype == "NoahvimDashboard" then
      vim.opt_local.modifiable = true
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
      M.opener()
    end
  end

  -- make autocmd for resize event
  vim.api.nvim_create_autocmd("VimResized", {
    callback = resize
  })

end

return M
