setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

setlocal foldmethod=syntax
setlocal foldlevel=1

let g:formatdef_myrb = '"ruby-beautify -c 2 -s"'
let g:formatters_ruby = ['myrb']

