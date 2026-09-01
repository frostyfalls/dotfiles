vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { tab = "..", trail = "-" }
vim.opt.winborder = "single"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "NONE" })
	end,
})

vim.pack.add({
	"https://github.com/vague-theme/vague.nvim",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/mbbill/undotree",
})
local ts_parsers = { "vim", "lua", "bash", "c", "go" }

vim.cmd.colorscheme("vague")

require("vague").setup({
	bold = false,
	italic = false,
})
require("mini.pick").setup({
	source = { show = require("mini.pick").default_show },
})
require("mini.completion").setup({
	lsp_completion = { source_func = "omnifunc" },
})
require("mini.align").setup({
	silent = true,
})
require("oil").setup()
require("nvim-treesitter").install(ts_parsers)

vim.keymap.set("n", "<C-p>", ":Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>pf", ":Pick files<CR>")
vim.keymap.set("n", "<Leader>H", ":Pick help<CR>")
vim.keymap.set("n", "E", ":Oil<CR>")
vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")

vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_parsers,
	callback = function()
		vim.treesitter.start()
	end,
})

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

vim.g.undotree_HelpLine = false
