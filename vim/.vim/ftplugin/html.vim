setlocal autoindent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal nosmartindent

setlocal foldmethod=syntax
setlocal foldlevel=1

let b:noAutoFormat=1
let b:neoformat_enabled_text = ['']
let b:neoformat_basic_format_align = 0
let b:neoformat_basic_format_retab = 0
let b:neoformat_basic_format_trim = 0

" let b:neoformat_enabled_html = ['htmlbeautify']
" let g:deoplete_disable_auto_complete = 1

inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>
inoremap <buffer> <c-v> {{<space><space>}}<left><left><left>
" nnoremap <buffer> <localleader>a :Autoformat<cr>
" vnoremap <buffer> <localleader>a :Autoformat<cr>
