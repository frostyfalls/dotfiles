let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
call plug#end()

set number
set relativenumber
set cursorline
set list
let &listchars = 'tab:» ,trail:·'
set breakindent
let g:netrw_banner = 0

set mouse=a

set noswapfile
set undofile

set ignorecase
set smartcase

set splitright
set splitbelow
set scrolloff=4

set shm+=I

set termguicolors
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'

let g:ale_virtualtext_cursor = 'current'

highlight ALEWarning ctermbg=Yellow ctermfg=Black
highlight ALEError ctermbg=Red ctermfg=Black

let g:ale_linters = {
      \   'c': ['clangd'],
      \   'cpp': ['clangd'],
      \   'go': ['gopls'],
      \   'sh': ['shellcheck'],
      \ }
let g:ale_fixers = {
      \   'c': ['clang-format', 'clangtidy'],
      \   'cpp': ['clang-format', 'clangtidy'],
      \   'go': ['gofmt'],
      \   'sh': ['shfmt'],
      \ }
let g:ale_sh_shfmt_options = '-i 4'

let mapleader = ' '
nnoremap <leader>ww :w<cr>
nnoremap <leader>e :Ex<cr>
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>
nnoremap <leader>Q :bd<cr>
nnoremap <leader>y "+y
vnoremap <leader>y "+y

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \ )
endfunction

set laststatus=2
set statusline=%f\ %h%m%r\ %{&filetype}%=%-14.(%{LinterStatus()}%)%-10.(%l,%c%)\ %P

if has('nvim')
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=250})
  augroup END
endif

let g:user_emmet_leader_key='<C-Z>'
