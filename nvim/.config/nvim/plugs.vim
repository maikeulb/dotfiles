call plug#begin('$HOME/.config/nvim/plugins')

" Presentation
Plug 'dracula/vim',{'as':'dracula'}
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
Plug 'pechorin/any-jump.vim'

" Textobj
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'PeterRincker/vim-argumentative'

" Movement
Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

" Repeat
Plug 'tpope/vim-repeat'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Search and Replace
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-cool'
Plug 'mhinz/vim-grepper'

" Formatters
Plug 'Chiel92/vim-autoformat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Command Runners
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'

" Linters
Plug 'w0rp/ale'

" Language - Syntax
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'OrangeT/vim-csharp', {'for': ['cshtml.html', 'csharp']}

" Language - Utilities
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
" Plug 'dansomething/vim-eclim', {'for': 'java' }

" Completion / Tags
Plug 'Raimondi/delimitMate'
Plug 'lifepillar/vim-mucomplete'
Plug 'ludovicchabant/vim-gutentags'

" Yank
Plug 'svermeulen/vim-easyclip'

call plug#end()
call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /Users/michaelbarnes/Downloads/google-java-format-1.7-all-deps.jar"
