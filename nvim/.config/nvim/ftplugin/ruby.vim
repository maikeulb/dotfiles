setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

setlocal foldmethod=syntax
setlocal foldlevel=1

" let b:formatdef_myrb = '"ruby-beautify -c 2 -s"'
" let b:formatters_ruby = ['myrb']

let b:neoformat_enabled_ruby = ['rubybeautify']
let b:ale_linters = {'ruby': ['rubocop']}
