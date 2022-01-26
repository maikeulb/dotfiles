local set = vim.opt
local g = vim.g
local fn = vim.fn

local options = { noremap = false, silent = true }
local remap = vim.api.nvim_set_keymap

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function omap(shortcut, command)
  map("o", shortcut, command)
end

nmap('s', '<Plug>Lightspeed_s')
nmap('S', '<Plug>Lightspeed_S')

omap('s', '<Plug>Lightspeed_s')
omap('S', '<Plug>Lightspeed_S')

nmap('f', '<Plug>Lightspeed_f')
nmap('F', '<Plug>Lightspeed_F')
nmap('t', '<Plug>Lightspeed_t')
nmap('T', '<Plug>Lightspeed_T')
