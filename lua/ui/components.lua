-- components.lua
-- custom UI components

local M = {}

local highlights = require("util.highlights")
local devicons = require("nvim-web-devicons")
local tree = require("nvim-tree").config
local tree_api = require("nvim-tree.api").tree

M.mode = function()
  local modes = {
    ['n']  = 'NORMAL',
    ['no'] = 'OP-PENDING',
    ['v']  = 'VISUAL',
    ['V']  = 'V-LINE',
    [''] = 'V-BLOCK',
    ['s']  = 'SELECT',
    ['S']  = 'S-LINE',
    [''] = 'S-BLOCK',
    ['i']  = 'INSERT',
    ['R']  = 'REPLACE',
    ['Rv'] = 'V-REPLACE',
    ['c']  = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r']  = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!']  = 'SHELL',
    ["t"] = "TERMINAL",
    ["nt"] = "NORMAL"
  }

  local current = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current] or current):upper()
end

M.mode_color = function()
  local current = vim.api.nvim_get_mode().mode
  local color = "%#NoahvimInactive#"

  if current == "n" or current == "no" or current == "nt" then
    color = "%#NoahvimNormal#"
  elseif current == "i" then
    color = "%#NoahvimInsert#"
  elseif current == "v" or current == "V" or current == "" then
    color = "%#NoahvimVisual#"
  elseif current == "c" then
    color = "%#NoahvimCommand#"
  elseif current == "R" or current == "Rv" then
    color = "%#NoahvimReplace#"
  elseif current == "t" then
    color = "%#NoahvimTerminal#"
  end

  return color
end

M.file_icon = function(filetype)
  local hlname = "Noahvim_" .. filetype

  local icon, color = devicons.get_icon_color_by_filetype(filetype, {
    default = true
  })

  if vim.fn["hlexists"](hlname) == 0 then
    highlights.create_highlight(hlname, {
      fg = color,
      bold = true
    })
  end

  return icon or "", hlname or "NoahvimGrey"
end

-- from theopn/theovim
M.git_status = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  local stat = vim.b.gitsigns_status_dict

  local branch = string.format(" %s", stat.head)
  local added = (stat.added and stat.added ~= 0)
    and string.format(" %%#NoahvimGreen#+%s", stat.added)
    or ""
  local changed = (stat.changed and stat.changed ~= 0)
    and string.format(" %%#NoahvimYellow#~%s", stat.changed)
    or ""
  local removed = (stat.removed and stat.removed ~= 0)
    and string.format(" %%#NoahvimRed#-%s", stat.removed)
    or ""

  return string.format("  %s%s%s%s", branch, added, changed, removed)
end

-- from theopn/theovim
M.fenc = function()
  local ff = vim.bo.fileformat
  if ff == "unix" then
    ff = "  "
  elseif ff == "dos" then
    ff = "  "
  end

  -- if file does not have encoding, display global encoding
  local enc = vim.bo.fileencoding == "" and vim.o.encoding or vim.bo.fileencoding
  return string.format("%s%s", enc, ff):upper()
end

-- from theopn/theovim
M.lsp_status = function()
  if #(vim.lsp.get_active_clients()) == 0 then
    return ""
  end

  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }
  for k, level in pairs(levels) do
    count[k] = #(vim.diagnostic.get(0, { severity = level })) --> 0 for current buf
  end

  local errors = count["errors"] > 0 and count["errors"] .. " " or ""
  local warnings = count["warnings"] > 0 and (count["warnings"] .. " ") or ""
  local hints = count["hints"] > 0 and (count["hints"] .. "? ") or ""
  local info = count["info"] > 0 and count["info"] .. "i " or ""

  return string.format("%s%s%s%s",
    ("%#NoahvimRed#" .. errors), ("%#NoahvimYellow#" .. warnings),
    ("%#NoahvimGrey#" .. hints), ("%#NoahvimBlue#" .. info))
end

M.nvimtree_spacer = function()
  local tree_title = "File Explorer"

  local tree_spacer = ""
  if tree_api.is_visible() then
    local space = string.rep(" ", math.ceil((tree.view.width / 2) - (string.len(tree_title) / 2)))
    tree_spacer = string.format("%%#NvimTreeNormal#%s%s%s%%#NvimTreeWinSeparator#│",
      space,
      tree_title,
      string.sub(space, 1, string.len(space))
    )
  end

  return tree_spacer
end

return M
