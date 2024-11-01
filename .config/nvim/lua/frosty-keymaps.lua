vim.keymap.set('n', '<leader>e', '<cmd>Ex<cr>')

vim.keymap.set('n', '<leader>ww', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>W', '<cmd>noa w<cr>')

vim.keymap.set('n', '<Tab>', '<cmd>bn<cr>')
vim.keymap.set('n', '<S-Tab>', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>Q', '<cmd>bd!<cr>')

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+yy')

vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<cr>')
vim.keymap.set('n', '<leader>X', '<cmd>source %<cr>')
