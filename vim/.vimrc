" Modeline and Notes {
 " vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
 " }

 " Environment {
     " Basics {
     " }
 " }
" set scrolloff
set scrolloff=5

" set clipboard
set clipboard=unnamedplus

" remaps
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

"exerimental
set ruler

scriptencoding utf-8
set encoding=utf-8

"Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

"let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp"'
au syntax racket :RainbowParenthesesActivate
au syntax racket :RainbowParenthesesLoadRound
au BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  "  autocmd FileType text         call pencil#init()
augroup END

" Goya
autocmd Filetype markdown call SetUpMk()
function SetUpMk()
    Goyo
endfunction

augroup markdown
    autocmd Filetype markdown,mkd call SetUpMk()
augroup END

function! SetUpMk()
    if !exists('#goyo')
        Goyo
    endif
endfunction

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Syntastic'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'jnurmine/Zenburn' " review
Plugin 'altercation/vim-colors-solarized' "review
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'thinca/vim-quickrun'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'alfredodeza/pytest.vim'
Plugin 'myusuf3/numbers.vim' "review
Plugin 'heavenshell/vim-quickrun-hook-unittest'
Plugin 'simeji/winresizer' "review
Plugin 'Shougo/vimproc.vim' "review
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'jmcantrell/vim-virtualenv' "review
Plugin 'junegunn/seoul256.vim' "review
Plugin 'jpalardy/vim-slime'
Plugin 'wlangstroth/vim-racket'
Plugin 'tpope/vim-surround'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/goyo.vim'
" Plugin 'kovisoft/slimv'
Plugin 'kana/vim-fakeclip' " review
Plugin 'reedes/vim-pencil'
Plugin 'wikitopian/hardmode'
Plugin 'tpope/vim-vinegar'
Plugin 'justinmk/vim-dirvish'
Plugin 'tell-k/vim-autopep8'
Plugin 'tell-k/vim-autoflake'
Plugin 'justinmk/vim-sneak'
Plugin 'wellle/targets.vim'
Plugin 'mileszs/ack.vim'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'freitass/todo.txt-vim'
Plugin 'ervandew/supertab'
Plugin 'davidhalter/jedi'
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" show the matching part of the pair for [], {}, and ()
set showmatch

" Show whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" No swap files
set noswapfile

" Showing line numbers and lengths
set number
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=233

" easier formatting for paragrpahs
vmap Q gq
nmap Q gqap

" easy insert
nmap oo o<Esc>k

" Tab spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent
set fileformat=unix

" Search
" set hlsearch
set incsearch
set ignorecase
set smartcase

" enable all Python syntax highlighting features
let python_highlight_all=1

" smart indent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py set nocindent
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
filetype plugin indent on

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=0
let g:syntastic_auto_loc_list=1
let g:synatastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_python_python_exec='/usr/bin/env python'
let g:syntastic_loc_list_height=5
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': [],
                          \ 'passive_filetypes': [] }

let mapleader = "\<Space>"
nnoremap <leader>fe :SyntasticCheck<CR>

" code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" simpylfold
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=1

" Powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" key remaps
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap jj <Esc>

" Powerline
set rtp+=/usr/local/lib/python3.4/dist-packages/powerline/bindings/vttim/
set laststatus=2
set t_Co=256

" white space
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" quickrun
let mapleader = "\<Space>"
nmap <leader>qr :QuickRun<CR>
let g:quickrun_config  = {
           \   "_" : {
           \   "outputter/buffer/split" : ":botright 8sp",
           \   },
           \}

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" numbers
noremap <c-n> :NumbersToggle<CR>

" qr

" let g:quickrun_config = {
"       \   '_' : {
"       \     'outputter/buffer/split' : ':botright 8sp',
" "      \     'outputter/buffer/into' : 1,
"       \},
"       \}

"# augroup QuickRunUnitTest
"#   autocmd!
"#   autocmd BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
"#   autocmd BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
"#   autocmd BufWinEnter,BufNewFile *.t       setlocal filetype=perl.unit
"#   autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
"#   autocmd BufWinEnter,BufNewFile *_test.rb setlocal filetype=ruby.minitest
"#   autocmd BufWinEnter,BufNewFile *_test.go setlocal filetype=go.test
"# augroup END
"# let g:quickrun_config = {}
"# let g:quickrun_config['python.pytest'] = { 'command': 'py.test',    'cmdopt': '-v'      }
"#
" If you want to start window resize mode by `Ctrl+T`
let g:winresizer_start_key = '<C-T>'

" ctrlp
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
  \}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in
" version control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

set hidden

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" buffergator
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

" colorscheme
"set t_Co=256
"set background=dark
" if !has('gui_running')
"   let g:solarized_termcolors=&t_Co
"   let g:solarized_termtrans=1
" endif

"set background=light " optional

"if has('gui_running')

"else
"    set t_Co=16
"    let g:solarized_termcolors=16"endif
"colorscheme solarized

" Unified color scheme (default: dark)
" colo seoul256

" Light color scheme
"colo seoul256-light

" Switch
" set background=dark
" set background=light
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 233
colo seoul256

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" let g:seoul256_background = 256
" colo seoul256

" let g:seoul256_background = 233
" let g:seoul256_light_background = 256

" colo seoul256
" colo seoul256-light

" mouse mode
set mouse+=a
if &term =~ '^screen'
        " tmux knows the extended mouse mode
   set ttymouse=xterm2
endif

" vim-slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1

" execute current buffer
autocmd FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python %<CR>

" lisp indent

autocmd filetype lisp,scheme setlocal equalprg=scmindent.rkt

  " By default vim will indent arguments after the function name
  " but sometimes you want to only indent by 2 spaces similar to
  " how DrRacket indents define. Set the `lispwords' variable to
  " add function names that should have this type of indenting.

set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules

"" Hard mode
"" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

" auto paste

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" autopep8
let mapleader = "\<Space>"
nnoremap <leader>pp :Autopep8<CR>
let g:autopep8_disable_show_diff=1

let mapleader = "\<Space>"
nnoremap <leader>ff :Autoflake<CR>
let g:autoflake_disable_show_diff=1

" vim.sneak
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

" map explore
let mapleader = "\<Space>"
nnoremap <leader>ee :Explore<CR>

" Shortcuts for moving between tabs.
" Alt-j to move to the tab to the left
noremap <A-j> gT
" Alt-k to move to the tab to the right
noremap <A-k> gt

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>td :edit ~/Dropbox/todo/todo.txt<CR>

" insert space
nnoremap ss i<space><esc>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

let g:jedi#popup_on_dot = 0
"let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1


" http://stackoverflow.com/questions/1413285/multiple-autocommands-in-vim/1414845#1414845
" https://www.reddit.com/r/vim/comments/2zky2t/how_to_make_custom_commands_for_different_file/
" http://kdubois.net/2009/10/19/get-the-most-out-of-vim-with-filetype-detection/
