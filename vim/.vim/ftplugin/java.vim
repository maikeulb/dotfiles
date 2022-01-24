setlocal shiftwidth=2
setlocal tabstop=2

let b:java_highlight_functions = 'style'
let b:java_highlight_all=1
let b:java_highlight_debug=1
let b:java_allow_cpp_keywords=1
let b:java_space_errors=1
let b:java_highlight_functions=1
let b:surround_{char2nr('p')} = "System.out.println(\r)"

setlocal foldmethod=marker
setlocal foldmarker={,}

nnoremap <leader>L aList<Integer> list = new ArrayList<>();<esc>
nmap<leader>s ysiWfSystem.out.println<CR>
nmap<leader>vs VSfSystem.out.println<CR>

" autocmd BufWritePost *.java :call BuildMavenProject()
" nnoremap <buffer> <silent> <F8> :call BuildMavenProject()<CR>

if !exists(":NewSrcEntry")
  command -nargs=1 -complete=customlist,eclim#project#util#CommandCompleteProjectRelative -buffer
    \ NewSrcEntry :call eclim#java#classpath#NewClasspathEntry('src', '<args>')
endif

