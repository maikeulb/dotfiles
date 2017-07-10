compiler fish
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal autoindent

" let b:noAutoformat=1
setlocal foldmethod=marker
setlocal foldlevel=0

" let g:formatters_fish = ['fish_indent']


nnoremap <buffer> <localleader>r :source %<cr>
nnoremap <buffer> <localleader>n :Neomake<cr>

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gggqG')

endfunction
autocmd BufWritePre <buffer> call Indent()

