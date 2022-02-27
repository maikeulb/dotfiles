setlocal autoindent
setlocal smartindent
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal foldlevel=1
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o

let b:python_highlight_all = 1

nnoremap <buffer> <silent> <localleader>tt :! 2to3 -w -n --no-diffs %<cr>:e<cr>
nnoremap <buffer> <silent> <localleader>d oimport ipdb; ipdb.set_trace()<Esc>
nnoremap <buffer> <localleader>r :!python3 %<cr>

" BracelessEnable +indent +fold
