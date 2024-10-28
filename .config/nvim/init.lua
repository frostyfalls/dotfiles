vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('paq')({
  'stevearc/conform.nvim',

  'lewis6991/gitsigns.nvim',

  'olrtg/nvim-emmet',

  'tpope/vim-sleuth',

  'ellisonleao/gruvbox.nvim',

  'windwp/nvim-autopairs',

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  'neovim/nvim-lspconfig',

  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',

  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
})

vim.cmd('colorscheme gruvbox')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.g.netrw_banner = false

vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.scrolloff = 8

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'bash', 'go', 'c', 'cpp', 'lua', 'vimdoc', 'yaml', 'toml' },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['bashls'].setup({
  capabilities = capabilities,
  settings = {
    filetypes = { 'sh', 'zsh' },
  },
})

lspconfig['gopls'].setup({
  capabilities = capabilities,
})

lspconfig['lua_ls'].setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

lspconfig['clangd'].setup({
  capabilities = capabilities,
})

lspconfig['emmet_language_server'].setup({
  capabilities = capabilities,
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete({}),

    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua', lsp_format = 'fallback' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
    go = { 'goimports', 'gofmt', lsp_format = 'fallback' },
    sh = { 'shfmt', lsp_format = 'fallback' },
    cpp = { 'clang-format', lsp_format = 'fallback' },
    c = { 'clang-format', lsp_format = 'fallback' },
  },
})

for _, diag in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
  vim.fn.sign_define('DiagnosticSign' .. diag, {
    text = '',
    texthl = 'DiagnosticSign' .. diag,
    linehl = '',
    numhl = 'DiagnosticSign' .. diag,
  })
end

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 250 })
  end,
})

vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>')
vim.keymap.set('n', '<leader>X', '<cmd>source %<CR>')

vim.keymap.set('n', '<leader>e', ':Ex<CR>')

vim.keymap.set('n', '<leader>ww', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':noa w<CR>')

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+yy')

vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
