require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'markdown', 'printf', 'python', 'vim', 'vimdoc' },
  auto_install = true,
  highlight = { enable = true },
  endwise = { enable = true },
  indent = { enable = true },
})
