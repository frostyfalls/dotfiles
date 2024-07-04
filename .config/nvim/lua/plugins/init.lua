return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			lspconfig['lua_ls'].setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						},
						format = {
							enable = true,
							defaultConfig = { quote_style = 'single' }
						}
					}
				}
			})
			lspconfig['rust_analyzer'].setup({
				capabilities = capabilities,
			})
			lspconfig['bashls'].setup({
				capabilities = capabilities,
				settings = {
					filetypes = { 'sh', 'zsh' }
				}
			})
		end
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = { 'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' }
				}
			})
		end
	},

	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000,
		init = function()
			vim.o.background = 'dark'
			vim.cmd('colorscheme gruvbox')
			vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
		end
	},

	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {
			scope = {
				enabled = false
			}
		}
	},

	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'archibate/lualine-time' },
		opts = {
			options = {
				icons_enabled = false,
				section_separators = '',
				component_separators = ''
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			}
		}
	},

	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')

			dashboard.section.buttons.val = {
				dashboard.button('SPC p f', 'Find files'),
				dashboard.button('SPC p o', 'Recent files'),
				dashboard.button('SPC p e', 'File explorer'),
				dashboard.button('SPC p g', 'File grep'),
				dashboard.button('SPC l', 'Lazy'),
				dashboard.button('Z Q', 'Quit')
			}

			alpha.setup(dashboard.opts)
			vim.cmd('autocmd FileType alpha setlocal nofoldenable')
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = { 'c', 'lua', 'vim', 'yaml', 'toml', 'markdown', 'vimdoc', 'bash', 'html', 'python', 'haskell', 'rust' },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true }
		}
	},

	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			pickers = {
				find_files = {
					find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }
				},
				buffers = {
					show_all_buffers = true
				},
				mappings = {
					n = { ['q'] = require('telescope.actions').close },
				}
			}
		}
	},

	{
		'numToStr/Comment.nvim',
		event = 'VeryLazy',
		config = true
	},

	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			signs = false
		}
	},

	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = true
	},

	{
		'NeogitOrg/neogit',
		dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim' },
		config = true
	}
}
