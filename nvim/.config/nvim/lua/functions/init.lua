function nmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true })
end

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

nmap("<leader>r", "<cmd>RunCurrentFile<cr>")

vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

nmap("<leader>tt", ":call v:lua.toggle_diagnostics()<CR>")
