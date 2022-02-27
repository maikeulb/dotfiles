local g = vim.g
local mp = require("./utils/map_utils")

-- Map leader to space
g.mapleader = ' ' -- Map <Space> to leader

-- Vim-Diminactive
g.diminactive_enable_focus = 1

-- Dirvish
mp.nmap("-", ":Dirvish")

-- Vim-Maximizer
mp.nmap("<C-z>", ":MaximizerToggle")

-- Vim-EasyClip
g.EasyClipShareYanks = 1
g.EasyClipShareYanksDirectory = "$HOME/.config/nvim/easyclip"
g.EasyClipShareYanksFile = 'easyclip'
g.EasyClipUsePasteToggleDefaults = 0

-- vim-better-whitespace
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 0
g.strip_only_modified_lines = 0
g.strip_whitelines_at_eof = 1

-- fzf.vim
vim.cmd([[set runtimepath+=$HOME/.fzf]])
g.fzf_layout = { window = 'enew' }
g.fzf_layout = { down = '~40%' }
g.fzf_history_dir = '$HOME/.fzf-history'
vim.cmd([[command! -bang -complete=file -nargs=* Rg :lua _G.firvish_run_rg({<f-args>}, "<bang>" == "!")]])
mp.nmap("<C-f>", ":GFiles<CR>")
mp.nmap("<C-_>", ":BLines<CR>")
-- mp.nmap("<C-t>", ":Tags<CR>")
mp.nmap("<C-b>", ":Buffers<CR>")
mp.nmap("<C-g>", ":Ag<CR>")
mp.nmap("<leader>M", ":Maps<CR>")
mp.nmap("<leader>C", ":Commands<CR>")

-- fugitive
mp.nmap("<leader>ga", ":Git add %:p<CR><CR>")
mp.nmap("<leader>gs", ":Git<CR>")
mp.nmap("<leader>gd", ":Gdiff<CR>")
mp.nmap("<leader>ge", ":Gedit<CR>")
mp.nmap("<leader>gr", ":Gread<CR>")
mp.nmap("<leader>gw", ":Gwrite<CR><CR>")
mp.nmap("<leader>gg", ":Ggrep<Space>")

-- FSwitch
mp.nmap("<leader>sw", ":FSHere<CR>")

-- Clever F
g.clever_f_across_no_line = 1
g.clever_f_smart_case = 1
g.clever_f_fix_key_direction = 0
mp.noremap_nmap(";", "<Plug>(clever-f-repeat-forward)")
mp.noremap_nmap(",", "<Plug>(clever-f-repeat-back)")

-- Barber
g.bufferline = {
  animation = false,
  auto_hide = false,
  tabpages = true,
  closable = false,
  clickable = false,
  icons = false,
  icon_custom_colors = false,
  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = 'x',
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,
  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,
  -- Sets the maximum buffer name length.
  maximum_length = 30,
  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,
  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

--vim-vsnip
local home = os.getenv("HOME")
local data_dir = string.format('%s/site/',vim.fn.stdpath('data'))
g.vsnip_snippet_dir = home .. '/.config/nvim/snippets'
g.vsnip_snippet_dirs = {
  data_dir..'/pack/packer/opt/friendly-snippets/snippets',
}
mp.expr_imap("<Tab>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<Tab>']])
mp.expr_imap("<C-j>", [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])
mp.expr_smap("<Tab>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<Tab>']])
mp.expr_smap("<C-j>", [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])

-- LSP
vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
vim.cmd("command! LspRefs lua vim.lsp.buf.references()")

vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
vim.cmd("command! LspSigHelp lua vim.lsp.buf.signature_help()")

vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
vim.cmd("command! LspRename lua vim.lsp.buf.rename()")

vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")

mp.nmap("gD",        ":LspDec<Cr>")
mp.nmap("gd",        ":LspDef<Cr>")
mp.nmap("gi",        ":LspImplementation<Cr>")
mp.nmap("<leader>D", ":LspTypeDef<Cr>")
mp.nmap("gr",        ":LspRefs<Cr>")

mp.nmap("K",         ":LspHover<Cr>")
mp.nmap("gk",        ":LspSigHelp<Cr>")

mp.nmap("<leader>rn",":LspRename<Cr>")
mp.nmap("ga",        ":LspCodeAction<Cr>")
mp.nmap("<leader>f", ":LspFormatting<Cr>")

mp.nmap("g[",        ":LspDiagnPrev<Cr>")
mp.nmap("g]",        ":LspDiagNext<Cr>")
mp.nmap("gl",        ":LspDiagLine<Cr>")
mp.nmap("gh",        "<cmd>Lspsaga lsp_finder<CR>")

-- Toggle Diagnostics
mp.nmap("tt",  "<Plug>(toggle-lsp-diag)")
mp.nmap("ttv", "<Plug>(toggle-lsp-diag-vtext)")

-- FloatTerm
g.floaterm_opener = 'edit'
g.floaterm_keymap_new = '<Leader>ft'
mp.nmap("<c-t>", ":FloatermNew fff<CR>")

-- GitSigns
mp.expr_nmap(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
mp.expr_nmap('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'")

mp.nmap('<leader>hs', ':Gitsigns stage_hunk<CR>')
mp.vmap('<leader>hs', ':Gitsigns stage_hunk<CR>')
mp.nmap('<leader>hr', ':Gitsigns reset_hunk<CR>')
mp.vmap('<leader>hr', ':Gitsigns reset_hunk<CR>')
mp.nmap('<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
mp.nmap('<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
mp.nmap('<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
mp.nmap('<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
mp.nmap('<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
mp.nmap('<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
mp.nmap('<leader>hd', '<cmd>Gitsigns diffthis<CR>')
mp.nmap('<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
mp.nmap('<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

mp.omap('ih', ':<C-U>Gitsigns select_hunk<CR>')
mp.xmap('ih', ':<C-U>Gitsigns select_hunk<CR>')

-- Vista
g.vista_default_executive = 'nvim_lsp'
g.vista_fzf_preview = {'right:20%'}
mp.nmap('<leader>vv', ':Vista!!<Cr>')
mp.nmap('<leader>vf', ':Vista finder!<Cr>')

-- Ale
g.ale_linters_explicit = 1

-- nvim-dap
mp.nmap("<leader>dS", ":lua require'dap'.stop()<CR>")
mp.nmap("<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
mp.nmap("<leader>dc", ":lua require'dap'.continue()<CR>")
mp.nmap("<leader>dso", ":lua require'dap'.step_over()<CR>")
mp.nmap("<leader>dsi", ":lua require'dap'.step_into()<CR>")
mp.nmap("<leader>dr", ":lua require'dap'.repl.open()<CR>")
