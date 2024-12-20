local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  clangd = {},
  gopls = {},
  lua_ls = {},
}

for server, conf in pairs(servers) do
  conf['capabilities'] = capabilities
  lspconfig[server].setup(conf)
end
