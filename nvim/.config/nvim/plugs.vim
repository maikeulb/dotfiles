call plug#begin('$HOME/.config/nvim/plugins')

" Status
Plug 'vim-airline/vim-airline'

" Terminal
Plug 'tmux-plugins/vim-tmux-focus-events'

" Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" Colors and Display
Plug 'junegunn/seoul256.vim'
" Plug 'Lokaltog/vim-monotone'
Plug 'blueyed/vim-diminactive'

" Readline
Plug 'tpope/vim-rsi'

" Shell Commands
Plug 'tpope/vim-eunuch'

" Folds
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

" Windows
Plug 'szw/vim-maximizer'

" Filesystem
Plug 'justinmk/vim-dirvish'

" Undo
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Textobj
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'

" Align
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

" Repeat
Plug 'tpope/vim-repeat'

" Surround
Plug 'tpope/vim-surround'

" Comments
Plug 'tpope/vim-commentary'

" Regex
Plug 'othree/eregex.vim'

" Git
Plug 'tpope/vim-fugitive'

" Search and Replace
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'

" Formatters
Plug 'Chiel92/vim-autoformat'

" Command Runners
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-tbone'

" Linters
Plug 'w0rp/ale'

" Language - Syntax
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'chrisbra/vim-zsh', { 'for': 'zsh' }
Plug 'pearofducks/ansible-vim', {'for': 'ansible'}
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
Plug 'eagltmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'dansomething/vim-eclim' 

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

" Completion
Plug 'Raimondi/delimitMate'

" Yank
Plug 'svermeulen/vim-easyclip'

call plug#end()
