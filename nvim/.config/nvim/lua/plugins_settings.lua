local g = vim.g

local options = { noremap = true, silent = true }

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function vmap(shortcut, command)
  map("v", shortcut, command)
end

local function omap(shortcut, command)
  map("v", shortcut, command)
end

local function xmap(shortcut, command)
  map("x", shortcut, command)
end

local expr_options = { expr = true }
local function expr_map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, expr_options)
end

local function expr_nmap(shortcut, command)
  expr_map("n", shortcut, command)
end

local function expr_imap(shortcut, command)
  expr_map("i", shortcut, command)
end

local function expr_smap(shortcut, command)
  expr_map("s", shortcut, command)
end

local noremap_options = { noremap = false, silent = true }
local function noremap_map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, noremap_options)
end

local function noremap_nmap(shortcut, command)
  noremap_map("n", shortcut, command)
end

-- Map leader to space
g.mapleader = ' ' -- Map <Space> to leader

-- Vim-diminactive
g.diminactive_enable_focus = 1

-- Dirvish
nmap("-", ":Dirvish")

-- Vim-Maximizer
nmap("<C-z>", ":MaximizerToggle")

-- Cmake
g.cmake_link_compile_commands = 1
nmap("<leader>cg", ":CMakeGenerate<cr>")
nmap("<leader>cb", ":CMakeBuild<cr>")
nmap("<leader>gt", ":GTestRunUnderCursor<cr>")

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

-- Vim-Grepper
g['grepper'] = { tools = { 'rg', 'git' }}
g.grepper.simple_prompt = 1
g.grepper.quickfix = 1
g.grepper.highlight = 1
nmap("<leader>G", ":Grepper -tool rg<CR>")
nmap("gs", "<plug>(GrepperOperator)")
xmap("gs", "<plug>(GrepperOperator)")

-- fzf.vim
vim.cmd([[set runtimepath+=$HOME/.fzf]])
g.fzf_layout = { window = 'enew' }
g.fzf_layout = { down = '~40%' }
g.fzf_history_dir = '$HOME/.fzf-history'
vim.cmd([[command! -bang -complete=file -nargs=* Rg :lua _G.firvish_run_rg({<f-args>}, "<bang>" == "!")]])
nmap("<C-f>", ":GFiles<CR>")
nmap("<C-_>", ":BLines<CR>")
-- nmap("<C-t>", ":Tags<CR>")
nmap("<C-b>", ":Buffers<CR>")
nmap("<C-g>", ":Ag<CR>")
nmap("<leader>M", ":Maps<CR>")
nmap("<leader>C", ":Commands<CR>")

-- Fugitive
nmap("<leader>ga", ":Git add %:p<CR><CR>")
nmap("<leader>gs", ":Git<CR>")
nmap("<leader>gd", ":Gdiff<CR>")
nmap("<leader>ge", ":Gedit<CR>")
nmap("<leader>gr", ":Gread<CR>")
nmap("<leader>gw", ":Gwrite<CR><CR>")
nmap("<leader>gg", ":Ggrep<Space>")

-- FSwitch
nmap("<leader>sw", ":FSHere<CR>")

-- VIMFoldC
vim.cmd([[
let g:fold_options = {
  \ 'fold_blank': 0,
  \ 'fold_includes': 0,
  \ 'merge_comments' : 0,
  \ 'show_if_and_else': 0,
  \ 'strip_namespaces': 1,
  \ 'strip_template_arguments': 1 }
]])

-- Clever F
g.clever_f_across_no_line = 1
g.clever_f_smart_case = 1
g.clever_f_fix_key_direction = 0
noremap_nmap(";", "<Plug>(clever-f-repeat-forward)")
noremap_nmap(",", "<Plug>(clever-f-repeat-back)")

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
expr_imap("<Tab>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<Tab>']])
expr_imap("<C-j>", [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])
expr_smap("<Tab>", [[vsnip#expandable() ? '<Plug>(vsnip-expand)'    : '<Tab>']])
expr_smap("<C-j>", [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>']])

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

nmap("gD",        ":LspDec<Cr>")
nmap("gd",        ":LspDef<Cr>")
nmap("gi",        ":LspImplementation<Cr>")
nmap("<leader>D", ":LspTypeDef<Cr>")
nmap("gr",        ":LspRefs<Cr>")

nmap("K",         ":LspHover<Cr>")
nmap("gk",        ":LspSigHelp<Cr>")

nmap("<leader>rn",":LspRename<Cr>")
nmap("ga",        ":LspCodeAction<Cr>")
nmap("<leader>f", ":LspFormatting<Cr>")

nmap("g[",        ":LspDiagnPrev<Cr>")
nmap("g]",        ":LspDiagNext<Cr>")
nmap("gl",        ":LspDiagLine<Cr>")
nmap("gh",        "<cmd>Lspsaga lsp_finder<CR>")

-- Toggle Diagnostics
nmap("tt",  "<Plug>(toggle-lsp-diag)")
nmap("ttv", "<Plug>(toggle-lsp-diag-vtext)")

-- FloatTerm
g.floaterm_opener = 'edit'
g.floaterm_keymap_new = '<Leader>ft'
nmap("<c-t>", ":FloatermNew fff<CR>")

-- -- Navigation
expr_nmap(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'")
expr_nmap('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'")

-- Actions
nmap('<leader>hs', ':Gitsigns stage_hunk<CR>')
vmap('<leader>hs', ':Gitsigns stage_hunk<CR>')
nmap('<leader>hr', ':Gitsigns reset_hunk<CR>')
vmap('<leader>hr', ':Gitsigns reset_hunk<CR>')
nmap('<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
nmap('<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
nmap('<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
nmap('<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
nmap('<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
nmap('<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
nmap('<leader>hd', '<cmd>Gitsigns diffthis<CR>')
nmap('<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
nmap('<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

-- Text object
omap('ih', ':<C-U>Gitsigns select_hunk<CR>')
xmap('ih', ':<C-U>Gitsigns select_hunk<CR>')
