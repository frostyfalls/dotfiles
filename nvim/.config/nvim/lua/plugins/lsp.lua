local servers = {
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        format = {
          defaultConfig = {
            quote_style = 'single'
          }
        }
      }
    }
  },

  -- JSON
  jsonls = {},

  -- Shell
  bashls = {
    filetypes = { 'sh', 'zsh', }
  },

  -- Go
  gopls = {}
}

return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        config = function()
          require('mason').setup()
        end
      }
    }
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      local servers_keys = {}
      for k, _ in pairs(servers) do
        table.insert(servers_keys, k)
      end

      require('mason-lspconfig').setup {
        ensure_installed = servers_keys
      }

      local lsp = require('lspconfig')
      for server, params in pairs(servers) do
        lsp[server].setup(params)
      end
    end
  }
}
