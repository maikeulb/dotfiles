local set = vim.opt
local g = vim.g
local fn = vim.fn

set.swapfile = false

-- Ignore the case when the search pattern is all lowercase
set.ignorecase = true
set.smartcase = true

-- Autosave when navigating between buffers
set.autowrite = true

-- Disable line wrapping
set.wrap = false

-- Keep lines below cursor when scrolling
set.scrolloff = 1
set.sidescrolloff = 5

-- Enable incremental search
set.incsearch = true

-- Enable cursorline
set.cursorline = false

-- When opening a window put it right or below the current one
set.splitright = true
set.splitbelow = true

-- Preserve state (undo, marks, etc) in non visible buffers
set.hidden = true

-- Tab set to two spaces
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Enable mouse support
set.mouse = 'a'

-- Updating the window title is postponed.
set.lazyredraw = true

-- Insert mode completion setting
set.completeopt = {'menu', 'menuone', 'noselect'}

-- When on, the ":substitute" flag 'g' is default on.
set.gdefault = true

-- title of the window will be set to the value of 'titlestring'
set.title = true

-- When a bracket is inserted, briefly jump to the matching one. 
set.showmatch = true

-- If in Insert, Replace or Visual mode put a message on the last line.
set.showmode = false

-- Number of lines that is checked for set commands. 
set.modeline = false
set.number = true

-- Show the line number relative to the line with the cursor in front of each line.
set.relativenumber = true

-- Every wrapped line will continue visually indented (same amount of space as the beginning of that line),
set.breakindent = true

-- This option helps to avoid all the |hit-enter| prompts caused by file messages
set.shortmess = set.shortmess + 'filmnrxoOtT'

-- Keywords are used in searching and recognizing with many commands:
-- "w", "*", "[i", etc.  It is also used for "\k" in a |pattern|.]"
set.iskeyword = set.iskeyword - '.,#,-,~'

-- Maximum width of text that is being inserted.  A longer line will be
-- broken after white space to get this width.  
set.textwidth = 79

-- 'colorcolumn' is a comma separated list of screen columns that are
-- set.colorcolumn = 80

-- Maximum number of items to show in the popup menu
set.pumheight = 15

-- Allow specified keys that move the cursor left/right to move to the
-- previous/next line when the cursor is on the first/last character in
-- the line
set.whichwrap = 'b,s,h,l,<,>,[,]'

set.clipboard = set.clipboard + 'unnamedplus'
set.showbreak = '++'
set.fillchars = set.fillchars + 'vert:|'

-- Set fold level
set.foldenable = false
set.foldlevel = 20
set.foldlevelstart = 20

-- Set wildignore
set.wildmenu = true
set.wildmode = 'full'
set.wildignorecase = true
set.wildignore:append('*.o','*.out','*.obj','.git','*.rbc','*.rbo','*.class','.svn','*.gem')
set.wildignore:append('*.gif','*.jpg','*.png','*.log')
set.wildignore:append('*.zip,*.tar.gz','*.tar.bz2','*.rar','*.tar.xz')
set.wildignore:append('*/vendor/gems/*','*/vendor/cache/*','*/.bundle/*','*/.sass-cache/*')
set.wildignore:append('*/tmp/cache/assets/*/sprockets/*','*/tmp/cache/assets/*/sass/*')
set.wildignore:append('node_modules/*')
set.wildignore:append('*.swp','*~','._*')
set.wildignore:append('.DS_Store')

-- Set Python prog
g.python_host_prog = '/usr/local/bin/python'
g.python3_host_prog = '/usr/local/bin/python3'

-- Grep
if fn.executable('rg') then
  set.grepprg = [[rg --vimgrep --smart-case]]
  set.grepformat = set.grepformat ^ { "%f:%l:%c:%m" }
elseif fn.executable('ag') then
  set.grepprg = [[ag --nogroup --nocolor --vimgrep]]
  set.grepformat = set.grepformat ^ { "%f:%l:%c:%m" }
end

-- Persistent Undo
local undo_dir = vim.env.HOME .. "/.config/nvim/undodir"

if not fn.isdirectory(undo_dir) then
  fn.mkdir(undo_dir, "", 0700)
end

set.undodir = undo_dir
set.undofile = true
set.undolevels = 10000
set.undoreload = 10000

-- A pattern that is used to recognize a list header.  
-- set.flp='^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*'
