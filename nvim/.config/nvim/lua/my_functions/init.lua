local options = { noremap = true, silent = true }
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

-- M.squeeze_blank_lines = function()
--     -- references: https://vi.stackexchange.com/posts/26304/revisions
--     if (vim.bo.filetype ~= 'binary') or (vim.bo.filetype ~= 'diff') then
--         local old_query = vim.fn.getreg('/')    -- save search register
--         M.preserve('sil! 1,.s/^\\n\\{2,}/\\r/gn') -- set current search count number
--         local result = vim.fn.searchcount({maxcount = 1000, timeout = 500}).current
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         M.preserve('sil! keepp keepj %s/^\\n\\{2,}/\\r/ge')
--         M.preserve('sil! keepp keepj %s/\\v($\\n\\s*)+%$/\\r/e')
--         if result > 0 then
--             vim.api.nvim_win_set_cursor({0}, {(line - result), col})
--         end
--         vim.fn.setreg('/', old_query)           -- restore search register
--     end
-- end

-- -- Change window layout
-- vim.api.nvim_exec([[

--   function! Rotate()
--     let l:initial = winnr()
--     execute 1 . 'wincmd w'
--     wincmd l
--     if winnr() != 1
--       wincmd J
--     else
--       wincmd H
--     endif
--     execute l:initial . 'wincmd w'
--   endfunction

-- ]])

-- -- nmap("<leader><space>", "call Rotate()<CR>")
-- nmap("<leader><space>", [[:call Rotate()<CR>]])
-- -- nmap('n', '<C-h>', [[:call WinMove('h')<CR>]], opts)
-- -- map('n', '<C-j>', [[:call WinMove('j')<CR>]], opts)
-- -- map('n', '<C-k>', [[:call WinMove('k')<CR>]], opts)
-- -- map('n', '<C-l>', [[:call WinMove('l')<CR>]], opts)
-- -- Better fold text
-- vim.cmd([[
--   function! NeatFoldText()
--     let l:fs = v:foldstart
--     while getline(l:fs) =~# '^\s*$' | let l:fs = nextnonblank(l:fs + 1)
--     endwhile
--     if l:fs > v:foldend
--       let l:line = getline(v:foldstart)
--     else
--       let l:line = substitute(getline(l:fs), '\t', repeat(' ', &tabstop), 'g')
--     endif
--     let l:w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
--     let l:foldSize = 1 + v:foldend - v:foldstart
--     let l:foldSizeStr = ' ' . l:foldSize . ' lines '
--     let l:foldLevelStr = repeat('+--', v:foldlevel)
--     let l:lineCount = line('$')
--     let l:foldPercentage = printf('[%.1f', (l:foldSize*1.0)/l:lineCount*100) . '%] '
--     let l:expansionString = repeat('.', l:w - strwidth(l:foldSizeStr.line.l:foldLevelStr.l:foldPercentage))
--     return l:line . l:expansionString . l:foldSizeStr . l:foldPercentage . l:foldLevelStr
--   endf
--   set foldtext=NeatFoldText()
-- ]])

-- -- Better Jumplist
-- vim.cmd([[
--   function! JumpInFile(back, forw)
--     let [n, i] = [bufnr('%'), 1]
--     let p = [n] + getpos('.')[1:]
--     sil! exe 'norm!1' . a:forw
--     while 1
--       let p1 = [bufnr('%')] + getpos('.')[1:]
--       if n == p1[0] | break | endif
--       if p == p1
--         sil! exe 'norm!' . (i-1) . a:back
--         break
--       endif
--       let [p, i] = [p1, i+1]
--       sil! exe 'norm!1' . a:forw
--     endwhile
--   endfunction
-- ]])
-- nmap("<c-o>", ':call JumpInFile("<c-i>", "<c-o>")<cr>')
-- nmap("<c-i>", ':call JumpInFile("<c-o>", "<c-i>")<cr>')

-- -- TrimWhitespace
-- vim.cmd([[
--   function! TrimWhitespace()
--     let l:save = winsaveview()
--     keeppatterns %s/\s\+$//e
--     call winrestview(l:save)
--   endfun
--   command! TrimWhitespace call TrimWhitespace()
--   function! TrimComments()
--     " :g/^\/\//norm D
--     " :g/^\/\//norm D
--     " :g/^\s*#\|\/\//d
--     :g/^\s*\/\//d
--     " :g/^\s*\/d
--   endfunction
--   command! TrimComments call TrimComments()
-- ]])

-- -- Smart paste mode
-- vim.cmd([[
--   function! WrapForTmux(s)
--     if !exists('$TMUX')
--       return a:s
--     endif
--     let l:tmux_start = "\<Esc>Ptmux;"
--     let l:tmux_end = "\<Esc>\\"
--     return l:tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . l:tmux_end
--   endfunction
--   let &t_SI .= WrapForTmux("\<Esc>[?2004h")
--   let &t_EI .= WrapForTmux("\<Esc>[?2004l")
-- ]])
