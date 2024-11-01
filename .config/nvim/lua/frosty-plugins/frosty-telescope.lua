return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set('n', '<leader>lf', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<leader>lg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>lt', '<cmd>Telescope git_files<cr>')

      vim.keymap.set('n', '<leader>lb', '<cmd>Telescope buffers<cr>')
    end,
  },
}
