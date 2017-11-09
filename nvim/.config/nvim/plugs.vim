call plug#begin('$HOME/.config/nvim/plugins')

" Status
Plug 'vim-airline/vim-airline'

" Terminal
Plug 'tmux-plugins/vim-tmux-focus-events'

" Notes
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

" Colors
Plug 'junegunn/seoul256.vim'
Plug 'blueyed/vim-diminactive'

" Readline
Plug 'tpope/vim-rsi'

" Shell Commands
Plug 'tpope/vim-eunuch'

" Folds
Plug 'Konfekt/FastFold'

" Windows
Plug 'szw/vim-maximizer'

" Buffers
" Plug 'qpkorr/vim-bufkill'

" Filesystem
Plug 'justinmk/vim-dirvish'
Plug 'lingceng/z.vim'

" Undo
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Textobj
Plug 'wellle/targets.vim'

" Align
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'rhysd/clever-f.vim'

" Repeat
Plug 'tpope/vim-repeat'

" Surround
Plug 'tpope/vim-surround'

" Comments
Plug 'tpope/vim-commentary'

" Regex
Plug 'othree/eregex.vim'

" Git
Plug 'airblade/vim-gitgutter', { 'on': 'GitgutterToggle' }
Plug 'tpope/vim-fugitive'

" Tags
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" Search and Replace
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" Formatters
Plug 'sbdchd/neoformat'

" Command Runners
Plug 'benmills/vimux', { 'on': 'VimuxPromptCommand' }
Plug 'janko-m/vim-test', { 'on': ['TestNearest','TestFile'] }
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
Plug 'lifepillar/pgsql.vim', {'for': 'pgsql'}
Plug 'pearofducks/ansible-vim', {'for': 'ansible'}
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'freitass/todo.txt-vim', {'for': 'todo'}
Plug 'OmniSharp/omnisharp-vim', {'do': 'git submodule update --init --recursive &&
      \ cd omnisharp-roslyn && ./build.sh', 'for': 'cs'}
Plug 'OrangeT/vim-csharp', {'for': 'cs'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
Plug 'leafgarland/typescript-vim', { 'for': 'typescript'}

" Language - Utilities
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
" Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'jinja2', 'css'] }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'guns/vim-sexp', { 'for': 'racket' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'racket' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'racket' }

" Auto Completion
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'wokalski/autocomplete-flow', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'wellle/tmux-complete.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'epilande/vim-react-snippets', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mattn/emmet-vim', { 'for': 'html' }
'
" Completion
Plug 'Raimondi/delimitMate'

" Yank
Plug 'svermeulen/vim-easyclip'

call plug#end()

