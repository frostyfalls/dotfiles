" File: sh.vim
" Maintainer: frosty <passedgoandgot200@disroot.org>
"
" vim:sts=2:sw=2:et

set softtabstop=4 shiftwidth=4 expandtab

if executable('shfmt')
  let &l:formatprg = 'shfmt -s -ci -i ' . &l:shiftwidth
endif

if has('nvim')
  augroup ShLint
    autocmd!
    autocmd BufEnter,InsertLeave,TextChanged * lua require("lint").try_lint()
  augroup END
endif
