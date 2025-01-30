require('lint').linters_by_ft = {
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  callback = function()
    require('lint').try_lint()
  end,
})
