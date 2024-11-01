return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local servers = {}

    servers.clangd = {}
    servers.gopls = {}
    servers.lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }
    servers.emmet_language_server = {}
    servers.bashls = {
      settings = {
        filetypes = { 'sh', 'zsh' },
      },
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end
  end,
}
