-- masonlsp.lua 
-- mason-lspconfig configurations

local M = {}

local servers = {
  "bashls", "clangd", "lua_ls", "pyright", "texlab"
}

M.config = function()
  local mlsp = require("mason-lspconfig")
  local lsp = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  mlsp.setup({
    ensure_installed = servers,
    automatic_installation = true,
    handlers = {
      function(server_name)
        lsp[server_name].setup({
          capabilities = capabilities
        })
      end,
      -- custom lua config 
      ["lua_ls"] = function()
        lsp.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        })
      end
    }
  })

end

return M
