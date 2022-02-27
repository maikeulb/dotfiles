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
  -- PluginManager
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'anott03/nvim-lspinstall'
  use {'tami5/lspsaga.nvim',
    config = function() require("lspsaga").init_lsp_saga() end
  }
  -- use "jose-elias-alvarez/null-ls.nvim"
  use "mfussenegger/nvim-lint"
  use 'mfussenegger/nvim-jdtls'
  use {'simrat39/rust-tools.nvim', ft = 'rust'}
  use {'jackguo380/vim-lsp-cxx-highlight', ft = 'cpp'}
  use {'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function() require'toggle_lsp_diagnostics'.init() end
  }

  -- Syntax
  use {'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Keybinding
  use {'folke/which-key.nvim',
    config = function()
      require("which-key").setup {
         triggers = "auto",
         presets = {
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
         },
      }
    end
  }
  -- Snippet
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  -- Fuzzy Finder
  use {'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end
  }
  use 'junegunn/fzf.vim'

  -- Color
  use 'norcalli/nvim-colorizer.lua'

  -- ColorScheme
  use {'folke/tokyonight.nvim', as = 'tokyonight'}

  -- Statusline and Tabline
  use 'nvim-lualine/lualine.nvim'
  use {'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Split and Window
  use "vim-scripts/winpos.vim"
  use 'blueyed/vim-diminactive'
  use {'beauwilliams/focus.nvim',
    config = function() require("focus").setup() end
  }

  -- Terminal Integration
  use "numToStr/FTerm.nvim"
  use 'voldikss/vim-floaterm'

  -- Commandline
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

  -- Motion
  use 'ggandor/lightspeed.nvim'
  use 'andymass/vim-matchup'
  use 'christoomey/vim-tmux-navigator'
  use 'unblevable/quick-scope'

  -- Quickfix
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- Navigation
  use 'tpope/vim-abolish'
  use 'nanotee/zoxide.vim'
  use 'liuchengxu/vista.vim'

  -- Editing Support
  use 'ntpeters/vim-better-whitespace'
  use 'svermeulen/vim-easyclip'
  use 'Raimondi/delimitMate'
  use 'tpope/vim-repeat'

  -- Folds
  use 'Konfekt/FastFold'
  use {'gbprod/cutlass.nvim',
    config = function() require("cutlass").setup({ cut_key = "m" }) end
  }

  -- Programming Language Support
  use {'tmux-plugins/vim-tmux', ft = 'tmux'}
  use {'tmhedberg/SimpylFold', ft = 'python'}
  use {'avakhov/vim-yaml', ft = 'yaml'}
  use {'derekwyatt/vim-fswitch', ft = {'c', 'cpp'}}
  use {'dense-analysis/ale', ft = {'hack'}}
  use {'hhvm/vim-hack', ft = {'hack'}}

  -- Remote Development
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
  -- Debugging
  use 'mfussenegger/nvim-dap'
  -- use {'mfussenegger/nvim-dap-python',
    -- config = function () require('dap-python').setup('/Users/michaelbarnes/src/debugpy/venv/bin/python') end
  -- }
  use {'theHamsta/nvim-dap-virtual-text',
    config = function() require("nvim-dap-virtual-text").setup() end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
