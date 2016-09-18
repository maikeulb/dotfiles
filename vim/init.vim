" Settings {{{
" General
set title
set hidden
set spell
set gdefault
set noswapfile
set autowrite
set lazyredraw
set nohlsearch
set ignorecase
set smartcase
set showmatch
set nojoinspaces
set splitright
set splitbelow
set nomodeline

set mouse=
set background=dark
set scrolloff=1
set sidescrolloff=5
set shortmess+=filmnrxoOtT
set iskeyword-=.,#,-
set synmaxcol=250
set pumheight=15
set fillchars+=vert:\
set fileformat=unix
set completeopt-=preview

let g:python_highlight_all=1
let g:python3_host_prog = '/home/mike/.virtualenvs/.neovim/bin/python3'
set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules
set rtp+=~/.fzf_browser/vim

"Formatting
set relativenumber
set number
set nowrap
set formatoptions-=c,r,o

set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4
set textwidth=79

set winminheight=0
set whichwrap=b,s,h,l,<,>,[,]
set colorcolumn=80
highlight ColorColumn ctermbg=233

set foldlevelstart=99
set foldmethod=indent

" Files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=node_modules/*
set wildignore+=*.swp,*~,._*
set wildignore+=.DS_Store

let g:vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

set undolevels=1000
set undoreload=10000

if executable('ag')
    set grepprg=ag
    set grepformat=%f:%l:%c:%m
endif
" }}}


" Mappings {{{
let g:mapleader = "\<Space>"

nnoremap ; :
nnoremap : ;

nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

nnoremap ,; @:<CR>
nnoremap <backspace> <nop>
nnoremap <Leader>= <C-w>=

nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$
nnoremap D d$
nnoremap M m$
nnoremap H 0
nnoremap L $

nnoremap Q @q
vnoremap Q :norm @q<CR>

nnoremap oo o<Esc>k
nnoremap OO O<Esc>
nnoremap ss i<space><Esc>h
nnoremap od 0D

nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN

nnoremap <leader>r :%sh\<<C-r>=expand('<cword>')<CR>\>//gc<Left><Left><Left>

nnoremap <leader>bd :BD<CR>
nnoremap <Leader>bdd :BD!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>w   :w<CR>
nnoremap <leader>ws :w<CR>:so %<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>ew :e %%
nnoremap <leader>es :split %%
nnoremap <leader>ev :vsplit %%
nnoremap <leader>et :tabe %%

nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sc ea<C-X><C-S>

nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <silent> <leader>jj :bprevious<CR>
nnoremap <silent> <leader>kk :bnext<CR>
nnoremap <silent> <leader>tn  :tabnext<CR>
nnoremap <silent> <leader>tp  :tabprev<CR>

nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :edit /home/mike/.zshrc<CR>
nnoremap <leader>sz :source /home/mike/.zshrc<CR>
nnoremap <leader>td :edit /home/mike/Dropbox/todo/todo.txt<CR>

inoremap jj <Esc>

tnoremap <silent>  <Leader>jj <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
" }}}


"o Functions {{{
" Toggle Locationlist
function! LocationListToggle()
    if getwinvar(winnr(), 'locationlist_window', 0)
        lclose
        let w:locationlist_window = 0
    else
        " prevent errors on empty loclist
        if !empty(getloclist(0))
            lopen
            let w:locationlist_window = 1
        else
            echomsg "LocList is empty"
        endif
    endif
endfunction

command! LocationListToggle call LocationListToggle()
nnoremap <silent> <space>lo :LocationListToggle<CR>

" Toggle Quickfix
function! QuickfixToggle()
    if gettabvar(tabpagenr(), 'quickfix_window', 0)
        if t:quickfix_window == winnr()
            " jump back to the previous window if inside the quickfix
            " window
            wincmd p
        endif
        cclose
        let t:quickfix_window = 0
    else
        copen
        let t:quickfix_window = winnr()
    endif
endfunction

command! QuickfixToggle call QuickfixToggle()
nnoremap <silent> <space>qo :QuickfixToggle<CR>

" Terminal toggle
let s:termbuf = 0
function! ToggleTerm()
    botright 10 split
    try
        exe 'buffer' . s:termbuf
        startinsert
    catch
        terminal
        let s:termbuf=bufnr('%')
        tnoremap <buffer> <m-t>  <C-\><C-n>:close<CR>
    endtry
endfunction

command! ToggleTerm call ToggleTerm()
nnoremap <m-t> :ToggleTerm<CR>

" Smart paste mode
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

" Smart windows
function! WinMove(key)
    let t:curwin = winnr()
    exec 'wincmd '.a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec 'wincmd '.a:key
    endif
endfunction
map <leader>h :call WinMove('h')<CR>

map <leader>k :call WinMove('k')<CR>
map <leader>l :call WinMove('l')<CR>
map <leader>j :call WinMove('j')<CR>

map <leader>wc :wincmd q<CR>
map <leader>wr <C-W>>

map <leader>H :wincmd H<CR>
map <leader>K :wincmd K<CR>
map <leader>L :wincmd L<CR>
map <leader>J :wincmd J<CR>

nmap <left>  :3wincmd <<CR>
nmap <right> :3wincmd ><CR>
nmap <up>    :3wincmd +<CR>
nmap <down>  :3wincmd -<CR>

nnoremap <leader> <Down> :<C-u>silent! move+<CR>==
nnoremap <leader> <Up>   :<C-u>silent! move-2<CR>==
xnoremap <leader> <Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <leader> <Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" Z - cd to recent / frequent directories
function! Z(...)
    let cmd = 'fasd -d -e printf'
    for arg in a:000
        let cmd = cmd . ' ' . arg
    endfor
    let path = system(cmd)
    if isdirectory(path)
        echo path
        exec 'cd ' . path
    endif
endfunction

command! -nargs=* Z :call Z(<f-args>)
" }}}


" Plugins {{{

" Load Plugins {{{
call plug#begin('~/.vim/bundle')

" General
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'racket' }
Plug 'vim-airline/vim-airline'| Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-dirvish'
Plug 'Raimondi/delimitMate'
Plug 'szw/vim-maximizer'
Plug 'othree/eregex.vim'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-projectionist'
Plug 'mattsacks/vim-fuzzee'

" Integration
Plug 'rhysd/clever-f.vim'
Plug 'airblade/vim-gitgutter', { 'on': 'GitgutterToggle' }
Plug 'svermeulen/vim-easyclip'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'freitass/todo.txt-vim'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'benmills/vimux', { 'on': 'VimuxPromptCommand' }
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test', { 'on': ['TestNearest','TestFile'] }

" Completion, Formatters & Linters
Plug 'Chiel92/vim-autoformat'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim' | Plug 'zchee/deoplete-jedi' | Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neco-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'wellle/tmux-complete.vim'

" Language
Plug 'sheerun/vim-polyglot'
Plug 'jmcantrell/vim-virtualenv'
Plug 'wlangstroth/vim-racket'
Plug 'chrisbra/vim-zsh'
Plug 'lifepillar/pgsql.vim'
Plug 'pearofducks/ansible-vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'moll/vim-node'
Plug 'mattn/emmet-vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'tweekmonster/braceless.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

" Commands
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'wellle/targets.vim'
Plug 'guns/vim-sexp', { 'for': 'racket' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'racket' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'  | Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-rsi'

call plug#end()
" }}}

" General {{{
" Seoul256
let g:seoul256_background = 233
colo seoul256

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

" Dirvish
nnoremap <leader>dp  :Dirvish $PROJECT_HOME<CR>
nnoremap <leader>dd  :Dirvish<CR>

" Vim-Maximizer
nnoremap <silent><c-z> :MaximizerToggle<CR>
tnoremap <silent><c-z> :MaximizerToggle<CR>
" }}}

" Integration {{{
" Clever-F
let g:clever_f_fix_key_direction=1

" Git-gutter
set updatetime=250
let g:gitgutter_enabled = 0

nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" fzf.vim
set rtp+=~/.fzf
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': 'enew' }

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <M-p> :Buffers<CR>
nnoremap <silent> <leader>W :Windows<CR>
nnoremap <silent> <leader>M :Map<CR>
nnoremap <silent> <leader>C :Commands<CR>
nnoremap <silent> <leader>bL :BLines<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>bT :BTags<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn
nnoremap <silent> K :call SearchWordWithAg()<CR>
nnoremap <silent> <leader>gC :Commits<CR>
nnoremap <silent> <leader>bgC :BCommits<CR>
imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" TagBar
nnoremap <leader>tb :TagbarToggle<CR>

" Vimux
let g:VimuxUseNearestPane = 0

function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys('Enter')
endfunction

nmap <silent> <leader>vp :VimuxPromptCommand<CR>
nmap <silent> <leader>vl :VimuxRunLastCommand<CR>
nmap <silent> <leader>vq :VimuxCloseRunner<CR>
nmap <silent> <leader>vx :VimuxInterruptRunner<CR>

vmap <silent> <leader>vs "vy :call VimuxSlime()<CR>
nmap <silent> <leader>vs vip<LocalLeader>vs<CR><Paste>

" Neoterm
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*

let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_repl_python = 'ipython --no-banner --no-autoindent'
let g:neoterm_run_tests_bg=1
let g:neoterm_raise_when_tests_fail=1
let g:neoterm_close_when_tests_succeed = 1

nnoremap <silent> <leader>tsf :TREPLSendFile<CR>
nnoremap <silent> <leader>tsl :TREPLSend<CR>
vnoremap <silent> <leader>tsl :TREPLSend<CR>
nnoremap <silent> <leader>tto :Ttoggle<CR>

" Vim-Test
let g:test#strategy = 'dispatch'
let g:test#python#runner = 'pytest'

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" }}}

" Completion, Formatters & Linters {{{
" Autoformat
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode=0
let g:formatdef_mypy = '"isort - | docformatter - | yapf --style=google"'
let g:formatters_python = ['mypy']

" Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 0

" Deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

let g:deoplete#sources#jedi#enable_cache = 1
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1

highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" Language {{{
" Vim-virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_stl_format = '[%n]'
let g:virtualenv_directory = $WORKON_HOME

" PGSQL.vim
let g:sql_type_default = 'pgsql'

" Emmet-Vim
let g:user_emmet_install_global = 0
" }}}

" Commands {{{
" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fugitive
nnoremap <leader>ga  :Git add %:p<CR><CR>
nnoremap <leader>gs  :Gstatus<CR>
nnoremap <leader>gc  :Gcommit -v -q<CR>
nnoremap <leader>gt  :Gcommit -v -q %:p<CR>
nnoremap <leader>gd  :Gdiff<CR>
nnoremap <leader>ge  :Gedit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR><CR>
nnoremap <leader>gl  :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gg  :Ggrep<Space>
nnoremap <leader>gm  :Gmove<Space>
nnoremap <leader>gb  :Git branch<Space>
nnoremap <leader>go  :Git checkout<Space>
nnoremap <leader>gp  :Dispatch! git push<CR>
nnoremap <leader>gu  :Dispatch! git pull<CR>
" }}}
" }}}


" Autogroups {{{

augroup General
    autocmd!
    autocmd VimEnter * if isdirectory(expand("<amatch>")) | exe 'FZF! '.expand("<amatch>") | endif
    autocmd BufWrite * :Autoformat
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd VimResized * :wincmd =
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
                \ q :cclose<CR>:lclose<CR>
    autocmd WinEnter term://* startinsert
augroup END

augroup Working_Directory
    autocmd!
    autocmd BufLeave * let b:last_cwd = getcwd()
    autocmd BufEnter * if exists('b:last_cwd')
                \|   execute 'lcd' b:last_cwd
                \| else
                    \|   silent! Glcd
                    \| endif
augroup END

augroup FileType_Folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevel=0
    autocmd FileType json setlocal expandtab formatoptions=tcq2l foldmethod=syntax
    autocmd FileType html,xhtml setlocal foldmethod=syntax foldlevel=0
    autocmd FileType css,less setlocal foldmethod=marker foldlevel=0
    autocmd FileType zsh,bash,tmux setlocal foldmethod=marker foldlevel=0
augroup END

augroup FileType_Omnicompletion
    autocmd!
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType java set omnifunc=javacomplete#Complete
augroup END

augroup FileType_Python
    autocmd!
    autocmd FileType python BracelessEnable +indent +fold
    autocmd FileType python map <silent> <leader>ipdb oimport ipdb; ipdb.set_trace()<Esc>
augroup END

augroup Filetype_Javascript_html_css
    autocmd!
    autocmd User Node if &Filetype == "javascript" | setlocal expandtab | endif
    autocmd FileType html,css EmmetInstall
    autocmd Filetype javascript nnoremap <leader>b Odebugger;<Esc>
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
augroup END

augroup Filetype_Racket
    autocmd!
    autocmd BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme
    autocmd FileType lisp,racket,clojure scheme setlocal RainbowParentheses
    autocmd FileType lisp,racket,scheme setlocal equalprg=scmindent.rkt
augroup END

augroup FileType_Markdown
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd Filetype markdown call SetUpMk()
    function! SetUpMk()
        if !exists('#goyo')
            Goyo
        endif
    endfunction
augroup END

augroup Neomake
    autocmd!
    autocmd BufWritePost * Neomake
    autocmd QuitPre * let g:neomake_verbose = 0
    autocmd VimLeave * let g:neomake_verbose = 0
augroup END

augroup configgroup
    autocmd!
    autocmd BufReadPost *
                \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END

augroup todo.txt
    autocmd!
    autocmd BufWritePre todo.txt silent! %s/x*\s*\([0-9]\{4\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\)\s//
augroup END
"}}}
