require('lint').linters_by_ft = {
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('LintOnInsert', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})
