setlocal omnifunc=tern#Complete

setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal iskeyword=$

setlocal foldmethod=indent
setlocal foldlevel=1

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
" }

nnoremap <buffer> <localleader>p ^vg_:!python -m json.tool<cr>
vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
nnoremap <buffer> <localleader>d Odebugger;<Esc>
nnoremap <buffer> <localleader>gd :TernDef<CR>
nnoremap <buffer> <localleader>tn :TernRename<CR>
nnoremap <buffer> <localleader>tt :TernType<CR>
nnoremap <buffer> <localleader>tr :TernRefs<CR>
nnoremap <buffer> <localleader>r :!node %<cr>

let g:deoplete#sources#flow#flow_bin = 'flow'

let g:neoformat_jsx_prettier = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--single-quote'],
      \ 'stdin': 1,
      \ 'no_append': 1,
      \ }

" let g:neoformat_jsx_prettiereslint = {
"             \ 'exe': 'prettier-eslint',
"             \ 'args': ['--stdin', '--single-quote'],
"             \ 'stdin': 1,
"             \ }

let g:neoformat_enabled_jsx = ['prettier']
" let g:neoformat_enabled_jsx = ['prettiereslint']

let g:ale_jsx_eslint_use_global=1
" let g:ale_jsx_eslint_executable=

let g:ale_linters={ 'jsx': ['eslint'] }
