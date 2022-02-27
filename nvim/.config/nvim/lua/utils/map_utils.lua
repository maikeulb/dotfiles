local M = {} -- initialize an empty table (or object in JS terms)

local options = { noremap = true, silent = true }
function M.map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

function M.nmap(shortcut, command)
  M.map("n", shortcut, command)
end

function M.vmap(shortcut, command)
  M.map("v", shortcut, command)
end

function M.imap(shortcut, command)
  M.map("i", shortcut, command)
end

function M.cmap(shortcut, command)
  M.map("c", shortcut, command)
end

function M.xmap(shortcut, command)
  M.map("x", shortcut, command)
end

function M.omap(shortcut, command)
  M.map("o", shortcut, command)
end

local expr_options = { expr = true }
local function expr_map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, expr_options)
end

function M.expr_nmap(shortcut, command)
  expr_map("n", shortcut, command)
end

function M.expr_imap(shortcut, command)
  expr_map("i", shortcut, command)
end

function M.expr_smap(shortcut, command)
  expr_map("s", shortcut, command)
end

local noremap_options = { noremap = false, silent = true }
local function noremap_map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, noremap_options)
end

function M.noremap_nmap(shortcut, command)
  noremap_map("n", shortcut, command)
end

return M
