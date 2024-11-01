return {
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local neogit = require('neogit')
      neogit.setup()

      vim.keymap.set('n', '<leader>g', neogit.open)
    end,
  },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.gitblame_delay = 1000
      vim.g.gitblame_ignored_filetypes = { 'netrw' }
      vim.g.gitblame_highlight_group = 'CursorLine'
    end,
  },
}
