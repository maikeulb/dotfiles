let b:noNeomake=1

setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal autoindent

setlocal foldmethod=marker
setlocal foldlevel=0

nnoremap <buffer> <localleader>r :source %<cr>
nnoremap <buffer> <localleader>n :Neomake<cr>
