require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
  },
})

vim.keymap.set('n', '<leader>f', require('conform').format)
