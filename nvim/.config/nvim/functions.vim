" LocationList Toggle
command! LocationListToggle call LocationListToggle()
function! LocationListToggle()
  if getwinvar(winnr(), 'locationlist_window', 0)
    lclose
    let w:locationlist_window = 0
  else
    if !empty(getloclist(0))
      lopen
      let w:locationlist_window = 1
    else
      echomsg 'LocList is empty'
    endif
  endif
endfunction


" Quickfix Toggle
command! QuickfixToggle call QuickfixToggle()
function! QuickfixToggle()
  if gettabvar(tabpagenr(), 'quickfix_window', 0)
    if t:quickfix_window == winnr()
      wincmd p
    endif
    cclose
    let t:quickfix_window = 0
  else
    copen
    let t:quickfix_window = winnr()
  endif
endfunction

" Terminal Toggle
if has('nvim')
  command! TerminalToggle call TerminalToggle()
  let s:termbuf = 0
  function! TerminalToggle()
    botright 10 split
    try
      execute 'buffer' . s:termbuf
      startinsert
    catch
      " terminal
      let s:termbuf = bufnr('%')
      tnoremap <buffer> <leader>te  <C-\><C-n>:close<CR>
    endtry
  endfunction
  nnoremap <leader>te :TerminalToggle<CR>
endif

" " Z within vim
" command! -nargs=* Z call Z(<f-args>)
" function! Z(...)
"   let l:cmd = 'fasd -d -e printf'
"   for l:arg in a:000
"     let l:cmd = l:cmd . ' ' . l:arg
"   endfor
"   let l:path = system(l:cmd)
"   if isdirectory(l:path)
"     echo l:path
"     execute 'cd ' . l:path
"   endif
" endfunction

" " N within vim
" command! -nargs=* E call E(<f-args>)
" function! E(...)
"   let l:cmd = 'fasd -f -e printf'
"   for l:arg in a:000
"     let l:cmd = l:cmd . ' ' . l:arg
"   endfor
"   let l:file = system(l:cmd)
"   if filereadable(l:file)
"     echo l:file
"     execute 'edit ' . l:file
"   endif
" endfunction

" Smart paste mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let l:tmux_start = "\<Esc>Ptmux;"
  let l:tmux_end = "\<Esc>\\"
  return l:tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . l:tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ''
endfunction

" Change window layout
function! Rotate()
  let l:initial = winnr()
  execute 1 . 'wincmd w'
  wincmd l
  if winnr() != 1
    wincmd J
  else
    wincmd H
  endif
  execute l:initial . 'wincmd w'
endfunction

" Better fold text
function! NeatFoldText()
  let l:fs = v:foldstart
  while getline(l:fs) =~# '^\s*$' | let l:fs = nextnonblank(l:fs + 1)
  endwhile
  if l:fs > v:foldend
    let l:line = getline(v:foldstart)
  else
    let l:line = substitute(getline(l:fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let l:w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let l:foldSize = 1 + v:foldend - v:foldstart
  let l:foldSizeStr = ' ' . l:foldSize . ' lines '
  let l:foldLevelStr = repeat('+--', v:foldlevel)
  let l:lineCount = line('$')
  let l:foldPercentage = printf('[%.1f', (l:foldSize*1.0)/l:lineCount*100) . '%] '
  let l:expansionString = repeat('.', l:w - strwidth(l:foldSizeStr.line.l:foldLevelStr.l:foldPercentage))
  return l:line . l:expansionString . l:foldSizeStr . l:foldPercentage . l:foldLevelStr
endf

set foldtext=NeatFoldText()

" Better Jumplist
function! JumpInFile(back, forw)
  let [n, i] = [bufnr('%'), 1]
  let p = [n] + getpos('.')[1:]
  sil! exe 'norm!1' . a:forw
  while 1
    let p1 = [bufnr('%')] + getpos('.')[1:]
    if n == p1[0] | break | endif
    if p == p1
      sil! exe 'norm!' . (i-1) . a:back
      break
    endif
    let [p, i] = [p1, i+1]
    sil! exe 'norm!1' . a:forw
  endwhile
endfunction

" fun! RelatedFile(file)
"     #This is to check that the directory looks djangoish
"     if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
"         exec "edit %:h/" . a:file
"         let g:last_relative_dir = expand("%:h") . '/'
"         return ''
"     endif
"     if g:last_relative_dir != ''
"         exec "edit " . g:last_relative_dir . a:file
"         return ''
"     endif
"     echo "Cant determine where relative file is : " . a:file
"     return ''
" endfun

" fun SetAppDir()
"     if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
"         let g:last_relative_dir = expand("%:h") . '/'
"         return ''
"     endif
" endfun
" autocmd BufEnter *.py call SetAppDir()

