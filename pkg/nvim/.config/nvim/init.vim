" File: init.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

let g:mapleader = ' '

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'neovim/nvim-lspconfig'
call plug#end()

augroup CustomizeColorScheme
  autocmd!
  autocmd VimEnter,ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
colorscheme onedark

set number
set relativenumber
set splitbelow
set splitright
set scrolloff=5
let g:netrw_banner = v:false

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

set path+=**
set wildignore+=*/build/*,*/.cache/*,*.o

set completeopt=menu,menuone,noselect
set shortmess+=c
inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

let g:mucomplete#enable_auto_at_startup = v:true
let g:mucomplete#no_mappings = v:true

nnoremap <Leader>e :Explore<CR>
nnoremap <C-p> :e **/*

inoremap <C-d> <C-d>zz
inoremap <C-u> <C-u>zz

inoremap (<CR>  (<CR>)<Esc>O
inoremap (;<CR> (<CR>);<Esc>O
inoremap [<CR>  [<CR>]<Esc>O
inoremap [;<CR> [<CR>];<Esc>O
inoremap {<CR>  {<CR>}<Esc>O
inoremap {;<CR> {<CR>};<Esc>O

lua require('lspconfig').clangd.setup({})
lua require('lspconfig').gopls.setup({})
