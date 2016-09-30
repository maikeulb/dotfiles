nnoremap <buffer> gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
call fugitive#detect(@%)
setlocal nospell
execute ':sort r /[^\/]$/'
