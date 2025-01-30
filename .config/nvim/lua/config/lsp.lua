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
}

for server, settings in pairs(servers) do
  require('lspconfig')[server].setup({ settings = settings })
end
