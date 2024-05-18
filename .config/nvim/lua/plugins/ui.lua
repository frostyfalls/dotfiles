return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy'
  },

  {
    'f-person/git-blame.nvim',
    opts = {
      highlight_group = 'NonText'
    }
  }
}
