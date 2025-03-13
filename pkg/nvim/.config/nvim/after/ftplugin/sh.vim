" File: after/ftplugin/sh.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

setlocal softtabstop=4 shiftwidth=4 expandtab

if executable('shfmt')
  let &l:formatprg = 'shfmt -s -ci -i ' .. &l:shiftwidth
endif
