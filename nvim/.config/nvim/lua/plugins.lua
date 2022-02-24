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
  -- Packer
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'anott03/nvim-lspinstall'
  use 'tami5/lspsaga.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'simrat39/rust-tools.nvim'
  use 'jackguo380/vim-lsp-cxx-highlight'

  -- Completions
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  -- ColorScheme
  use {'folke/tokyonight.nvim', as = 'tokyonight'}
  use 'norcalli/nvim-colorizer.lua'

  -- Presentation
  use 'nvim-lualine/lualine.nvim'

  -- Windows
  use "vim-scripts/winpos.vim"
  use 'blueyed/vim-diminactive'
  use {'beauwilliams/focus.nvim',
    config = function() require("focus").setup() end
  }
  use 'voldikss/vim-floaterm'
  use {'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use "numToStr/FTerm.nvim"

  -- Command
  use 'tpope/vim-rsi'
  use 'tpope/vim-eunuch'

  -- Navigation
  use 'justinmk/vim-dirvish'
  use 'rhysd/clever-f.vim'

  -- Textobj
  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-surround'
  use 'wellle/targets.vim'
  use 'chaoren/vim-wordmotion'
  use 'michaeljsmith/vim-indent-object'
  use 'PeterRincker/vim-argumentative'

  -- Movement
  use 'andymass/vim-matchup'
  use 'christoomey/vim-tmux-navigator'
  use 'unblevable/quick-scope'
  use 'ggandor/lightspeed.nvim'

  -- Repeat
  use 'tpope/vim-repeat'

  -- Better QF
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- Navigation
  use 'tpope/vim-abolish'
  use {'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end
  }
  use 'junegunn/fzf.vim'
  use 'nanotee/zoxide.vim'
  use 'mhinz/vim-grepper'

  -- Completion
  use 'Raimondi/delimitMate'

  -- Yank
  use 'svermeulen/vim-easyclip'

  -- Folds
  use 'Konfekt/FastFold'
  use{'gbprod/cutlass.nvim',
    config = function() require("cutlass").setup({ cut_key = "m" }) end
  }

  -- Formatting
  use {'ntpeters/vim-better-whitespace'}

  -- Language
  use {'tmux-plugins/vim-tmux', ft = 'tmux'}
  use {'tmhedberg/SimpylFold', ft = 'python'}
  use {'avakhov/vim-yaml', ft = 'yaml'}
  use {'cdelledonne/vim-cmake', ft = 'cpp'}
  use {'derekwyatt/vim-fswitch', ft = {'c', 'cpp'}}

  -- Remote editing
  use {'chipsenkbeil/distant.nvim',
    config = function()
      require('distant').setup {
        -- Applies Chip's personal settings to every machine you connect to
        -- 1. Ensures that distant servers terminate with no connections
        -- 2. Provides navigation bindings for remote directories
        -- 3. Provides keybinding to jump into a remote file's parent directory
        ['*'] = require('distant.settings').chip_default()
      }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
