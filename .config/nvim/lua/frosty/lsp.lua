local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  clangd = {},
  gopls = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  pylsp = {},
}

for server, settings in pairs(servers) do
  lspconfig[server].setup({ settings = settings, capabilities = capabilities })
end
