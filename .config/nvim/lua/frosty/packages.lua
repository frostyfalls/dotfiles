local packages = {
  -- LSP support
  'neovim/nvim-lspconfig',

  -- Linting
  'mfussenegger/nvim-lint',

  -- Formatting
  'stevearc/conform.nvim',

  -- Snippets
  'L3MON4D3/LuaSnip',

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-path',

  -- Tree-sitter support
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'RRethy/nvim-treesitter-endwise',

  -- Fuzzy finder
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  -- Others
  'lukas-reineke/indent-blankline.nvim',
  'windwp/nvim-autopairs',
  'tpope/vim-sleuth',
  'ellisonleao/gruvbox.nvim',
  'nvim-lualine/lualine.nvim',
}

local paq_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

local function paq_clone()
  vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', paq_path })
end

local function paq_bootstrap()
  table.insert(packages, { 'savq/paq-nvim', opt = true })
  vim.cmd.packadd('paq-nvim')
  local paq = require('paq')(packages)
  paq.install()
end

vim.api.nvim_create_user_command('PaqBootstrap', paq_bootstrap, {})
vim.api.nvim_create_user_command('PaqClone', paq_clone, {})

if vim.fn.empty(vim.fn.glob(paq_path)) ~= 0 then
  paq_clone()
  paq_bootstrap()
end
