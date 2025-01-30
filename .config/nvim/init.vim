" vimrc
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugged')
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'lifepillar/vim-mucomplete'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'cljoly/minimal-format.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-lint'
call plug#end()

silent! runtime! plugin/private.vim

augroup customize_colors
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=NONE
augroup END
set background=dark
silent! colorscheme habamax

augroup equalize_windows
  autocmd!
  autocmd VimResized * wincmd =
augroup END

set number
set list
set listchars=tab:»\ ,trail:·,nbsp:␣
let g:netrw_banner = v:false
set title
set laststatus=1
set nowrap

set scrolloff=8
set mouse=
set splitbelow
set splitright

set foldenable
set foldlevel=99
set foldmethod=expr
set wildmode=list:longest,full

set pumheight=10
set pumwidth=32
set completeopt=menu,menuone,noselect,popup
set complete-=t
set shortmess+=c
set wildignore=*/build/*,*.png,*.jpg,*.gif,*.pyc

set smartindent
set smartcase

set ignorecase
set undofile
set undolevels=8192
set path+=**
set spelllang=en_us

let g:mucomplete#enable_auto_at_startup = v:true
let g:mucomplete#no_mappings = v:true
let g:mucomplete#reopen_immediately = v:false
let g:mucomplete#spel#good_words = v:true
let g:mucomplete#cycle_with_trigger = v:true

if !exists('g:mucomplete#wordlist')
  let g:mucomplete#wordlist = []
endif
let s:prog_chain = ['list', 'vsnip', 'omni', 'path', 'uspl']
let s:doc_chain = ['list', 'vsnip', 'path', 'uspl']
let g:mucomplete#chains = {
      \ 'default': { 'default':     s:prog_chain,
      \              '.*string.*':  s:doc_chain,
      \              '.*comment.*': s:doc_chain, },
      \ 'c':        s:prog_chain,
      \ 'cpp':      s:prog_chain,
      \ 'css':      s:prog_chain,
      \ 'go':       s:prog_chain,
      \ 'markdown': s:doc_chain,
      \ 'sh':       ['list', 'vsnip', 'path', 'keyp', 'uspl'],
      \ 'vim':      ['list', 'vsnip', 'cmd', 'path', 'keyp', 'uspl'],
      \ }

lua require('config.lsp')
lua require('config.lint')

let g:mapleader = ' '

imap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

nmap <Leader>s <Cmd>setlocal invspell<CR>

imap (<CR> (<CR>)<Esc>O
imap (;    (<CR>);<Esc>O
imap (,    (<CR>),<Esc>O
imap {<CR> {<CR>}<Esc>O
imap {;    {<CR>};<Esc>O
imap {,    {<CR>},<Esc>O
imap [<CR> [<CR>]<Esc>O
imap [;    [<CR>];<Esc>O
imap [,    [<CR>],<Esc>O

nmap Q gq<CR>

nmap <C-e> :20Lex<CR>

nmap <Leader>f lua require('minimal-format').format_with_formatprg(0, false)
