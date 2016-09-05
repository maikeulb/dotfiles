" Settings{{{
" General
set background=dark
set mouse=
set title
set scrolloff=1
set sidescrolloff=5
set shortmess+=filmnrxoOtT
set spell
set hidden
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set noswapfile
set gdefault
set autowrite
set lazyredraw
set nohlsearch
set synmaxcol=250
set showmatch
set pumheight=15
set ignorecase
set smartcase
set fillchars+=vert:\
set fileformat=unix
set nojoinspaces
set splitright
set splitbelow
set nomodeline
set completeopt-=preview
highlight ColorColumn ctermbg=233
let g:python_highlight_all=1
let g:python3_host_prog = '/home/mike/.virtualenvs/.neovim/bin/python3'

"Formatting
set relativenumber
set number
set nowrap
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o

set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4
set textwidth=79

set winminheight=0
set whichwrap=b,s,h,l,<,>,[,]
set colorcolumn=80

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
" }}}


" Functions {{{
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
endfu
nnoremap <silent> <space>l :call LocationListToggle()<cr>

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
endfu
nnoremap <silent> <space>q :call QuickfixToggle()<cr>

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
        tnoremap <buffer> <m-t>  <C-\><C-n>:close<cr>
    endtry
endfunction

function! ToggleQuickFix()
    if exists("g:qwindow")
        lclose
        unlet g:qwindow
    else
        try
            lopen 10
            let g:qwindow = 1
        catch
            echo "No Errors found!"
        endtry
    endif
endfunction

nmap <script> <silent> <leader>qf :call ToggleQuickFix()<CR>
com! ToggleTerm call ToggleTerm()
" }}}


" Plugins {{{

" Load Plugins {{{
call plug#begin('~/.vim/bundle')

" General
Plug 'tpope/vim-projectionist'
Plug 'svermeulen/vim-easyclip'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'racket' }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Interface
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline'| Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'justinmk/vim-dirvish'
Plug 'Raimondi/delimitMate'
Plug 'szw/vim-maximizer'

" Integration
Plug 'freitass/todo.txt-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'ludovicchabant/vim-gutentags'
" Plug 'kovisoft/slimv'
Plug 'Konfekt/FastFold' "review
Plug 'benmills/vimux', { 'on': 'VimuxPromptCommand' }
Plug 'wellle/tmux-complete.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test', { 'on': ['TestNearest','TestFile'] }

" Completion & Lint
Plug 'Chiel92/vim-autoformat'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim' | Plug 'zchee/deoplete-jedi' | Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neco-vim'

" Language
Plug 'sheerun/vim-polyglot'
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'alfredodeza/pytest.vim', { 'for': 'python' }  "review
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' } "review
Plug 'jmcantrell/vim-virtualenv'
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'tmux-plugins/vim-tmux'
Plug 'reedes/vim-pencil', { 'for': 'markdown' }
Plug 'chrisbra/vim-zsh'
Plug 'hynek/vim-python-pep8-indent'

" Commands
Plug 'guns/vim-sexp', { 'for': 'racket' }
Plug 'wellle/targets.vim' " review/practice
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'racket' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'  | Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rsi'
Plug 'rhysd/clever-f.vim'

call plug#end()
" }}}

" Plugin Settings {{{

" Racket
" By default vim will indent arguments after the function name
" but sometimes you want to only indent by 2 spaces similar to
" how DrRacket indents define. Set the `lispwords' variable to
" add function names that should have this type of indenting.
set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules

" Seoul256
" Range:   233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 233
colo seoul256

" Vim-virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_stl_format = '[%n]'
let g:virtualenv_directory = $WORKON_HOME

" Clever-F
let g:clever_f_fix_key_direction=1

" " Slimv
" let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp"'

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

" GitGutter
set updatetime=250

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

" Neo-Snippet
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" fzf.vim
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

" Vimux
let g:VimuxUseNearestPane = 0

function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys('Enter')
endfunction

" Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 0

" Emmet-Vim
let g:user_emmet_install_global = 0

" Vim-Test
let g:test#strategy = 'dispatch'
let g:test#python#runner = 'pytest'

" Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_repl_python = 'ipython --no-banner --no-autoindent'
let g:neoterm_run_tests_bg=1
let g:neoterm_raise_when_tests_fail=1
let g:neoterm_close_when_tests_succeed = 1
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*

" Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode=0

" Vim-Maximizer
nnoremap <silent><c-z> :MaximizerToggle<CR>
tnoremap <silent><c-z> :MaximizerToggle<cr>

" Terminal Toggle
nnoremap <m-t> :ToggleTerm<cr>
" }}}
" }}}


" Mappings and Shortcuts {{{
let g:mapleader = "\<Space>"

nnoremap ; :
nnoremap : ;

inoremap jj <Esc>
nnoremap ,; @:<CR>
nnoremap <backspace> <nop>
nnoremap <Leader>= <C-w>=

nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$
nnoremap D d$
nnoremap H 0
nnoremap L $

nnoremap Q @q
vnoremap Q :norm @q<cr>

nnoremap oo o<Esc>k
nnoremap OO O<Esc>
nnoremap ss i<space><esc>h
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

nnoremap <silent> <leader>tn  :tabnext<CR>
nnoremap <silent> <leader>jj :bprevious<cr>
nnoremap <silent> <leader>tp  :tabprev<CR>

nnoremap <silent> <leader>kk :bnext<cr>

nnoremap <silent> <leader>q :botright copen 10<cr>
nnoremap <silent> <leader>l :botright lopen 10<cr>

tnoremap <silent>  <Leader>jj <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sz :source /home/mike/.zshrc<cr>
nnoremap <leader>td :edit /home/mike/Dropbox/todo/todo.txt<cr>

nnoremap <leader> <Down> :<C-u>silent! move+<CR>==
nnoremap <leader> <Up>   :<C-u>silent! move-2<CR>==
xnoremap <leader> <Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <leader> <Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" inoremap ,, <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
" inoremap ,; <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
" inoremap ,: <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
" inoremap ,= <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
"
" nnoremap / /\v
" vnoremap / /\v
" cnoremap %s/ %smagic/
" cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//

" UndoTree
nnoremap <leader>u :UndotreeToggle<cr>

" Tag Bar
nnoremap <leader>tb :TagbarToggle<CR>

" Neoterm
nnoremap <silent> <leader>tsf :TREPLSendFile<cr>
nnoremap <silent> <leader>tsl :TREPLSend<cr>
vnoremap <silent> <leader>tsl :TREPLSend<cr>
nnoremap <silent> <leader>tto :Ttoggle<cr>

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

" fzf.vim
nnoremap <silent> <C-p> :Files<cr>
nnoremap <silent> <M-p> :Buffers<cr>
nnoremap <silent> <leader>A :Windows<CR>

nnoremap <silent> <leader>fc :Commands<CR>
nnoremap <silent> <leader>bl :BLines<CR>
nnoremap <silent> <leader>bt :BTags<CR>
nnoremap <silent> <leader>gt :Tags<CR>

nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

" nnoremap <silent> <leader>gl :Commits<CR>
" nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

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
nnoremap <leader>gp :Dispatch! git push<CR>
nnoremap <leader>gu :Dispatch! git pull<CR>

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

" Deoplete
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup()
endfunction

" Neosnippet
" imap <silent><expr><C-k> neosnippet#expandable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)"
"             \: (pumvisible() ? "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
" smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"
" }}}


" Autogroups and autocommands {{{
augroup General
    autocmd!
    autocmd BufWrite * :Autoformat
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd VimResized * :wincmd =
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
                \ q :cclose<cr>:lclose<cr>
    autocmd WinEnter term://* startinsert
    " autocmd VimEnter * DBCompleteTables
augroup END

augroup Javascript, html, css
    autocmd!
    autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
    autocmd FileType html,css EmmetInstall            autocmd filetype javascript nnoremap <leader>b Odebugger;<esc>
    autocmd filetype javascript nnoremap <leader>b Odebugger;<esc>
augroup END

augroup Rainbowlisp
    autocmd!
    autocmd syntax racket RainbowParentheses
    autocmd BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme
    autocmd FileType lisp,racket,clojure scheme setlocal RainbowParentheses
    autocmd FileType lisp,racket,scheme setlocal equalprg=scmindent.rkt
augroup END

augroup Neomake
    autocmd!
    autocmd BufWritePost * Neomake
    autocmd QuitPre * let g:neomake_verbose = 0
    autocmd VimLeave * let g:neomake_verbose = 0
augroup END

augroup Markdown
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd Filetype markdown call SetUpMk()
    function! SetUpMk()
        if !exists('#goyo')
            Goyo
        endif
    endfunction
augroup END

augroup Python
    autocmd!
    autocmd FileType python BracelessEnable +indent +fold
    autocmd FileType python map <silent> <leader>ipdb oimport ipdb; ipdb.set_trace()<esc>
augroup END

augroup Omnicompletion
    autocmd!
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType java set omnifunc=javacomplete#Complete
augroup END

augroup Deoplete_Ternforvim
    autocmd!
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
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

augroup FileType_Formatting
    autocmd!
    autocmd BufNewFile,BufRead *.zpreztorc set filetype=zsh
    autocmd FileType vim setlocal tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 shiftround expandtab
    autocmd FileType json setlocal tabstop=8 softtabstop=2 shiftwidth=2 formatoptions=tcq2l expandtab
    autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType javascript setlocal includeexpr=v:fname.'.js'
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab
    autocmd FileType html,xhtml setlocal tabstop=4 shiftwidth=4 shiftround noexpandtab
    autocmd FileType zsh,bash,tmux, setlocal tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab nocindent
augroup END

augroup FileType_Folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevel=0
    autocmd FileType json setlocal expandtab formatoptions=tcq2l foldmethod=syntax
    autocmd FileType zsh,bash setlocal foldmethod=marker foldlevel=0
    autocmd FileType html,xhtml setlocal foldmethod=syntax foldlevel=0
    autocmd FileType css,less setlocal foldmethod=marker foldlevel=0
    autocmd FileType zsh,bash,tmux, setlocal foldmethod=marker
augroup END
"}}}
