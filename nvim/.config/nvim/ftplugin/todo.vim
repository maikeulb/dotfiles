setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal smarttab

setlocal autoindent
setlocal formatoptions=croql
setlocal showmatch

set undodir=.

silent! %s/x*\s*\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\)\s//

autocmd BufWritePre todo.txt %call todo#txt#sort_by_project()
autocmd BufEnter todo.txt %call todo#txt#sort_by_project()

