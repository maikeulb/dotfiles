setlocal autoindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

setlocal foldmethod=syntax
setlocal foldlevel=1

inoremap <c-n> <c-x><c-o>
nnoremap <c-]> :OmniSharpGotoDefinition<cr>
nnoremap M :OmniSharpDocumentation<cr>
nnoremap gi mz=ap`z
