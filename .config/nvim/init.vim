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
Plug 'neovim/nvim-lspconfig'      " LSP configuration
Plug 'tpope/vim-fugitive'         " Git integration
call plug#end()

augroup customize_colors
  autocmd!
  autocmd VimEnter,ColorScheme * highlight Normal guibg=NONE
augroup END
set background=dark
silent! colorscheme habamax

set number relativenumber
set laststatus=1
set nowrap
set hidden
set foldenable foldlevel=99
set splitbelow splitright
set smartindent shiftwidth=4 softtabstop=4
set undolevels=8192
set path+=**
set scrolloff=5

augroup ft_indent
  autocmd!
  autocmd FileType c set sts=4 sw=4 et
  autocmd FileType go set ts=4 noet
  autocmd FileType vim set sts=2 sw=2 et
augroup END

augroup ft_format
  autocmd!
  autocmd FileType c set formatprg=clang-format
augroup END

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
inoremap <A-j> <Plug>(MUcompleteCycFwd)
inoremap <A-k> <Plug>(MUcompleteCycBwd)

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

inoremap (<CR> (<CR>)<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

lua require('lspconfig').clangd.setup {}
lua require('lspconfig').gopls.setup {}

function! s:Format(...)
  silent keepjumps normal! '[v']gq
    if v:shell_error > 0
    silent undo
    echohl ErrorMsg
    echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
    echohl None
  endif
endfunction
 
nmap <silent> gq :set operatorfunc=<SID>Format<CR>g@
vmap <silent> gq :<C-U>set operatorfunc=<SID>Format<CR>gvg@

function! s:FormatFile() abort
  let w:view = winsaveview()
  keepjumps normal! gg
  set operatorfunc=<SID>Format
  keepjumps normal! g@G
  keepjumps call winrestview(w:view)
  unlet w:view
endfunction
 
nmap <silent> gQ :call <SID>FormatFile()<CR>
nmap <silent> <Leader>f :call <SID>FormatFile()<CR>
