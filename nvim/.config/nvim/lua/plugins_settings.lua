local g = vim.g

local options = { noremap = true, silent = true }

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function xmap(shortcut, command)
  map("x", shortcut, command)
end

local options2 = { noremap = false, silent = true }
local function map2(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options2)
end

local function nmap2(shortcut, command)
  map2("n", shortcut, command)
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
nmap2(";", "<Plug>(clever-f-repeat-forward)")
nmap2(",", "<Plug>(clever-f-repeat-back)")

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
vim.g.vsnip_snippet_dir = home .. '/.config/nvim/snippets'
vim.g.vsnip_snippet_dirs = {
  data_dir..'/pack/packer/opt/friendly-snippets/snippets',
}

-- LSP
nmap("<c-]>","<cmd>lua vim.lsp.buf.definition()<CR>")
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
nmap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nmap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nmap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nmap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
nmap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nmap("ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
nmap("g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
nmap("g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
nmap("<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
nmap("gh", "<Cmd>Lspsaga lsp_finder<CR>")

-- FloatTerm
g.floaterm_opener = 'edit'
g.floaterm_keymap_new = '<Leader>ft'
nmap("<c-t>", ":FloatermNew fff<CR>")
