setlocal nospell

call fugitive#detect(@%)
execute ':sort r /[^\/]$/'

nnoremap <buffer> gh :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
