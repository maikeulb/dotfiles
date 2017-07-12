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

if exists('g:deoplete#sources')
  let g:deoplete#sources['javascript.jsx'] = ['buffer', 'ultisnips', 'ternjs']
  let g:deoplete#sources#flow#flow_bin = 'flow'
endif

if exists('g:deoplete#omni#functions')
  let g:deoplete#omni#functions.javascript = [
        \'tern#Complete',
        \'jspc#omni'
        \]
endif

if exists('g:tern#command')
  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent']
  let g:tern_show_signature_in_pum = '0'
  let g:tern_request_timeout = 1
  let g:tern#filetypes = [
        \ 'jsx',
        \ 'javascript.jsx'
        \ ]
endif

let g:neoformat_javascript_prettiereslint = {
      \ 'exe': 'prettier-eslint',
      \ 'args': ['--stdin', '--single-quote'],
      \ 'stdin': 1,
      \ 'no_append': 1,
      \ }

let g:neoformat_enabled_javascript = ['prettiereslint']

let g:ale_javascript_eslint_use_global=1

let g:ale_linters={ 'javascript': ['eslint'] }

nnoremap <buffer> <localleader>p ^vg_:!python -m json.tool<cr>
vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
nnoremap <buffer> <localleader>d Odebugger;<Esc>
nnoremap <buffer> <localleader>gd :TernDef<CR>
nnoremap <buffer> <localleader>tn :TernRename<CR>
nnoremap <buffer> <localleader>tt :TernType<CR>
nnoremap <buffer> <localleader>tr :TernRefs<CR>
nnoremap <buffer> <localleader>r :!node %<cr>
