-- statusline.lua
-- My custom statusline

Statusline = {}

local components = require("ui.components")

Statusline.highlights = require("util.highlights")

Statusline.build = function()

  local ficon, fcolor = components.file_icon(vim.bo.filetype)

  return table.concat({
    -- Mode
    components.mode_color(),
    components.mode(),

    -- Git Status
    "%#NoahvimGrey#",
    components.git_status(),

    -- folder, file name, and status
    "%#NoahvimGrey# ",
    -- File info
    "  ",
    "%{expand('%:~:.')}",
    " %m",

    -- Git
    " %#NoahvimGrey#",

    -- Spacer
    "%#NoahvimDefaultBG#",
    "%=",

    -- LSP
    components.lsp_status(),

    -- File information
    "%#NoahvimGrey#",
    components.fenc(),
    " %#" .. fcolor .. "#",
    ficon,
    " %Y  ",

    -- Location in the file
    components.mode_color(),
    " %P %l:%c " --> Line, column, and page percentage
  })
end

Statusline.setup = function()
  vim.opt.statusline = "%{%v:lua.Statusline.build()%}"
end

return Statusline
