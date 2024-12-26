local servers = {
  clangd = {},
  gopls = {},
  lua_ls = {},
}

local lspconfig = require('lspconfig')
for server, conf in pairs(servers) do
  lspconfig[server].setup(conf)
end
