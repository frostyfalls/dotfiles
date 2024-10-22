local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local lazy_repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazy_repo, lazy_path })
end
vim.opt.rtp:prepend(lazy_path)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Enable mouse support
vim.opt.mouse = 'a'

-- Show line numbers with relative numbers
vim.o.number = true
vim.o.relativenumber = true

-- Highlight current line
vim.o.cursorline = true

-- Hide the mode as it's in the status line
vim.o.showmode = false

-- Disable swap file creation
vim.o.swapfile = false

-- Disable netrw banner
vim.g.netrw_banner = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching unless escaped
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Display whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimum number of lines to appear above or below the cursor
vim.opt.scrolloff = 8

require('lazy').setup({
  {
    'tpope/vim-sleuth',
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
      vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    end,
  },
  {
    'hiphish/rainbow-delimiters.nvim',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'go', 'c', 'cpp', 'lua', 'vimdoc', 'yaml', 'toml' },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/cmp-buffer', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext and [p]revious items
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll [f]orward and [b]ackward in the documentation
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Abort ([e]xit) the completion window
          ['<C-e>'] = cmp.mapping.abort(),
          -- Accept ([y]es) the completion
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          -- Manually trigger a completion
          ['<C-Space>'] = cmp.mapping.complete({}),

          -- Jump to the next and previous expansion
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
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      for _, diag in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
        vim.fn.sign_define('DiagnosticSign' .. diag, {
          text = '',
          texthl = 'DiagnosticSign' .. diag,
          linehl = '',
          numhl = 'DiagnosticSign' .. diag,
        })
      end

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
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          icons_enabled = false,
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua', lsp_format = 'fallback' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          go = { 'goimports', 'gofmt', lsp_format = 'fallback' },
          sh = { 'shfmt', lsp_format = 'fallback' },
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
  },
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 250 })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.softtabstop = 2
    vim.o.tabstop = 2
    vim.o.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'zsh' },
  callback = function()
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.tabstop = 4
    vim.o.expandtab = true
  end,
})
