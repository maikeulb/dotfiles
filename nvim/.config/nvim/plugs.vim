call plug#begin('$HOME/.config/nvim/plugins')

" Presentation
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'blueyed/vim-diminactive'

" Readline/Command
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'

" Folds
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

" Windows
Plug 'szw/vim-maximizer'
Plug 'romainl/vim-qf'

" Navigation
Plug 'justinmk/vim-dirvish'
Plug 'rhysd/clever-f.vim'

" Undo
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Textobj
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Align
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Movement
Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

" Repeat
Plug 'tpope/vim-repeat'

" Notes / Prose
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'junegunn/goyo.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/committia.vim'

" Search and Replace
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-cool'
Plug 'mhinz/vim-grepper'

" Formatters
Plug 'Chiel92/vim-autoformat'

" Command Runners
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'

" Linters
Plug 'w0rp/ale'

" Language - Syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'freitass/todo.txt-vim', {'for': 'todo'}
Plug 'OrangeT/vim-csharp', {'for': ['cshtml.html', 'csharp']}
" Plug 'fatih/vim-go', {'for': 'go'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'}
Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }

" Language - Utilities
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
" Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'jinja2', 'css'] }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'dansomething/vim-eclim', {'for': 'java' }

" Completion / Tags
Plug 'Raimondi/delimitMate'
Plug 'lifepillar/vim-mucomplete'
Plug 'ludovicchabant/vim-gutentags'

" Yank
Plug 'svermeulen/vim-easyclip'

call plug#end()
