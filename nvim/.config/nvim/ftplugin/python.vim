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

if exists('g:test#python#runner')
  let b:test#python#runner = 'pytest'
endif

if exists('g:deoplete#sources')
  let g:deoplete#sources.python = ['buffer', 'jedi']
  let g:deoplete#sources#jedi#enable_cache = 1
endif

let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'stdin': 1,
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_python = ['autopep8']

let g:formatter_yapf_style = 'pep8'

" let g:neoformat_python_yapf = {
"       \ 'exe': 'yapf',
"       \ 'args': ['based_on_style=pep8'],
"       \ }

" let g:neoformat_enabled_python = ['yapf']
" let g:neoformat_enabled_python = ['isort']

let g:ale_linters={ 'python': ['flake8'] }

nnoremap <buffer> <silent> <localleader>tt :! 2to3 -w -n --no-diffs %<cr>:e<cr>
nnoremap <buffer> <silent> <localleader>d oimport ipdb; ipdb.set_trace()<Esc>
nnoremap <buffer> <localleader>r :!python3 %<cr>

" BracelessEnable +indent +fold
