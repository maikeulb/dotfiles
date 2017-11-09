let b:java_highlight_functions = 'style'
let b:java_highlight_all=1
let b:java_highlight_debug=1
let b:java_allow_cpp_keywords=1
let b:java_space_errors=1
let b:java_highlight_functions=1

setlocal foldmethod=marker
setlocal foldmarker={,}

inoremap <c-n> <c-x><c-]>
