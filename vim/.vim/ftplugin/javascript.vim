setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal iskeyword=$

setlocal foldmethod=syntax
setlocal foldlevel=1

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
" }

" let b:neoformat_javascript_prettiereslint = {
"       \ 'exe': 'prettier-eslint',
"       \ 'args': ['--stdin', '--single-quote'],
"       \ 'stdin': 1,
"       \ 'no_append': 1,
"       \ }

" let b:neoformat_enabled_javascript = ['prettiereslint']

let b:noAutoFormat=1
let b:neoformat_enabled_text = ['']
let b:neoformat_basic_format_align = 0
let b:neoformat_basic_format_retab = 0
let b:neoformat_basic_format_trim = 0

" let b:ale_jsx_eslint_use_global=1
let b:ale_javascript_eslint_use_global=1

let b:ale_linters={ 'javascript': ['eslint'] }
