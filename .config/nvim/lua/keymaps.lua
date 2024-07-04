-- Set leader
vim.g.mapleader = ' '

-- Unset keymaps
vim.keymap.set('n', '<Space>', '<Nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'q', '<nop>')

-- File management
vim.keymap.set('n', '<leader>pf', '<Cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>po', '<Cmd>Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>pg', '<Cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>pe', '<Cmd>Ex<CR>')

-- Other Telescope commands
vim.keymap.set('n', '<leader>pS', '<Cmd>Telescope search_history<CR>')
vim.keymap.set('n', '<leader>ph', '<Cmd>Telescope command_history<CR>')

-- Buffer management
vim.keymap.set('n', '<leader>pr', '<Cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>ww', '<Cmd>bd<CR>')
vim.keymap.set('n', '<leader>wW', '<Cmd>bd!<CR>')
vim.keymap.set('n', '<leader>n', '<Cmd>enew<CR>')
vim.keymap.set('n', '<Tab>', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprev<CR>')

-- File actions
vim.keymap.set('n', '<leader>r', '<Cmd>w<CR>')
vim.keymap.set('n', '<leader>R', '<Cmd>e $MYVIMRC<CR>')

-- Lazy
vim.keymap.set('n', '<leader>l', '<Cmd>Lazy<CR>')

-- Neogit
vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>')
vim.keymap.set('n', '<leader>gc', '<Cmd>Neogit commit<CR>')

vim.keymap.set('n', '<leader>h', '<Cmd>Alpha<CR>')
