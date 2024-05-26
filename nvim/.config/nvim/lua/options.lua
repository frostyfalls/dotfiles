local g = {
    mapleader = ' ',
    neovide_scroll_animation_length = 0,
    neovide_cursor_animation_length = 0
}

local o = {
    expandtab = true,
    softtabstop = 4,
    shiftwidth = 4,
    termguicolors = true,
    background = 'dark',
    guifont = 'monospace:h10'
}

for name, value in pairs(o) do
    vim.o[name] = value
end

for name, value in pairs(g) do
    vim.g[name] = value
end
