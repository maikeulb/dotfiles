vim.cmd([[
  augroup General
    autocmd!
    autocmd WinEnter term://* startinsert
    autocmd VimResized * wincmd =
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer>q :cclose<CR>:lclose<CR>
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
  augroup Skeleton
    autocmd!
    autocmd BufNewFile *.java 0r ~/.config/nvim/skeletons/skeleton.java
  augroup END
]])


vim.cmd([[
  augroup FSwitch
    autocmd BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
    autocmd BufEnter *.h let b:fswitchdst = 'c,cpp,m,cc' | let b:fswitchlocs = 'reg:|include.*|src/**|'
    autocmd BufEnter *.cc let b:fswitchdst = "h,hpp"
    autocmd BufEnter *.cpp let b:fswitchdst = "h,hpp"
  augroup END
]])

-- vim.cmd([[
--   augroup FixFold
--     autocmd!
--     autocmd BufEnter *.cc | setlocal syntax=cpp
--     autocmd BufEnter *.cpp | setlocal syntax=cpp
--     autocmd BufEnter *.h | setlocal syntax=cpp
--   augroup END
-- ]])

vim.cmd([[
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
]])

vim.cmd([[
  augroup NvimLint
    autocmd BufWritePost <buffer> lua require('lint').try_lint()
  augroup END
]])

vim.cmd([[
  augroup filetypedetect
    autocmd! BufNewFile,BufRead *.csx setf cs
    autocmd! BufNewFile,BufRead *.env setf sh
    autocmd! BufNewFile,BufRead *.envrc setf sh
  augroup END
]])
