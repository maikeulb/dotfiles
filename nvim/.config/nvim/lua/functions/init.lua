local g = vim.g
local mp = require("./utils/map_utils")

vim.cmd([[
  function! GetCommand(extension)
    if a:extension == "rb"
      return "ruby"
    elseif a:extension == "java"
      return "java"
    elseif a:extension == "ts"
      return "tsc"
    elseif a:extension == "py"
      return "python"
    endif
    return "cat"
  endfunction
  function! RunCurrent()
    let l:currentFile = expand('%:t')
    let l:extension = expand('%:e')
    let l:cmd = GetCommand(l:extension) . " " . l:currentFile
    if g:neoterm.has_any()
      let l:id = g:neoterm.last_id
      let l:instance = g:neoterm.instances[l:id]
      if bufwinnr(l:instance.buffer_id) <= 0
        execute "split"
        execute "resize 20"
        call neoterm#open({ 'target': l:id })
      endif
      call neoterm#do({ 'cmd': "clear", 'target': l:id })
      call neoterm#do({ 'cmd': l:cmd, 'target': l:id })
    else
      execute "split"
      execute "resize 20"
      execute "enew"
      call neoterm#new()
      call neoterm#do({ 'cmd': "clear" })
      call neoterm#do({ 'cmd': l:cmd })
    endif
  endfunction
  command RunCurrentFile call RunCurrent()
]])
mp.nmap("<leader>r", "<cmd>RunCurrentFile<cr>")

-- Smart paste mode
vim.cmd([[
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
]])

-- TrimWhitespace
vim.cmd([[
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
]])

-- Better fold text
vim.cmd([[
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
]])

-- Change window layout
vim.cmd([[
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
  command! Rotate call Rotate()
]])
mp.nmap("<leader><space>", "<cmd>Rotate<CR>")

-- Toggle LSP Diagnostic
g.diagnostics_active = true
local lsp = vim.lsp
function _G.toggle_diagnostics()
  if g.diagnostics_active then
    g.diagnostics_active = false
    lsp.diagnostic.clear(0)
    lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    g.diagnostics_active = true
    lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
      lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end
mp.nmap("<leader>tt", ":call v:lua.toggle_diagnostics()<CR>")
