"Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=79 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

"Environment {
    set nocompatible      " Use vim settings instead of vi settings
" }


" General {
    set background=dark         " Assume a dark background
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    set encoding=utf-8          " Encoding that is displayed
    scriptencoding utf-8        " Encoding that is written (script)
    set autoread                " automatically reload files changed outside of Vim

" Enable omni completion. (Ctrl-X Ctrl-O)
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType c set omnifunc=ccomplete#Complete
" autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
" if has("autocmd") && exists("+omnifunc")
"   autocmd Filetype *
              " \ if &omnifunc == "" |
              " " \     setlocal omnifunc=syntaxcomplete#Complete |
              " " \ endif
" endif

set cot-=preview
" "disable doc preview in omnicomplete


    " Use + register for copy-paste
    if has('clipboard')
        if has('unnamedplus')
            set clipboard=unnamed,unnamedplus
        else
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT      " Abbrev messages (avoids 'hit enter')
    set spell                       " Spell checking on
    set hidden                      " Allow buffer switching without saving
    set iskeyword-=.                " '.' is an end of word designator
    set iskeyword-=#                " '#' is an end of word designator
    set iskeyword-=-                " '-' is an end of word designator
    set noswapfile                  " No swap files.
    set history=1000                " Store a ton of history (default is 20)

    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" }


" Vim UI {
    set backspace=indent,eol,start  " Backspace for dummies
    set number                      " Line numbers on
    set textwidth=79                " Set text-width
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolloff=5                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set colorcolumn=80
    set fo-=t
    highlight ColorColumn ctermbg=233
" }


" Formatting {
     set nowrap                      " Do not wrap long lines
     set autoindent                  " Indent at the same level of the previous line
     set shiftwidth=4                " Use indents of 4 spaces
     set expandtab                   " Tabs are spaces, not tabs
     set shiftround                  " See multiples of shiftround when using < or >
     set tabstop=4                   " An indentation every four columns
     set softtabstop=4               " Let backspace delete indent
     set fileformat=unix             " Use Unix Fileformat
     set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
     set splitright                  " Puts new vsplit windows to the right of the current
     set splitbelow                  " Puts new split windows to the bottom of the current

     " Show trailing whitespace
     autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
     autocmd InsertLeave * match ExtraWhitespace /\s\+$/


    " Disable autocomments
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " Set cursor to the first line when editing a git commit message
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" }


" Key (re)Mappings {
    " Map leader to space
    let mapleader = "\<Space>"

    " " Make motions sensitive to wrapped lines
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select noremap $ :call WrapRelativeMotion("$")<CR> noremap <End> :call WrapRelativeMotion("$")<CR> noremap 0 :call WrapRelativeMotion("0")<CR> noremap <Home> :call WrapRelativeMotion("0")<CR> noremap ^ :call WrapRelativeMotion("^")<CR> " Overwrite the operator pending $/<End> mappings from above " to force inclusive motion with :execute normal! onoremap $ v:call WrapRelativeMotion("$")<CR> onoremap <End> v:call WrapRelativeMotion("$")<CR> " Overwrite the Visual+select mode mappings from above " to ensure the correct vis_sel flag is passed to function vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR> vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR> vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR> vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR> vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR> endif

    " Some helpers to edit mode
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :split %%
    map <leader>ev :vsplit %%
    map <leader>et :tabe %%
    map <leader>E  :Explore

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Switch tabs
    map <S-H> gT
    map <S-L> gt

    " Easier formatting for paragrpahs
    vmap Q gq
    nmap Q gqap

    " Toggle numbers
    noremap <c-n> :NumbersToggle<CR>

    " No arrow keys
    noremap <Up> <nop>
    noremap <Down> <nop>
    noremap <Left> <nop>
    noremap <Right> <nop>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Visual shifting
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the dot operator with a visual selection (!)
    vnoremap . :normal .<CR>

    " Easy insert
    nnoremap oo o<Esc>k

    " Yank from the cursor to the end of the line.
    nnoremap Y y$

    " Insert space
    nnoremap ss i<space><esc>

    " Write to buffer
    nnoremap <Leader>w :w<CR>

    " Source vimrc
    nnoremap <leader>sv :source $MYVIMRC
    nnoremap <leader>ev :edit $MYVIMRC<cr>
    nnoremap <leader>td :edit ~/Dropbox/todo/todo.txt<CR>

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " Backspace/enter to go to beginning/end of file.
    nnoremap <BS> gg
    nnoremap <CR> G

    " Easy escape
    inoremap jj <Esc>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
" }


" Functions {
    " Automatically remove trailing whitespaces
    function! StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction

    autocmd BufWritePre * :call StripTrailingWhitespaces()

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

    " Automatically set/unset vim paste mode
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

   " Trigger background dark/light

    function! ToggleBG()
        let s:tbg = &background
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction

    noremap <leader>bg :call ToggleBG()<CR>

" Virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" }


" Environment {
" Set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle')

" }


" Plugins {

    " General {
    Plug 'tpope/vim-fugitive'
    Plug 'Syntastic'
    Plug 'tmhedberg/SimpylFold'
    Plug 'vim-scripts/indentpython.vim'
    Plug 'nvie/vim-flake8'

    Plug 'vim-airline/vim-airline'
    Plug 'powerline/fonts'
    Plug 'jnurmine/Zenburn' " review
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'thinca/vim-quickrun'
    Plug 'honza/vim-snippets'

    " }

    " Python {
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-commentary'
    Plug 'alfredodeza/pytest.vim'
    Plug 'myusuf3/numbers.vim' "review
    Plug 'heavenshell/vim-quickrun-hook-unittest'
    Plug 'simeji/winresizer' "review
    Plug 'Shougo/vimproc' "review
    Plug 'jeetsukumaran/vim-buffergator'
    Plug 'jmcantrell/vim-virtualenv'
    Plug 'junegunn/seoul256.vim'
    Plug 'jpalardy/vim-slime'
    Plug 'wlangstroth/vim-racket'
    " }

    " Lisp {
    Plug 'tpope/vim-surround'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
    Plug 'tpope/vim-repeat'
    Plug 'junegunn/goyo.vim'
    " Plug 'kovisoft/slimv'
    Plug 'reedes/vim-pencil'
    Plug 'wikitopian/hardmode'
    Plug 'tpope/vim-vinegar'
    Plug 'justinmk/vim-dirvish'
    Plug 'tell-k/vim-autopep8'
    Plug 'tell-k/vim-autoflake'
    Plug 'justinmk/vim-sneak'
    Plug 'wellle/targets.vim'
    Plug 'mileszs/ack.vim'
    Plug 'xolox/vim-notes'
    Plug 'xolox/vim-misc'
    Plug 'freitass/todo.txt-vim'
    Plug 'ervandew/supertab'
    Plug 'terryma/vim-expand-region'
    Plug 'davidhalter/jedi'
    " Plug 'Valloric/YouCompleteMe'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'SirVer/ultisnips'
    Plug 'airblade/vim-gitgutter'
"    Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
"Plug 'shougo/vimshell.vim'
"Plug 'shougo/unite.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'Raimondi/delimitMate'
    Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'

autocmd! BufWritePost * Neomake




" "godlygeek/tabular
" "easytags and tagbar
" "html and javascript
" "rope

    " }

call plug#end()

"}


" Plugins Config {

    " enable all Python syntax highlighting features
    let python_highlight_all=1

    "let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp"'
    au syntax racket :RainbowParenthesesActivate
    au syntax racket :RainbowParenthesesLoadRound
    au BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme

    augroup pencil
        autocmd!
        autocmd FileType markdown,mkd call pencil#init()
        " autocmd FileType text         call pencil#init()
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


    " smart indent
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.py set nocindent
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``


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

    nnoremap <leader>fe :SyntasticCheck<CR>


    " code folding
    " set foldmethod=indent


    " simpylfold
    let g:SimpylFold_docstring_preview=1
    let g:SimpylFold_fold_docstring=1


    " quickrun
    nmap <leader>qr :QuickRun<CR>
    let g:quickrun_config  = {
                \   "_" : {
                \   "outputter/buffer/split" : ":botright 8sp",
                \   },
                \}


    " qr
    " let g:quickrun_config = {
    "       \   '_' : {
    "       \     'outputter/buffer/split' : ':botright 8sp',
    "      \     'outputter/buffer/into' : 1,
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
    "let g:winresizer_start_key = '<C-T>'


    " ctrlp
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

    " Setup some default ignores
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
                \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
                \}

    " Use the nearest .git directory as the cwd
    " This makes a lot of sense if you are working on a project that is in
    " version control. It also supports works with .svn, .hg, .bzr.
    let g:ctrlp_working_path_mode = 'r'

    " Use a leader instead of the actual named binding
    nmap <leader>p :CtrlP<cr>

    " Easy bindings for its various modes
    nmap <leader>bb :CtrlPBuffer<cr>
    nmap <leader>bm :CtrlPMixed<cr>
    nmap <leader>bs :CtrlPMRU<cr>


    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    if executable('ag')
        " Use Ag over Grep
        set grepprg=ag\ --nogroup\ --nocolor

        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    endif


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


    " autopep8
    nnoremap <leader>ap :Autopep8<CR>
    let g:autopep8_disable_show_diff=1

    nnoremap <leader>af :Autoflake<CR>
    let g:autoflake_disable_show_diff=1

    " vim.sneak
    " nmap f <Plug>Sneak_s
    " nmap F <Plug>Sneak_S
    " xmap f <Plug>Sneak_s
    " xmap F <Plug>Sneak_S
    " omap f <Plug>Sneak_s
    " omap F <Plug>Sneak_S

    " seoul256 (light):
    "   Range:   252 (darkest) ~ 256 (lightest)
    "   Default: 253
    "let g:seoul256_light_background = 256
    colo seoul256-light

    " seoul256 (dark):
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    "let g:seoul256_background = 234
    colo seoul256


    " Vim Expand region
    vmap L <Plug>(expand_region_expand)
    vmap H <Plug>(expand_region_shrink)


    " Config for YCM, Supertab, Ultisnips
    let g:jedi#force_py_version = 3
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#popup_on_dot = 0

    " let g:ycm_python_binary_path = 'python'

    " let g:ycm_complete_in_comments = 1
    " let g:ycm_complete_in_strings = 1
    " let g:ycm_dont_warn_on_startup = 0
    " let g:ycm_collect_identifiers_from_comments_and_strings = 1
    " let g:ycm_show_diagnostics_ui = 0

    " let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
    " let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword

    " let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
    " let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

    " let g:SuperTabDefaultCompletionType    = '<C-n>'
    " let g:SuperTabClosePreviewOnPopupClose = 1

    " let g:SuperTabCrMapping                = 0

    " let g:UltiSnipsExpandTrigger           ="<cr>"
    " let g:UltiSnipsJumpForwardTrigger      ="<c-j>"
    " let g:UltiSnipsJumpBackwardTrigger     ="<c-k>"

    " let g:UltiSnipsJumpForwardTrigger = "<tab>"
    " let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    " let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file

    " nnoremap <leader>ue :UltiSnipsEdit<cr>

" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#use_tabs_not_buffers = 0
" let g:jedi#show_call_signatures = 2
" let g:jedi#force_py_version = 3
" let g:jedi#popup_select_first = 0



    " Airline
    let g:airline#extensions#tabline#enabled = 1
    set laststatus=2
    let g:airline_theme='wombat'

    " Don't show seperators
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline_powerline_fonts = 1

    " gitgutter
    set updatetime=250
    " }


" neocomplete {

    " Shell like behavior(not recommended).
    " set completeopt+=longest
    " let g:neocomplete#enable_auto_select = 1
    " let g:neocomplete#disable_auto_complete = 1
    " inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " let g:neocomplete#enable_at_startup = 1
    " let g:neocomplete#enable_smart_case = 1
    " let g:neocomplete#enable_auto_delimiter = 1
    " let g:neocomplete#max_list = 15
    " let g:neocomplete#force_overwrite_completefunc = 1
    " let g:neocomplete#enable_fuzzy_completion = 0

    " always use completions from all buffers
    " if !exists('g:neocomplete#same_filetypes')
      " let g:neocomplete#same_filetypes = {}
    " endif
    " let g:neocomplete#same_filetypes._ = '_'

    " Plugin key-mappings {

        " <C-k> Complete Snippet
        " <C-k> Jump to next snippet point
        imap <silent><expr><C-k> neosnippet#expandable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                    \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
        smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

        " inoremap <expr><C-g> neocomplete#undo_completion()
        " inoremap <expr><C-l> neocomplete#complete_common_string()
        "inoremap <expr><CR> neocomplete#complete_common_string()

        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        " inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

        " function! CleverCr()
        "     if pumvisible()
        "         if neosnippet#expandable()
        "             let exp = "\<Plug>(neosnippet_expand)"
        "             return exp . neocomplete#smart_close_popup()
        "         else
        "             return neocomplete#smart_close_popup()
        "         endif
        "     else
        "         return "\<CR>"
        "     endif
        " endfunction

        " <CR> close popup and save indent or expand snippet
        " imap <expr> <CR> CleverCr()
        " inoremap <expr><CR> neosnippet#expandable() ? neosnippet#mappings#expand_or_jump_impl() : pumvisible() ? neocomplete#close_popup() : "\<CR>"

        " <C-h>, <BS>: close popup and delete backword char.
        " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " inoremap <expr><C-y> neocomplete#smart_close_popup()

        " <TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        " function! CleverTab()
        "     if pumvisible()
        "         return "\<C-n>"
        "     endif
        "     let substr = strpart(getline('.'), 0, col('.') - 1)
        "     let substr = matchstr(substr, '[^ \t]*$')
        "     if strlen(substr) == 0
        "         " nothing to match on empty string
        "         return "\<Tab>"
        "     else
        "         " existing text matching
        "         if neosnippet#expandable_or_jumpable()
        "             return "\<Plug>(neosnippet_expand_or_jump)"
        "         else
        "             return neocomplete#start_manual_complete()
        "         endif
        "     endif
        " endfunction

        " imap <expr> <Tab> CleverTab()

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " }

    " " Define dictionary.
    " let g:neocomplete#sources#dictionary#dictionaries = {
    "             \ 'default' : '',
    "             \ 'vimshell' : $HOME.'/.vimshell_hist',
    "             \ 'scheme' : $HOME.'/.gosh_completions'
    "             \ }

    " " Define keyword.
    " if !exists('g:neocomplete#keyword_patterns')
    "     let g:neocomplete#keyword_patterns = {}
    " endif
    " let g:neocomplete#keyword_patterns['default'] = '\h\w*'


    " " Enable heavy omni completion.
    " if !exists('g:neocomplete#sources#omni#input_patterns')
    "     let g:neocomplete#sources#omni#input_patterns = {}
    " endif

    " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    " let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    " let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    " let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    " " }

" Popup color.
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=1
"Modeline and Notes {
hi PmenuSbar ctermbg=0

" fzf
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

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
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

" }

" Neovim

let $NVIM_TUI_ENABLE_TRUE_COLOR=1



let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" shortcut to fold all
set nofoldenable
"configuring neocomplete
"formatting, todo
"
if has('nvim')
    set fillchars+=vert:\
    set completeopt=longest,menuone
endif



