" File: init.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

let g:mapleader = ' '

call plug#begin()
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-fugitive'
Plug 'lifepillar/vim-mucomplete'
if has('nvim')
  Plug 'cljoly/minimal-format.nvim'
  Plug 'mfussenegger/nvim-lint'
  Plug 'neovim/nvim-lspconfig'
endif
call plug#end()

augroup Vimrc
  autocmd!
  autocmd VimEnter,ColorScheme * highlight Normal guibg=NONE
  autocmd InsertEnter * normal zz
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

set background=dark
silent! colorscheme retrobox

set number relativenumber
set splitbelow splitright
set list listchars=tab:>\ ,trail:.
set scrolloff=8
set path+=**
set mouse=
let g:netrw_banner = v:false

nnoremap Y y$
nnoremap <silent> <C-n> :20Lexplore<CR>
nnoremap <silent> <Leader>g :Git<CR>
nnoremap <silent> <Leader>s :setlocal spell!<CR>

set completeopt=menu,menuone,noselect
let g:mucomplete#enable_auto_at_startup = v:true
let g:mucomplete#no_mappings = v:true

inoremap <expr> <A-j> pumvisible() ? '<Plug>(MUcompleteCycFwd)' : '<A-j>'
inoremap <expr> <A-k> pumvisible() ? '<Plug>(MUcompleteCycBwd)' : '<A-k>'
inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

if has('nvim')
  nnoremap <silent> <Leader>f :lua =require("minimal-format").format_with_formatprg(0)<CR>

  lua require("lspconfig").clangd.setup({})
  lua require("lspconfig").gopls.setup({})

  lua require("lint").linters_by_ft = { sh = { "shellcheck" } }
endif
