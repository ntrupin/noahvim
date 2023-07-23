-- bufferline.lua
-- bufferline configurations

local M = {}

M.config = function()
  require("bufferline").setup({
    options = {
      -- show buffer id
      numbers = "buffer_id",
      -- use nvim_lsp for diagnostic info
      diagnostics = "nvim_lsp",
      -- custom diagnostic styles
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "i")
          s = s .. n .. sym
        end
        return s
      end,
      -- offset for NvimTree
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true
        }
      },
      -- custom right-hand error display
      custom_areas = {
        right = function()
          local result = {}
          local severity = vim.diagnostic.severity
          local error = #vim.diagnostic.get(0, { severity = severity.ERROR })
          local warning = #vim.diagnostic.get(0, { severity = severity.WARNING })
          local info = #vim.diagnostic.get(0, { severity = severity.INFO })
          local hint = #vim.diagnostic.get(0, { severity = severity.HINT })

          if error ~= 0 then
            table.insert(result, { text = error .. " ", fg = "#EC5241" })
          end

          if warning ~= 0 then
            table.insert(result, { text = warning .. " ", fg = "#EFB839" })
          end

          if info ~= 0 then
            table.insert(result, { text = info .. "i ", fg = "#7EA9A7" })
          end

          if hint ~= 0 then
            table.insert(result, { text = hint .. "?", fg = "#A3BA5E" })
          end

          return result
        end
      }
    }
  })
end

return M
