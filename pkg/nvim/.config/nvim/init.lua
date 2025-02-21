vim.g.mapleader = vim.keycode('<Space>')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '.' }

vim.opt.scrolloff = 8
vim.g.netrw_banner = false

vim.opt.shortmess:append('c')
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require('paq')({
  'savq/paq-nvim',

  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-lint',
  'stevearc/conform.nvim',
  'windwp/nvim-autopairs',

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'RRethy/nvim-treesitter-endwise',

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  -- 'L3MON4D3/LuaSnip',
  -- 'saadparwaiz1/cmp_luasnip',
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = vim.api.nvim_create_augroup('CustomizeColorScheme', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'Normal', { bg = nil })
  end,
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'rust', 'toml' },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  endwise = { enable = true },
})

require('nvim-autopairs').setup({})
require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
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

require('lint').linters_by_ft = {
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('Lint', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})

vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':20Lexplore<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':Format<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':setlocal spell!<CR>', { noremap = true, silent = true })

local cmp = require('cmp')

cmp.setup({
  -- snippet = {
  --   expand = function(args)
  --     require('luasnip').lsp_expand(args.body)
  --   end,
  -- },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  clangd = {},
  gopls = {},
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
for server, settings in pairs(servers) do
  lspconfig[server].setup({ capabilities = capabilities, settings = settings })
end

vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])
