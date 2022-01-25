local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' 
  use "nvim-lua/popup.nvim" 
  use "nvim-lua/plenary.nvim"

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'nvim-lua/completion-nvim'
  use 'anott03/nvim-lspinstall'
  use 'mfussenegger/nvim-jdtls'

  -- ColorScheme
  use {'folke/tokyonight.nvim', as = 'tokyonight'}
  use 'shaeinst/roshnivim-cs'
  use 'norcalli/nvim-colorizer.lua'
  
  -- Presentation
  use 'nvim-lualine/lualine.nvim'
  use 'blueyed/vim-diminactive'

  -- Windows
  use 'szw/vim-maximizer'
  use 'romainl/vim-qf'

  -- Command
  use 'tpope/vim-rsi'
  use 'tpope/vim-eunuch'

  -- Navigation
  use 'justinmk/vim-dirvish'
  use 'rhysd/clever-f.vim'
  use 'pechorin/any-jump.vim'

  -- Textobj
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'wellle/targets.vim'
  use 'chaoren/vim-wordmotion'
  use 'michaeljsmith/vim-indent-object'
  use 'PeterRincker/vim-argumentative'

  -- Movement
  use 'andymass/vim-matchup'
  use 'christoomey/vim-tmux-navigator'
  use 'unblevable/quick-scope'

  -- Repeat
  use 'tpope/vim-repeat'

  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- Search and Replace
  use 'tpope/vim-abolish'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'romainl/vim-cool'
  use 'mhinz/vim-grepper'

  -- Completion - Tags
  use 'Raimondi/delimitMate'

  -- Yank
  use 'svermeulen/vim-easyclip'

  -- -- Folds
  -- use 'Konfekt/FastFold'

  -- -- Command Runners
  -- use 'radenling/vim-dispatch-neovim'

  -- -- Language - Syntax
  -- use {'tmux-plugins/vim-tmux', ft = 'tmux'}

  -- -- Language - Utilities
  -- use 'tweekmonster/braceless.vim'
  -- use {'jmcantrell/vim-virtualenv', ft = 'python'}
  -- use {'tmhedberg/SimpylFold', ft = 'python'}
  -- use {'junegunn/goyo.vim', ft = 'markdown'}
  -- use {'reedes/vim-pencil', ft = 'markdown'}
  -- use {'avakhov/vim-yaml', ft = 'yaml'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
