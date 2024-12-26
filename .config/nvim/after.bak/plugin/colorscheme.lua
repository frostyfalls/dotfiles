local colorscheme = vim.cmd.colorscheme
local set_hl = vim.api.nvim_set_hl

colorscheme('gruvbox')
set_hl(0, 'Normal', { bg = 'none' })
set_hl(0, 'NormalFloat', { bg = 'none' })
