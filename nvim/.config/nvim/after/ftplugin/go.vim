" File: go.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

set tabstop=4 noexpandtab

if executable('gofmt')
  setlocal formatprg=gofmt
endif
