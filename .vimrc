set number
set laststatus=1
set list
set listchars=tab:..,trail:-
set splitbelow
set splitright
set tabstop=4
set shiftwidth=0
augroup vimrc
  autocmd!
  autocmd FileType vim,css,html,xml setlocal tabstop=2 expandtab
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
set background=dark
colorscheme default
