vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 250 })
	end
})

vim.api.nvim_create_autocmd('BufWritePre', {
	callback = function()
		vim.lsp.buf.format()
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'lua' },
	callback = function()
		vim.o.shiftwidth = 2
		vim.o.softtabstop = 2
		vim.o.tabstop = 2
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sh', 'zsh' },
	callback = function()
		vim.o.shiftwidth = 4
		vim.o.softtabstop = 4
		vim.o.tabstop = 4
	end
})
