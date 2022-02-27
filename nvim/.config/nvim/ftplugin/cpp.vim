setlocal autoindent
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" setlocal foldmethod=syntax
" setlocal foldlevel=1
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

set makeprg=g++\ %\ &&\ ./a.out
