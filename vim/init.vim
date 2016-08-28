" Modeline {
" vim: foldmarker={,} foldlevel=0 foldmethod=marker
" }


" General {
set background=dark         " Assume a dark background
set mouse=
set scrolloff=1
set sidescrolloff=5
set shortmess+=filmnrxoOtT      " Abbrev messages (avoids 'hit enter')
set spell                       " Spell checking on
set hidden                      " Allow buffer switching without saving
set iskeyword-=.                " '.' is an end of word designator
set iskeyword-=#                " '#' is an end of word designator
set iskeyword-=-                " '-' is an end of word designator
set noswapfile                  " No swap files.
set gdefault
set autowrite
set lazyredraw
set nohlsearch
scriptencoding utf-8        " Encoding that is written (script)

" Enable omni completion. (Ctrl-X Ctrl-O)
augroup omnicompletion
    autocmd!
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType java set omnifunc=javacomplete#Complete
augroup END

" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>
" }


" User Interface & Themes {
set showmatch                   " Show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set fillchars+=vert:\
highlight ColorColumn ctermbg=233

" }


" Editing {
set fileformat=unix             " Use Unix Fileformat
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set completeopt-=preview

let g:python_highlight_all=1
let g:python3_host_prog = '/home/mike/venv/bin/python3'
" }


" Formatting {
set relativenumber
set number                      " Line numbers on
set nowrap                      " Do not wrap long lines
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set shiftround                  " See multiples of shiftround when using < or >
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set textwidth=79                " Set text-width
set winminheight=0              " Windows can be 0 line high
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set foldenable                  " Auto fold code
set foldcolumn=0
set colorcolumn=80
set foldlevelstart=99
set foldmethod=indent
" }


" Files {
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=node_modules/*
set wildignore+=*.swp,*~,._*
set wildignore+=.DS_Store

" Persistent Undo
" Put plugins and dictionaries in this dir (also on Windows)
let g:vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" }


" Functions {

" Automatically set/unset vim paste mode
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let l:tmux_start = "\<Esc>Ptmux;"
    let l:tmux_end = "\<Esc>\\"

    return l:tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . l:tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ''
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Display output of shell commands in a new window
function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

" Smart windows
function! WinMove(key)
    let t:curwin = winnr()
    exec 'wincmd '.a:key
    if (t:curwin == winnr()) "we havent moved
        if (match(a:key,'[jk]')) "were we going up/down
            wincmd v
        else
            wincmd s
        endif
        exec 'wincmd '.a:key
    endif
endfunction

" }


" Plugins {

" Load Plugins {
call plug#begin('~/.vim/bundle')

" General
Plug 'airblade/vim-rooter' "review
Plug 'tpope/vim-projectionist'
" Plug 'ynkdir/vim-vimlparser'
" Plug 'syngan/vim-vimlint'
Plug 'svermeulen/vim-easyclip'
Plug 'kien/rainbow_parentheses.vim', { 'for': 'racket' } "review
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Interface
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } "review
Plug 'justinmk/vim-dirvish' "review
Plug 'Raimondi/delimitMate' "review
Plug 'tpope/vim-rsi' "review

" Integration
Plug 'mtth/scratch.vim' "review
Plug 'benmills/vimux', { 'on': 'VimuxPromptCommand' }
Plug 'wellle/tmux-complete.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test', { 'on': ['TestNearest','TestFile'] }
Plug 'tpope/vim-dispatch' "review
Plug 'radenling/vim-dispatch-neovim' "review
Plug 'tpope/vim-fugitive' "review
Plug 'majutsushi/tagbar' "reveiw
" Plug 'majutsushi/tagbar', { 'on': ['Tagbar','TagbarToggle','TagbarOpenAutoClose'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'kassio/neoterm'
" Plug 'kassio/neoterm', { 'on': ['TREPLSendFile', 'TREPLSend', 'Ttoggle'] }
" Plug 'kovisoft/slimv'
Plug 'Konfekt/FastFold'

" Completion & Lint
Plug 'Chiel92/vim-autoformat'
Plug 'neomake/neomake'
" Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neco-vim'

" Language
Plug 'sheerun/vim-polyglot'

Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'alfredodeza/pytest.vim', { 'for': 'python' }  "review
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' } "review

Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }

Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }

Plug 'wlangstroth/vim-racket', { 'for': 'racket' }

Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'Shougo/neco-vim'

" Commands
Plug 'tpope/vim-abolish'
Plug 'guns/vim-sexp', { 'for': 'racket' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'racket' }
Plug 'szw/vim-maximizer'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight', 'SidewaysJumpLeft', 'SidewaysJumpRight'] }
Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinSplit', 'SplitjoinJoin' ] }
Plug 'AndrewRadev/switch.vim', { 'on': 'Switch'}
Plug 'rhysd/clever-f.vim'

call plug#end()
" }

" Plugin Settings {
" " Slimv
" let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp"'

" " Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list=0
" let g:syntastic_auto_loc_list=1
" let g:synatastic_check_on_open=1
" let g:syntastic_check_on_wq=0
" let g:syntastic_enable_signs=1
" let g:syntastic_python_python_exec='/usr/bin/env python'
" let g:syntastic_loc_list_height=5
" let g:syntastic_mode_map = { 'mode': 'passive',
"             \ 'active_filetypes': [],
"             \ 'passive_filetypes': [] }

" Racket
" By default vim will indent arguments after the function name
" but sometimes you want to only indent by 2 spaces similar to
" how DrRacket indents define. Set the `lispwords' variable to
" add function names that should have this type of indenting.

set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules

" Seoul256
" Range:   233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 234
colo seoul256

" " Jedi-Vim
" let g:jedi#force_py_version = 3
" let g:jedi#completions_enabled = 1
" let g:jedi#auto_vim_configuration = 1
" let g:jedi#popup_select_first = 0
" let g:jedi#popup_on_dot = 0
" " let g:jedi#use_tabs_not_buffers = 0
" " let g:jedi#show_call_signatures = 2

" " SuperTab
" let g:SuperTabDefaultCompletionType    = '<C-n>'
" let g:SuperTabClosePreviewOnPopupClose = 1
" let g:SuperTabCrMapping                = 0

" " UltiSnips
" let g:UltiSnipsExpandTrigger           ="<cr>"
" let g:UltiSnipsJumpForwardTrigger      ="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger     ="<c-k>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#promptline#enabled = 1
let g:airline_inactive_collapse=1
let g:airline_section_y =''
let g:airline_section_z =''
let g:airline_detect_crypt=0
let g:airline_theme='wombat'

let g:airline_left_sep=' '
let g:airline_right_sep=' '

let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 60,
            \ 'y': 88,
            \ 'z': 45,
            \ 'warning': 80,
            \ 'error': 80,
            \ }

" GitGutter
set updatetime=250

" " Neo-Snippet
" " <C-k> Complete Snippet
" " <C-k> Jump to next snippet point
" imap <silent><expr><C-k> neosnippet#expandable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
"             \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
" smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

" " For snippet_complete marker.
" if has('conceal')
"     set conceallevel=2 concealcursor=i
" endif
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif

" " SuperTab like snippets behavior.
"   imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"     \ "\<Plug>(neosnippet_expand_or_jump)"
"     \: pumvisible() ? "\<C-n>" : "\<TAB>"
"     smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: "\<TAB>"

" let g:deoplete#sources#tss#javascript_support = 1
" let g:vim_json_syntax_conceal = 0
" set splitbelow
" set completeopt+=noselect
" autocmd FileType typescript setlocal completeopt+=menu,preview
" " set completeopt-=menu,preview
" autocmd FileType vmailMessageList let b:deoplete_disable_auto_complete=1
" function! Multiple_cursors_before()
"     let b:deoplete_disable_auto_complete=2
" endfunction
" function! Multiple_cursors_after()
"     let b:deoplete_disable_auto_complete=0
" endfunction
" call deoplete#custom#set('buffer', 'mark', 'buffer')
" call deoplete#custom#set('ternjs', 'mark', 'î')
" call deoplete#custom#set('omni', 'mark', 'omni')
" call deoplete#custom#set('file', 'mark', 'file')
" let g:deoplete#omni_patterns = {}
" let g:deoplete#omni_patterns.html = ''
" function! Preview_func()
"     if &pvw
"         setlocal nonumber norelativenumber
"     endif
" endfunction

" autocmd WinEnter * call Preview_func()


" fzf.vim
let g:fzf_nvim_statusline = 0 " disable statusline overwriting


" " Deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#sources#jedi#enable_cache = 1
" let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'

" " autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"     return deoplete#close_popup() . "\<CR>"
" endfunction
" " set completeopt-=preview

" inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<BS>"
" inoremap <expr><C-Space> pumvisible() ? "\<down>" : deoplete#mappings#close_popup()
" inoremap <expr><C-g> deoplete#mappings#undo_completion()

" " Plugin key-mappings
"     inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"     inoremap <expr> <C-u> deoplete#mappings#undo_completion()
"     inoremap <expr> <C-h> deoplete#mappings#refresh()
"     " <BS>: close popup and delete backword char.
"     inoremap <expr> <BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
"     " <CR>: close popup and save indent.
"     inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR><Paste>

highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=1

" hi Pmenu    gui=NONE    guifg=#c5c8c6 guibg=#373b41
" hi PmenuSel gui=reverse guifg=#c5c8c6 guibg=#373b41

" Vimux
let g:VimuxUseNearestPane = 0

function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys('Enter')
endfunction

" Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 0
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_javascript_eslint_maker = {
" \ 'args': ['--no-color', '--format', 'compact', '--config', '~/.eslintrc.json'],
" \ 'errorformat': '%f: line %l\, col %c\, %m'
" \ }

" Vim-Rooter
let g:rooter_patterns = ['.git/']
" let g:rooter_silent_chdir = 1
" let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_change_directory_for_non_project_files = 'home'

" Emmet-Vim
let g:user_emmet_install_global = 0

" Vim-Test
let g:test#strategy = 'dispatch'
let g:test#python#runner = 'pytest'

" Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_repl_python = 'ipython --no-banner --no-autoindent'
let g:neoterm_close_when_tests_succeed = 1
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*

" Autoformat
let g:formatter_yapf_style = 'pep8'
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode=0
let g:formatters_python = ['yapf']

" Vim-Maximizer
nnoremap <silent><c-z> :MaximizerToggle<CR>

" }
" }


" Mappings and Shortcuts {

" Map leader to space
let g:mapleader = "\<Space>"

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

nnoremap j gj
nnoremap k gk

nnoremap ; :
nnoremap <leader>; ;

" Switch between last two files
nnoremap <leader><leader> <c-^>

" Some helpers to edit mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabe %%

" spelling
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg

" " Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
" map <leader>t<leader> :tabnext

" move to next error
map <leader>cn :cn<CR>
" move to the prev error
map <leader>cp :cp<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" " Always search regular regex
" nnoremap / /\v
" vnoremap / /\v
" cnoremap %s/ %smagic/
" cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//

" Switch tabs
nnoremap <silent> <leader>tn  :tabnext<CR>
nnoremap <silent> <leader>tp  :tabprev<CR>

" Switch buffers
nnoremap <silent> <leader>kk :bnext<cr>
nnoremap <silent> <leader>jj :bprevious<cr>

" Disable EX mode
map Q <Nop>

" Exit terminal mode
tnoremap <silent>  <Leader>ee <C-\><C-n>

" Visual shifting
vnoremap < <gv
vnoremap > >gv

" Allow dot operator with visual selection
vnoremap . :normal .<CR>

" Easy insert
nnoremap oo o<Esc>k

" Easy delete line
nnoremap od 0D

" Disable Backspace
nnoremap <backspace> <nop>

" Yank from the cursor to the end of the line.
nnoremap Y y$

" Insert space
nnoremap ss i<space><esc>

" Write to buffer
nnoremap <leader>w :w<CR>

" Edit/source vimrc
nnoremap <leader>ev :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Easy escape
inoremap jj <Esc>

" Sudo Write
cmap w!! w !sudo tee % >/dev/null

" Sideways
nnoremap s< :SidewaysLeft<CR>
nnoremap s> :SidewaysRight<CR>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" Neoterm
nnoremap <silent> ,tsf :TREPLSendFile<cr>
nnoremap <silent> ,trs :TREPLSend<cr>
vnoremap <silent> ,trs :TREPLSend<cr>
nnoremap <silent> ,to :Ttoggle<cr>
nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

" Vim-Test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Vimux
nmap <silent> <leader>vp :VimuxPromptCommand<cr>
nmap <silent> <leader>vl :VimuxRunLastCommand<cr>
nmap <silent> <leader>vq :VimuxCloseRunner<cr>
nmap <silent> <leader>vx :VimuxInterruptRunner<cr>

vmap <silent> <leader>vs "vy :call VimuxSlime()<CR>
nmap <silent> <leader>vs vip<LocalLeader>vs<CR><Paste>

" Deoplete
" Tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" fzf.vim
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
" nnoremap <silent> <leader>gl :Commits<CR>
" nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" Syntastic
" nnoremap <leader>fe :SyntasticCheck<CR>

" Fugitive
" fugitive git bindings
nnoremap <leader>ga  :Git add %:p<CR><CR>
nnoremap <leader>gs  :Gstatus<CR>
nnoremap <leader>gc  :Gcommit -v -q<CR>
nnoremap <leader>gt  :Gcommit -v -q %:p<CR>
nnoremap <leader>gd  :Gdiff<CR>
nnoremap <leader>ge  :Gedit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR><CR>
nnoremap <leader>gl  :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp  :Ggrep<Space>
nnoremap <leader>gm  :Gmove<Space>
nnoremap <leader>gb  :Git branch<Space>
nnoremap <leader>go  :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" window
map <leader>h :call WinMove('h')<cr>
map <leader>k :call WinMove('k')<cr>
map <leader>l :call WinMove('l')<cr>
map <leader>j :call WinMove('j')<cr>

map <leader>wc :wincmd q<cr>
map <leader>wr <C-W>>
map <leader>H :wincmd H<cr>
map <leader>K :wincmd K<cr>
map <leader>L :wincmd L<cr>
map <leader>J :wincmd J<cr>

nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

" Dirvish
map <leader>D  :Dirvish

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }


" Autogroups and autocommands {
if has('autocmd')

    " Vim-Node
    augroup js_group
        autocmd!
        autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
        autocmd FileType html,css EmmetInstall "is autocmd required if lazy loading?
    augroup END

    " Autoformat
    augroup autoformat_group
        autocmd!
        autocmd BufWrite * :Autoformat
    augroup END

    " Fugitive
    augroup fugitive_group
        autocmd!
        autocmd BufReadPost fugitive://* set bufhidden=delete
    augroup END

    " Automatic resize
    augroup window_resize_group
        autocmd!
        autocmd VimResized * :wincmd =
    augroup END

    " Racket
    augroup racket_group
        autocmd!
        autocmd syntax racket :RainbowParenthesesActivate
        autocmd syntax racket :RainbowParenthesesLoadRound
        autocmd BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme
        autocmd filetype lisp,scheme setlocal equalprg=scmindent.rkt
    augroup END

    " Neomake
    augroup neomake_group
        autocmd!
        autocmd BufWritePost * Neomake
        autocmd QuitPre * let g:neomake_verbose = 0
        autocmd VimLeave * let g:neomake_verbose = 0
    augroup END

    " Disable autocomments
    augroup autocomment_group
        autocmd!
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    augroup END

    " Set cursor to the first line when editing a git commit message
    augroup git_group
        autocmd!
        autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    augroup END

    " Markdown
    augroup pencil_group
        autocmd!
        autocmd FileType markdown call pencil#init()
        autocmd Filetype markdown call SetUpMk()
        function! SetUpMk()
            if !exists('#goyo')
                Goyo
            endif
        endfunction
    augroup END

    augroup py_group
        autocmd!
        " autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
        " autocmd BufRead *.py set nocindent
        autocmd FileType python BracelessEnable +indent +fold
    augroup END

    augroup deocomplete_group
        autocmd!
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    augroup END
endif

" }

let g:scratch_persistence_file=1

nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

noremap Q @q
vnoremap Q :norm @q<cr>

" Quicker cgn/cgN
nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap <Leader>bd :BD<CR>
noremap ,; @:<CR>

" Clever F
let g:clever_f_fix_key_direction=1
