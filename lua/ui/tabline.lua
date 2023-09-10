-- tabline.lua
-- custom tabline

Tabline = {}

local components = require("ui.components")

Tabline.get_bufs = function()
  local bufs = {}
  local buflen = 0
  for buf = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buf) ~= 0 then
      buflen = buflen + 1
      bufs[buflen] = buf
    end
  end
  return bufs
end

Tabline.build = function()

  return table.concat({
    components.nvimtree_spacer(),

    "%#NoahvimDefaultBG#",

    "%=",
    -- LSP
    components.lsp_status(),

    "%#NoahvimGrey#",
    string.format("  #Tab: %i", vim.fn.tabpagenr("$")),
    " |",
    string.format("  #Buf: %i ", #Tabline.get_bufs()),
  })
end

Tabline.setup = function()
  vim.opt.tabline = "%!v:lua.Tabline.build()"
end

return Tabline
