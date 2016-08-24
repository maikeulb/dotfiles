" Modeline {
" vim: foldmarker={,} foldlevel=0 foldmethod=marker
" }


" General {
    set background=dark         " Assume a dark background
    set mouse=
    set scrolloff=1
    set sidescrolloff=5
    set completeopt-=preview
    set shortmess+=filmnrxoOtT      " Abbrev messages (avoids 'hit enter')
    set spell                       " Spell checking on
    set hidden                      " Allow buffer switching without saving
    set iskeyword-=.                " '.' is an end of word designator
    set iskeyword-=#                " '#' is an end of word designator
    set iskeyword-=-                " '-' is an end of word designator
    set noswapfile                  " No swap files.
    scriptencoding utf-8        " Encoding that is written (script)

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

    " " Always switch to the current file directory
    " autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    "
    "
    " The Silver Searcher {
    if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor
    endif

    " bind \ (backward slash) to grep shortcut
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
    " }

    " Persistent Undo {
    " Put plugins and dictionaries in this dir (also on Windows)
    let vimDir = '$HOME/.vim'
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

" }


" User Interface, Themes & Colors {

    set relativenumber
    set number                      " Line numbers on
    set textwidth=79                " Set text-width
    set showmatch                   " Show matching brackets/parenthesis
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set gdefault
    set foldenable                  " Auto fold code
    set foldcolumn=2
    set colorcolumn=80
    set foldlevelstart=99
    " set foldmethod=indent
    set formatoptions-=t
    highlight ColorColumn ctermbg=233

    " Popup color.
    highlight Pmenu ctermbg=8
    highlight PmenuSel ctermbg=1
    highlight PmenuSbar ctermbg=0

    set fillchars+=vert:\
    set completeopt=longest,menuone
" }


" Formatting and Editing {

     set nowrap                      " Do not wrap long lines
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

    " Smart Indent
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.py set nocindent
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

    " Python syntax highlighting features
    let g:python_highlight_all=1


" }


" Folding {

" }


" Mappings and Shortcuts {

    " Map leader to space
    let g:mapleader = "\<Space>"

    " " Make motions sensitive to wrapped lines
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let l:vis_sel=""
            if a:0
                let l:vis_sel="gv"
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
    map <Leader>" <C-w>|
    map <Leader>% <C-w>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Switch tabs
    map <S-H> gT
    map <S-L> gt

    " Disable EX mode
    map Q <Nop>

    " Exit terminal mode
    tnoremap <Leader>ee <C-\><C-n>

    " Easier formatting for paragrpahs
    vmap Q gq
    nmap Q gqap

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

    " Disable Backspace
    nnoremap <backspace> <nop

    " Delete all but last line
    nnoremap od 0D

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

    " Easy escape
    inoremap jj <Esc>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
" }


" Helper Functions {

    " Automatically remove trailing whitespaces
    function! StripTrailingWhitespaces()
        let l:l = line(".")
        let l:c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction

    autocmd BufWritePre * :call StripTrailingWhitespaces()

    " Automatically set/unset vim paste mode
    function! WrapForTmux(s)
        if !exists('$TMUX')
            return a:s
        endif

        let l:tmux_start = "\<Esc>Ptmux;"
        let l:tmux_end = "\<Esc>\\"

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

    " Automatically find conflicts
    function! FindConflict()
        try
            /<<<<<<<
        catch
        endtry
    endfunction
    nnoremap \ :call FindConflict()<CR>

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

    " Virtualenv support
    " py << EOF
    " import os
    " import sys
    " if 'VIRTUAL_ENV' in os.environ:
    "     project_base_dir = os.environ['VIRTUAL_ENV']
    "     activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    "     execfile(activate_this, dict(__file__=activate_this))
    " EOF

" }


" Plugins {

    " Load Plugins {
    call plug#begin('~/.vim/bundle')

        " General {
        Plug 'airblade/vim-rooter'
        Plug 'tpope/vim-projectionist'
        Plug 'svermeulen/vim-easyclip'
        Plug 'kien/rainbow_parentheses.vim'
        Plug 'junegunn/vim-easy-align'
        " }

        " Interface {
        Plug 'junegunn/seoul256.vim'
        Plug 'jeetsukumaran/vim-buffergator'
        Plug 'tpope/vim-vinegar'
        Plug 'airblade/vim-gitgutter'
        Plug 'qpkorr/vim-bufkill'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'mbbill/undotree'
        Plug 'justinmk/vim-dirvish'
        Plug 'Raimondi/delimitMate'
        Plug 'tpope/vim-rsi'
        "? autoformat
        " }

        " Integration {
        Plug 'benmills/vimux'
        Plug 'wellle/tmux-complete.vim'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'mileszs/ack.vim'
        Plug 'junegunn/fzf.vim'
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'janko-m/vim-test'
        Plug 'tpope/vim-dispatch'
        Plug 'tpope/vim-fugitive'
        Plug 'idanarye/vim-merginal'
        Plug 'junegunn/gv.vim'
        Plug 'majutsushi/tagbar'
        Plug 'ludovicchabant/vim-gutentags'
        Plug 'janko-m/vim-test'
        Plug 'kassio/neoterm'
        Plug 'edkolev/tmuxline.vim'
        Plug 'edkolev/promptline.vim'
        " Plug 'kovisoft/slimv' "depcricated in favor of vimux
        " Plug 'jpalardy/vim-slime' "depricated in favor of vimux
        " Plug 'gregsexton/gitv' " depricated in favor of gv.vim
        " }

        " Completion & Lint {
        Plug 'neomake/neomake'
        Plug 'Shougo/deoplete.nvim'
        Plug 'Shougo/neosnippet'
        Plug 'Shougo/neosnippet-snippets'
        " Plug 'Shougo/neocomplete.vim' "depricated in favor of deoplete
        " Plug 'Syntastic' " depricated in favor of deoplete
        " Plug 'ervandew/supertab' "depricated in favor of deoplete
        " }

        " Language {
        " General
        Plug 'sheerun/vim-polyglot'

        " Python
        Plug 'bfredl/nvim-ipy'
        Plug 'zchee/deoplete-jedi'
        Plug 'davidhalter/jedi'
        Plug 'davidhalter/jedi-vim'
        Plug 'tmhedberg/SimpylFold'
        Plug 'nvie/vim-flake8'
        Plug 'tell-k/vim-autopep8'
        Plug 'tell-k/vim-autoflake'
        Plug 'alfredodeza/pytest.vim'
        Plug 'jmcantrell/vim-virtualenv'
        " Plug 'ivanov/vim-ipython' " depcricated in favor of nvim-ipy

        " Javascript
        Plug 'othree/javascript-libraries-syntax.vim'
        Plug 'ramitos/jsctags'
        Plug 'ternjs/tern_for_vim'
        Plug 'moll/vim-node'
        Plug 'maksimr/vim-jsbeautify'

        " HTML/CSS
        Plug 'mattn/emmet-vim'
        Plug 'Valloric/MatchTagAlways'

        " Racket
        Plug 'wlangstroth/vim-racket'

        " Vim
        Plug 'Kuniwak/vint'
        Plug 'syngan/vim-vimlint'

        " Writing
        Plug 'junegunn/goyo.vim'
        Plug 'reedes/vim-pencil'
        " Plug 'Notes
        " }

        " Commands {
        Plug 'tpope/vim-abolish'
        Plug 'guns/vim-sexp'
        Plug 'tpope/vim-sexp-mappings-for-regular-people'
        Plug 'szw/vim-maximizer'
        Plug 'tpope/vim-unimpaired'
        Plug 'tpope/vim-eunuch'
        Plug 'wellle/targets.vim'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-repeat'
        Plug 'AndrewRadev/sideways.vim'
        "Plug Exchange
        "Plug all textobv

        " Other
        Plug 'freitass/todo.txt-vim'
        " }

    call plug#end()
    " }

    " " Slimv {
    " let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp"'
    " autocmd syntax racket :RainbowParenthesesActivate
    " autocmd syntax racket :RainbowParenthesesLoadRound
    " autocmd BufNewFile,BufRead,BufReadPost *.rkt,*.rktl,*.rktd set filetype=scheme
    " " }

    " Vim-Pencil {
    augroup pencil
        autocmd!
        autocmd FileType markdown,mkd call pencil#init()
        " autocmd FileType text         call pencil#init()
    augroup END
    " }

    " Goyo {
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
    " }

    " " Syntastic {
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

    " nnoremap <leader>fe :SyntasticCheck<CR>
    " " }

    " Simpylfold {
    let g:SimpylFold_docstring_preview=1
    let g:SimpylFold_fold_docstring=1
    autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
    " }

    " Buffergator {
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
 " }

    " Lisp Indent {
    autocmd filetype lisp,scheme setlocal equalprg=scmindent.rkt

    " By default vim will indent arguments after the function name
    " but sometimes you want to only indent by 2 spaces similar to
    " how DrRacket indents define. Set the `lispwords' variable to
    " add function names that should have this type of indenting.

    set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules
     " }

    " Autopep8 {
    nnoremap <leader>ap :Autopep8<CR>
    let g:autopep8_disable_show_diff=1
    " }

    " Autoflake {
    nnoremap <leader>af :Autoflake<CR>
    let g:autoflake_disable_show_diff=1
    " }

    " " Vim.Sneak {
    " nmap f <Plug>Sneak_s
    " nmap F <Plug>Sneak_S
    " xmap f <Plug>Sneak_s
    " xmap F <Plug>Sneak_S
    " omap f <Plug>Sneak_s
    " omap F <Plug>Sneak_S
    " " }

    " Seoul256 {
    " Range:   233 (darkest) ~ 239 (lightest)
    let g:seoul256_background = 234
    colo seoul256
    " }

    " " Vim Expand region {
    vmap L <Plug>(expand_region_expand)
    vmap H <Plug>(expand_region_shrink)
    " " }

    " Jedi-Vim {
    let g:jedi#force_py_version = 3
    let g:jedi#completions_enabled = 1
    let g:jedi#auto_vim_configuration = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#popup_on_dot = 0
    " let g:jedi#use_tabs_not_buffers = 0
    " let g:jedi#show_call_signatures = 2
    " }

    " YouCompleteMe {
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
    " let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
    " }

    "SuperTab {
    " let g:SuperTabDefaultCompletionType    = '<C-n>'
    " let g:SuperTabClosePreviewOnPopupClose = 1
    " let g:SuperTabCrMapping                = 0
    " }

    "UltiSnips {
    " let g:UltiSnipsExpandTrigger           ="<cr>"
    " let g:UltiSnipsJumpForwardTrigger      ="<c-j>"
    " let g:UltiSnipsJumpBackwardTrigger     ="<c-k>"
    " let g:UltiSnipsJumpForwardTrigger = "<tab>"
    " let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " nnoremap <leader>ue :UltiSnipsEdit<cr>
    " }

    " Airline {
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tmuxline#enabled = 1
    let g:airline#extensions#promptline#enabled = 1
    let g:airline_inactive_collapse=1
    let g:airline_section_y =""
    let g:airline_section_z =""
    let g:airline_detect_crypt=0
    let g:airline_theme='raven'

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
    " }

    " GitGutter {
    set updatetime=250
    " }

    " " Neo-Complete {
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
    "   let g:neocomplete#same_filetypes = {}
    " endif
    " let g:neocomplete#same_filetypes._ = '_'

    " inoremap <expr><C-g> neocomplete#undo_completion()
    " inoremap <expr><C-l> neocomplete#complete_common_string()
    " inoremap <expr><CR> neocomplete#complete_common_string()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    " inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

    " " Define dictionary.
    " let g:neocomplete#sources#dictionary#dictionaries = {
    "             \ 'default' : '',
    "             \ 'vimshell' : $HOME.'/.vimshell_hist',
    "             \ 'scheme' : $HOME.'/.gosh_completions'
    "             \ }

    " <CR> close popup and save indent or expand snippet
    " imap <expr> <CR> CleverCr()
    " inoremap <expr><CR> neosnippet#expandable() ? neosnippet#mappings#expand_or_jump_impl() : pumvisible() ? neocomplete#close_popup() : "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " inoremap <expr><C-y> neocomplete#smart_close_popup()

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

    " Neo-Snippet {
    " <C-k> Complete Snippet
    " <C-k> Jump to next snippet point
    imap <silent><expr><C-k> neosnippet#expandable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
    " }

    " fzf.vim {
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

    " Deoplete {
    let g:deoplete#enable_at_startup = 1
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    " let g:deoplete#disable_auto_complete = 1
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    " }

    " Vimux {
    nmap <leader>vp :VimuxPromptCommand<cr>
    nmap <leader>vl :VimuxRunLastCommand<cr>
    nmap <leader>vq :VimuxCloseRunner<cr>
    nmap <leader>vx :VimuxInterruptRunner<cr>
    let g:VimuxUseNearestPane = 0

    function! VimuxSlime()
        call VimuxSendText(@v)
        call VimuxSendKeys("Enter")
    endfunction

    autocmd! BufWritePost * Neomake

    " If text is selected, save it in the v buffer and send that buffer it to tmux
    vmap <leader>vs "vy :call VimuxSlime()<CR>

    " Select current paragraph and send it to tmux
    nmap <leader>vs vip<LocalLeader>vs<CR><Paste>
    " }

    " Neomake {
    " let neomake_verbose = 0
    " let g:neomake_open_list = 1
    " let g:neomake_javascript_enabled_makers = ['eslint']
    " let g:neomake_javascript_eslint_maker = {
    "     \ 'args': ['--no-color', '--format', 'compact', '--config', '~/.eslintrc.json'],
    "     \ 'errorformat': '%f: line %l\, col %c\, %m'
    "     \ }

    " Look for local eslint and if not use globally installed one
    " let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
    " let g:neomake_javascript_eslint_exe=substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
    " let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
    " autocmd! VimLeave * let g:neomake_verbose = 0
    " }

    " Vim-Rooter {
    let g:rooter_patterns = ['.git/']
    " let g:rooter_silent_chdir = 1
    " let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_change_directory_for_non_project_files = 'home'
    " }

    " Emmet-Vim {
    let g:user_emmet_install_global = 0
    autocmd FileType html,css EmmetInstall
    " }

    " Nvim-IPython {
    " let g:nvim_ipy_perform_mappings = 0
    map <silent> <c-s>   <Plug>(IPy-Run)
    map <silent> <c-c>   <Plug>(IPy-Terminate)
    map <silent> <c-h>   <Plug>(IPy-Complete)

    map <Leader>vip :call VimuxIpy()<CR>
    " vmap <silent> <Leader>e :python run_visual_code()<CR>
    " }

    " Vim-Slime {
    let g:slime_target = "tmux"
    let g:slime_paste_file = "$HOME/.slime_paste"
    let g:slime_python_ipython = 1
    " }

    " Vim-Test {
    nmap <silent> <leader>t :TestNearest<CR>
    nmap <silent> <leader>T :TestFile<CR>
    nmap <silent> <leader>a :TestSuite<CR>
    nmap <silent> <leader>l :TestLast<CR>
    nmap <silent> <leader>g :TestVisit<CR>

    let test#strategy = "neovim"
    let test#python#runner = 'pytest'
    " }

    " Neoterm {
    let g:neoterm_position = 'horizontal'
    let g:neoterm_automap_keys = ',tt'
    let g:neoterm_repl_python = 'ipython --no-banner --no-autoindent'

    nnoremap <silent> ,tsf :TREPLSendFile<cr>
    nnoremap <silent> ,trs :TREPLSend<cr>
    vnoremap <silent> ,trs :TREPLSend<cr>

    nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
    nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
    nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
    nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

    nnoremap <silent> ,th :call neoterm#close()<cr>
    nnoremap <silent> ,tl :call neoterm#clear()<cr>
    nnoremap <silent> ,tc :call neoterm#kill()<cr>
    " }

    " Vim-Node {
    autocmd User Node if &filetype == "javascript" | setlocal expandtab | endif
    " }

    " Vim-Maximizer {
    nnoremap <silent><c-z> :MaximizerToggle<CR>
    vnoremap <silent><c-z> :MaximizerToggle<CR>gv
    inoremap <silent><c-z> <C-o>:MaximizerToggle<CR>
    " }
    "
" textobj user
" textobj comment
" textobj-syntax
" text-obj-quote
" textobvj-url
" all text objects
" exchange.vim
" vim-autoformat
