" == Other settings ==
let g:netrw_banner = 0
set splitbelow splitright
set tabstop=4 shiftwidth=4 expandtab
set number relativenumber

" == Other mappings ==
let mapleader = ' '

nnoremap <Leader>ww <Cmd>w<CR>
nnoremap <Leader>e <Cmd>Ex<CR>

" == Plugins ==
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir)
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-mucomplete'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-fugitive'
if !has('nvim')
  Plug 'tpope/vim-commentary'
endif
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
endif
call plug#end()

" == Theme ==
set termguicolors
set background=dark		

function! s:CustomizeColorScheme()
  " Background		
  highlight Normal guibg=NONE ctermbg=NONE		

  " GitGutter
  highlight SignColumn            guibg=NONE ctermbg=NONE		
  highlight GitGutterAdd          guibg=NONE ctermbg=NONE		
  highlight GitGutterChange       guibg=NONE ctermbg=NONE		
  highlight GitGutterChangeDelete guibg=NONE ctermbg=NONE		
  highlight GitGutterDelete       guibg=NONE ctermbg=NONE		
endfunction		

autocmd! ColorScheme * call s:CustomizeColorScheme()		
silent! colorscheme gruvbox

" == Snippets ==
let g:vsnip_snippet_dir = stdpath('config') . '/snippets'

inoremap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
snoremap <expr> <C-l> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
inoremap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
snoremap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'

" == Completion ==
set completeopt+=menuone,noselect
set shortmess+=c
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1

let g:mucomplete#chains = {
      \ 'default': { 'default':     ['vsnip', 'path', 'keyp', 'uspl'],
      \              '.*string.*':  ['uspl', 'path'],
      \              '.*comment.*': ['uspl', 'path'] },
      \ 'c':   ['vsnip', 'file', 'omni', 'uspl'],
      \ 'cpp': ['vsnip', 'file', 'omni', 'uspl'],
      \ 'go':  ['vsnip', 'file', 'omni', 'uspl'],
      \ 'lua': ['vsnip', 'file', 'omni', 'uspl'],
      \ 'sh':  ['vsnip', 'file', 'uspl'],
      \ 'vim': ['vsnip', 'file', 'cmd',  'uspl'],
      \ }

let s:c_cond = { t -> t =~# '\%(->\|\.\)$' }
let s:vim_cond = { t -> t=~# '\S$' }
let g:mucomplete#can_complete = {
      \ 'c': { 'omni': s:c_cond },
      \ 'cpp': { 'omni': s:c_cond },
      \ 'go': { 'omni': s:c_cond },
      \ 'lua': { 'omni': s:c_cond },
      \ 'sh': { 'omni': s:c_cond },
      \ 'vim': { 'cmd': s:vim_cond },
      \ }

inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

" == Language servers ==
if has('nvim')
  lua require('config.lsp')
endif

" vim:sw=2 ts=2 et
