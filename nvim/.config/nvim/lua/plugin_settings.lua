local set = vim.opt
local g = vim.g
local fn = vim.fn

local options = { noremap = true, silent = true }

local remap = vim.api.nvim_set_keymap

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function xmap(shortcut, command)
  map("x", shortcut, command)
end

-- Map leader to space
vim.g.mapleader = ' ' -- Map <Space> to leader

-- Vim-diminactive
g.diminactive_enable_focus = 1

-- Dirvish
nmap("-", ":Dirvish")

-- Vim-Maximizer
nmap("<C-z>", ":MaximizerToggle")

-- Vim-EasyClip
g.EasyClipShareYanks = 1
g.EasyClipShareYanksDirectory = "$HOME/.config/nvim/easyclip"
g.EasyClipShareYanksFile = 'easyclip'
g.EasyClipUsePasteToggleDefaults = 0

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
nmap("<C-t>", ":Tags<CR>")
nmap("<C-b>", ":Buffers<CR>")
nmap("<C-g>", ":Ag<CR>")
nmap("<leader>M", ":Maps<CR>")
nmap("<leader>C", ":Commands<CR>")

-- Fugitive
nmap("<leader>ga", ":Git add %:p<CR><CR>")
nmap("<leader>gs", ":Gstatus<CR>")
nmap("<leader>gc", ":Gcommit -v -q<CR>")
nmap("<leader>gt", ":Gcommit -v -q %:p<CR>")
nmap("<leader>gd", ":Gdiff<CR>")
nmap("<leader>ge", ":Gedit<CR>")
nmap("<leader>gr", ":Gread<CR>")
nmap("<leader>gw", ":Gwrite<CR><CR>")
nmap("<leader>gl", ":silent! Glog<CR>:bot copen<CR>")
nmap("<leader>gg", ":Ggrep<Space>")
nmap("<leader>gm", ":Gmove<Space>")
nmap("<leader>gb", ":Git branch<Space>")
nmap("<leader>go", ":Git checkout<Space>")
nmap("<leader>gp", ":Dispatch! git push<CR>")
nmap("<leader>gu", ":Dispatch! git pull<CR>")

-- Clever F
g.clever_f_across_no_line = 1
g.clever_f_smart_case = 1
g.clever_f_fix_key_direction = 0
nmap(";", "<Plug>(clever-f-repeat-forward)")
nmap(",", "<Plug>(clever-f-repeat-back)")
