" File: after/ftplugin/c.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

setlocal softtabstop=4 shiftwidth=4 expandtab

if executable('clang-format')
  setlocal formatprg=clang-format
endif
