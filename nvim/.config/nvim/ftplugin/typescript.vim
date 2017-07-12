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

let g:neoformat_javascript_prettiereslint = {
      \ 'exe': 'prettier-eslint',
      \ 'args': ['--stdin', '--single-quote'],
      \ 'stdin': 1,
      \ 'no_append': 1,
      \ }

let g:neoformat_enabled_typescript = ['prettier']

let g:ale_linters={ 'typescript': ['tslint'] }
