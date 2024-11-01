-- {{{ Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lazy_repo = 'https://github.com/folke/lazy.nvim.git'

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazy_repo, lazy_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazy_path)
-- }}}

-- {{{ Set leader key for keymaps
require('frosty-leader-key')
-- }}}

-- {{{ Call lazy.nvim
local lazy = require('lazy')
lazy.setup('frosty-plugins')
-- }}}

-- {{{ Include other options
require('frosty-options')
require('frosty-autocmds')
require('frosty-keymaps')
-- }}}
