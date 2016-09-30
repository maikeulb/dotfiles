call pencil#init()

setlocal spell

" Use <localleader>1/2/3 to add headings.
nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll

nnoremap <buffer> <localleader>p VV:'<,'>!python -m json.tool<cr>
vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
