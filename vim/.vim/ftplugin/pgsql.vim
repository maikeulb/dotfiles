setlocal foldmethod=indent
setlocal softtabstop=2 shiftwidth=2
setlocal commentstring=--\ %s comments=:--

" Send to tmux with localleader e
nnoremap <buffer> <silent> <localleader>e :let psql_tslime_view = winsaveview()<cr>vip"ry:call SendToTmux(@r)<cr>:call winrestview(psql_tslime_view)<cr>

" kill pager with q
nnoremap <buffer> <silent> <localleader>q :call SendToTmuxRaw("q")<cr>
