vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = { "number" }
vim.opt.list = true
vim.opt.listchars = { tab = "..", trail = "-" }
vim.opt.laststatus = 1
vim.opt.winborder = "single"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

vim.g.undotree_HelpLine = false

vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "go", "bash", "lua" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/mbbill/undotree",
})

require("mini.pick").setup({
	source = { show = require("mini.pick").default_show },
})
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.align").setup({ silent = true })
require("oil").setup({
	columns = { "permissions", "size", "mtime" },
})
require("vague").setup({ italic = false })

vim.keymap.set("n", "<Leader>pf", ":Pick files<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", ":Pick grep_live<CR>", { noremap = true })
vim.keymap.set("n", "E", ":Oil<CR>", { noremap = true })
vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>", { noremap = true })

vim.cmd.colorscheme("vague")
