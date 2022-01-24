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

function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
function! TrimComments()
  " :g/^\/\//norm D
  " :g/^\/\//norm D
  " :g/^\s*#\|\/\//d
  :g/^\s*\/\//d
  " :g/^\s*\/d
endfunction
command! TrimComments call TrimComments()
