setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

setlocal foldmethod=syntax
setlocal foldlevel=1

inoremap <c-n> <c-x><c-o>

" let g:neoformat_enabled_cs = ['uncrustify', 'astyle']
" let g:neoformat_cs_uncrustify = {
"       \ 'exe': 'uncrustify',
"       \ 'args': ['-c $HOME/dotfiles/uncrustifyconfig'],
"       \ 'stdin': 1,
"       \}

" let g:neoformat_cs_astyle = {
"       \ 'exe': 'astyle',
"       \ 'stdin': 1,
"       \}
