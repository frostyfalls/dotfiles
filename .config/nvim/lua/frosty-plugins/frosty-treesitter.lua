return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'vim', 'vimdoc', 'sh' },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
