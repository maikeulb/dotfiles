setlocal autoindent
setlocal smartindent
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal foldlevel=1
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o

nnoremap <buffer> <silent> <localleader>tt :! 2to3 -w -n --no-diffs %<cr>:e<cr>
nnoremap <buffer> <silent> <localleader>d oimport ipdb; ipdb.set_trace()<Esc>
nnoremap <buffer> <localleader>r :!python3 %<cr>

let g:python_highlight_all = 1
let g:neoterm_repl_python = 'ipython --no-banner --no-autoindent'
let g:test#python#runner = 'pytest'
let g:formatdef_mypy = '"isort - | docformatter - | yapf --style=google"'
let g:formatters_python = ['mypy']
let g:deoplete#sources#jedi#enable_cache = 1

BracelessEnable +indent +fold
