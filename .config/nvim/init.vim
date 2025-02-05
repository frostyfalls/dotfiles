" init.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" Requirements:
"   vim-plug (https://github.com/junegunn/vim-plug)
"
" vim:sts=2:sw=2:et

let g:mapleader = ' '

call plug#begin()
Plug 'tpope/vim-endwise'          " Wisely add ends
Plug 'lifepillar/vim-mucomplete'  " Completion chaining
Plug 'tpope/vim-fugitive'         " Git integration
Plug 'fcpg/vim-waikiki'           " Wiki
if has('nvim')
  Plug 'neovim/nvim-lspconfig'    " LSP configuration
endif
call plug#end()

augroup customize_colors
  autocmd!
  autocmd VimEnter,ColorScheme * highlight Normal guibg=NONE
augroup END
set background=dark
silent! colorscheme retrobox

let g:waikiki_roots = ['~/documents/wiki/']
nnoremap <Leader>w :e ~/documents/wiki/index.md<CR>

set number relativenumber
set laststatus=2
set nowrap
set hidden
set foldenable foldlevel=99
set splitbelow splitright
set smartindent shiftwidth=4 softtabstop=4
set undolevels=8192
set path+=**
set scrolloff=5
set mouse=
set list listchars=tab:⇾\ ,trail:·

nnoremap Y y$

augroup insert_center
  autocmd!
  autocmd InsertEnter * normal zz
augroup END

set shortmess+=c
set completeopt-=preview
set completeopt+=menuone,noselect
inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1
inoremap <expr> <A-j> pumvisible() ? '<Plug>(MUcompleteCycFwd)' : '<A-j>'
inoremap <expr> <A-k> pumvisible() ? '<Plug>(MUcompleteCycBwd)' : '<A-k>'

let s:prog_chains = ['path', 'omni', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains = {
      \ 'default': ['path', 'omni', 'keyn', 'dict', 'uspl'],
      \ 'c': s:prog_chains,
      \ 'go': s:prog_chains,
      \ 'markdown': ['path', 'omni', 'keyn', 'dict', 'uspl'],
      \ 'vim': ['path', 'cmd', 'keyn'],
      \ }

let g:netrw_banner = 0
nnoremap <Leader>x :Ex<CR>

inoremap (<CR>  (<CR>) <ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [<CR>  [<CR>] <ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {<CR>  {<CR>} <ESC>O
inoremap {;<CR> {<CR>};<ESC>O

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

function! s:Gq(...)
  silent keepjumps normal! '[v']gq
  if v:shell_error > 0
    silent undo
    echohl ErrorMsg
    echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
    echohl None
  endif
endfunction

nmap <silent> gq :set operatorfunc=<SID>Gq<CR>g@
vmap <silent> gq :<C-u>set operatorfunc=<SID>Gq<CR>gvg@

function! s:FormatFile() abort
  let w:view = winsaveview()
  keepjumps normal! gg
  set operatorfunc=<SID>Gq
  keepjumps normal! g@G
  keepjumps call winrestview(w:view)
  unlet w:view
endfunction

nmap <silent> gQ :call <SID>FormatFile()<CR>
nmap <silent> <Leader>f :call <SID>FormatFile()<CR>

if has('nvim')
  lua require('lspconfig').clangd.setup({})
  lua require('lspconfig').gopls.setup({})
endif
