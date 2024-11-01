return {
  {
    'stevearc/conform.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          c = { 'clang-format', lsp_format = 'fallback' },
          cpp = { 'clang-format', lsp_format = 'fallback' },
          sh = { 'shfmt', lsp_format = 'fallback' },
          go = { 'goimports', 'gofmt', lsp_format = 'fallback' },
          lua = { 'stylua', lsp_format = 'fallback' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
        },
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
