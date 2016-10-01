let b:python_highlight_all = 1
let b:python3_host_prog = '/home/mike/.virtualenvs/.neovim/bin/python3'

BracelessEnable +indent +fold

setlocal autoindent
setlocal smartindent
setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

setlocal foldlevel=1

nnoremap <silent> <leader>tt :! 2to3 -w -n --no-diffs %<cr>:e<cr>
nnoremap <silent> <leader>ipdb oimport ipdb; ipdb.set_trace()<Esc>

setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
