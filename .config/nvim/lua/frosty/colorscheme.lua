vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  group = vim.api.nvim_create_augroup('CustomizeColorScheme', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
  end,
})

vim.cmd.colorscheme('retrobox')
