" File: after/ftplugin/go.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

setlocal tabstop=4 noexpandtab

if executable('gopls')
  setlocal formatprg=gopls
endif
