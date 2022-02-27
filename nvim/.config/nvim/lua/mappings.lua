local g = vim.g
local mp = require("./utils/map_utils")

-- Map leader to space
g.mapleader = ' ' -- Map <Space> to leader
-- vim.cmd("noremap <C-b> :noh<cr>:call clearmatches()<cr>") -- clear matches Ctrl+b

-- Disable mappings
mp.map('', '<backspace>', "<nop>")
mp.map('', '<S>', "<nop>")

mp.nmap("&", ":&&<CR>")
mp.xmap("&", ":&&<CR>")

-- Marks
mp.nmap("gm", "m")

mp.nmap("g;", "g;zz")
mp.nmap("g,", "g,zz")
mp.nmap("n", "nzz")
mp.nmap("N", "Nzz")

mp.nmap("Y", "y$")
mp.nmap("C", "m$")
mp.nmap("H", "0")
mp.nmap("L", "$")

mp.nmap("oo", "o<Esc>k")
mp.nmap("OO", "O<Esc>")
mp.nmap("D", '"_d$')
mp.nmap("od", '0"_D')

mp.nmap("<leader>m", ":make<cr>")
mp.nmap("<leader>*", "*``cgn")
mp.nmap("<leader>#", "#``cgN")
mp.nmap("<leader>r", ":%sh<<C-r>=expand('<cword>')<CR>>//gc<Left><Left><Left>")
mp.nmap("<leader>wr", "<C-W>r")
mp.nmap("<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>.")

mp.nmap('<leader>"', ":split<CR>")
mp.nmap("<leader>%", ":vsplit<CR>")
mp.nmap("<leader>c", ":enew<CR>")

mp.nmap("<leader>cn", ":cprevious<CR>")
mp.nmap("<leader>cp", ":cnext<CR>")
mp.nmap("<leader>lp", ":lprevious<CR>")
mp.nmap("<leader>ln", ":lnext<CR>")
mp.nmap("<leader>jj", ":bprevious<CR>")
mp.nmap("<leader>kk", ":bnext<CR>")

mp.nmap("<leader>q", ":qa!<CR>")
mp.nmap("<leader>wa", ":w<CR>")
mp.nmap("<leader>wqa", ":wqa<CR>")
mp.nmap("<leader>qw", ":qw<CR>")
mp.nmap("<leader>w", ":w<CR>")
mp.nmap("<leader>wa", ":wa<CR>")

mp.nmap("<leader>ef", ":edit $HOME/.config/fish/config.fish<CR>")
mp.nmap("<leader>eg", ":edit $HOME/.gitconfig<CR>")
mp.nmap("<leader>en", ":n $HOME/.config/nvim/init.lua $HOME/.config/nvim/lua/**/*lua<CR>")

mp.imap("jj", "<Esc>")
mp.imap("<C-w>", "<C-g>u<C-w>")
mp.imap("<C-u>", "<C-g>u<C-u>")
mp.imap("<C-y>", '<C-r>"')

mp.cmap("%%", "<C-R>=fnameescape(expand('%:h')).'/'<CR>")
mp.cmap("<C-n>", "<Down>")
mp.cmap("<C-p>", "<Up>")
mp.cmap("<C-y>", '<C-r>"')

mp.nmap("<leader>y", '"+y')
mp.nmap("<leader>d", '"+d')
mp.vmap("<leader>y", '"+y')
mp.vmap("<leader>d", '"+d')

mp.nmap("<leader>p", ':set paste<CR>"+p:set nopaste<CR>')
mp.nmap("<leader>P", ':set paste<CR>"+P:set nopaste<CR>')
mp.vmap("<leader>p", ':set paste<CR>"+p:set nopaste<CR>')
mp.vmap("<leader>P", ':set paste<CR>"+P:set nopaste<CR>')

-- -- LSP --
mp.nmap("<leader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>") -- format code
mp.nmap("<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<cr>")
mp.nmap("<leader>jd", "<cmd>lua vim.lsp.buf.definition()<cr>") -- go to type definition
mp.nmap("<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
mp.nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
mp.nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
