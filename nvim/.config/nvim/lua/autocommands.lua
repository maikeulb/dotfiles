vim.cmd([[
  augroup General
    autocmd!
    autocmd WinEnter term://* startinsert
    autocmd VimResized * wincmd =
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer>q :cclose<CR>:lclose<CR>
    " autocmd BufWritePre * call AutoFormatFiles()
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd BufReadPost * if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute "normal! g`\"" |
          \ endif
    autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
    autocmd FocusLost,WinLeave * :silent! noautocmd w
  augroup END
]])

vim.cmd([[
  augroup WorkingDirectory
    autocmd!
    autocmd BufLeave * let b:last_cwd = getcwd()
    autocmd BufEnter * if exists('b:last_cwd') |
          \   execute 'lcd' b:last_cwd |
          \ else |
          \   silent! Glcd |
          \ endif
    autocmd BufLeave * let b:last_cwd = getcwd()
  augroup END
]])

vim.cmd([[
  augroup EditLastFile
    autocmd!
    autocmd VimEnter * nested
          \  if argc() == 0
          \|   let last = filter(filter(copy(v:oldfiles), 'match(v:val, getcwd()) == 0'), 'filereadable(v:val)')
          \|   if !empty(last)
          \|     execute 'edit' fnameescape(last[0])
          \|   endif
          \| endif
  augroup END
]])

vim.cmd([[
  fun! AutoFormatFiles()
    if exists('b:noAutoFormat')
      return
    endif
    undojoin | :Autoformat
  endfun
]])

vim.cmd([[
  augroup AutoFormatFileExtensions
    autocmd!
    autocmd BufEnter *.fsproj | setlocal noAutoFormat=1
  augroup END
]])

vim.cmd([[
  augroup Skeleton
    autocmd!
    autocmd BufNewFile *.java 0r ~/.config/nvim/skeletons/skeleton.java
  augroup END
]])


vim.cmd([[
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
]])

vim.cmd([[
  augroup filetypedetect
    au! BufNewFile,BufRead *.csx setf cs
    au! BufNewFile,BufRead *.env setf sh
    au! BufNewFile,BufRead *.envrc setf sh
  augroup END
]])
