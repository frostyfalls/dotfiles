set expandtab
set shiftwidth=4
set softtabstop=4

if executable('shfmt')
  let &l:formatprg='shfmt -s -i ' . &l:shiftwidth
endif
