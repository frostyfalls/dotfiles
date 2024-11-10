return {
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme gruvbox')
      vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    end,
  },
}
