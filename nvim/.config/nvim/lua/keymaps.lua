local telescope = require('telescope.builtin')

-- Format file
vim.keymap.set('n', '<leader>e', vim.lsp.buf.format)

-- Write file
vim.keymap.set('n', '<leader>W', ':w<CR>')

-- Toggle status
vim.keymap.set('n', '<leader>os', function()
  if vim.opt.laststatus == 3 then
    vim.opt.laststatus = 0
  else
    vim.opt.laststatus = 3
  end
end)

-- Telescope find files
vim.keymap.set('n', '<leader>ff', telescope.find_files)

-- Telescope live grep
vim.keymap.set('n', '<leader>fg', telescope.live_grep)

-- Neotree toggle sidebar
vim.keymap.set('n', '<leader>nt', '<Cmd>Neotree right toggle<CR>')

-- Neotree toggle file menu
vim.keymap.set('n', '<leader>nr', '<Cmd>Neotree current toggle<CR>')


vim.keymap.set('n', '<leader>q', '<Cmd>close<CR>')
vim.keymap.set('n', '<leader>Q', '<Cmd>quit<CR>')
vim.keymap.set('n', '<leader>bd', '<Cmd>bn<CR>bd<CR>')
vim.keymap.set('n', '<leader>bD', '<Cmd>bd!<CR>')
