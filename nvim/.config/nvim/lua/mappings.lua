vim.cmd("noremap <C-b> :noh<cr>:call clearmatches()<cr>") -- clear matches Ctrl+b

local options = { noremap = true, silent = true }

local remap = vim.api.nvim_set_keymap

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function imap(shortcut, command)
  map("i", shortcut, command)
end

local function vmap(shortcut, command)
  map("v", shortcut, command)
end

local function cmap(shortcut, command)
  map("c", shortcut, command)
end

local function tmap(shortcut, command)
  map("t", shortcut, command)
end

local function xmap(shortcut, command)
  map("x", shortcut, command)
end

-- Map leader to space
vim.g.mapleader = ' ' -- Map <Space> to leader

-- Disable mappings
map('', '<backspace>', "<nop>")
map('', '<S>', "<nop>")

nmap("&", ":&&<CR>")
xmap("&", ":&&<CR>")

-- Marks
nmap("gm", "m")

nmap("g;", "g;zz")
nmap("g,", "g,zz")
nmap("n", "nzz")
nmap("N", "Nzz")

nmap("Y;", "y$")
nmap("D,", "d$")
nmap("C", "m$")
nmap("H", "0")
nmap("L", "$")

nmap("oo", "o<Esc>k")
nmap("OO", "O<Esc>")
nmap("ss", "a<space><Esc>h")
nmap("SS", "i<space><Esc>h")
nmap("od", "0D")

nmap("<leader>J", ":!java %")
nmap("<leader>*", "*``cgn")
nmap("<leader>#", "#``cgN")
nmap("<leader>r", ":%sh<<C-r>=expand('<cword>')<CR>>//gc<Left><Left><Left>")
-- nnoremap <leader>r :%sh\<<C-r>=expand('<cword>')<CR>\>//gc<Left><Left><Left>

nmap("<leader>wr", "<C-W>r")
nmap("<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>.")

nmap('<leader>"', ":split<CR>")
nmap("<leader>%", ":vsplit<CR>")
nmap("<leader>c", ":enew<CR>")

nmap("<leader>cn", ":cprevious<CR>")
nmap("<leader>cp", ":cnext<CR>")
nmap("<leader>lp", ":lprevious<CR>")
nmap("<leader>ln", ":lnext<CR>")
nmap("<leader>jj", ":bprevious<CR>")
nmap("<leader>kk", ":bnext<CR>")

nmap("<leader>q", ":qa!<CR>")
nmap("<leader>wa", ":w<CR>")
nmap("<leader>wqa", ":wqa<CR>")
nmap("<leader>qw", ":qw<CR>")
nmap("<leader>w", ":w<CR>")
nmap("<leader>wa", ":wa<CR>")

nmap("<leader>ef", ":edit $HOME/.config/fish/config.fish<CR>")
nmap("<leader>eg", ":edit $HOME/.gitconfig<CR>")
nmap("<leader>sv", ":source $MYVIMRC<CR>")
nmap("<leader>en", ":edit $MYVIMRC<CR>")

nmap("<leader>fc", ":FormatCode<CR>")
nmap("<leader>dc", ":TrimComments<CR>")
nmap("<leader>ab", "ysii}")

imap("jj", "<Esc>")
imap("<C-w>", "<C-g>u<C-w>")
imap("<C-u>", "<C-g>u<C-u>")
imap("<C-y>", '<C-r>"')

cmap("%%", "<C-R>=fnameescape(expand('%:h')).'/'<CR>")
cmap("<C-n>", "<Down>")
cmap("<C-p>", "<Up>")
cmap("<C-y>", '<C-r>"')

nmap("<leader>y", '"+y')
nmap("<leader>d", '"+d')
vmap("<leader>y", '"+y')
vmap("<leader>d", '"+d')

nmap("<leader>p", ':set paste<CR>"+p:set nopaste<CR>')
nmap("<leader>P", ':set paste<CR>"+P:set nopaste<CR>')
vmap("<leader>p", ':set paste<CR>"+p:set nopaste<CR>')
vmap("<leader>P", ':set paste<CR>"+P:set nopaste<CR>')

-- -- LSP --
-- nmap("<leader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>")
-- nmap("<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<cr>")
-- nmap("<leader>jd", "<cmd>lua vim.lsp.buf.definition()<cr>")
-- nmap("<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
-- nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
-- nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
