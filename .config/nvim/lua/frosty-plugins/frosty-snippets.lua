return {
  {
    'L3MON4D3/LuaSnip',
    config = function()
      local luasnip = require('luasnip')

      vim.keymap.set({ 'i', 's' }, '<C-l>', function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({ 'i', 's' }, '<C-h>', function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
