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

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  group = vim.api.nvim_create_augroup('CustomizeColorScheme', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
  end,
})

vim.opt.background = 'dark'
vim.cmd.colorscheme('retrobox')

-- require('ibl').setup({
--   scope = { enabled = false },
-- })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.pumheight = 8
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.undolevels = 8192

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.g.netrw_banner = false

vim.g.mapleader = vim.keycode('<Space>')
vim.g.maplocalleader = vim.keycode('<Space>')

vim.keymap.set('n', '<Leader>e', ':Explore<CR>')
vim.keymap.set('n', '<Leader>r', ':Format<CR>')
vim.keymap.set('n', '<Leader>W', ':write<CR>')

vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>')

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  clangd = {},
  gopls = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  pylsp = {},
}

for server, settings in pairs(servers) do
  lspconfig[server].setup({ settings = settings, capabilities = capabilities })
end

require('lint').linters_by_ft = {
  python = { 'flake8', 'mypy', 'pycodestyle', 'pylint' },
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('LintOnInsert', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})

require('conform').setup({
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    go = { 'gofmt' },
    lua = { 'stylua' },
    python = { 'black' },
  },
})

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format({ async = true, lsp_format = 'fallback', range = range })
end, { range = true })

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-l>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

require('nvim-autopairs').setup({})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'markdown', 'printf', 'python', 'vim', 'vimdoc' },
  auto_install = true,
  highlight = { enable = true },
  endwise = { enable = true },
  indent = { enable = true },
})
