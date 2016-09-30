BracelessEnable +indent +fold
nnoremap <silent> <leader>ipdb oimport ipdb; ipdb.set_trace()<Esc>

setlocal autoindent
setlocal smartindent
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal foldlevel=1

setlocal formatoptions-=t

nnoremap <leader>ss :w<cr>:! 2to3 -w -n --no-diffs %<cr>:e<cr>
