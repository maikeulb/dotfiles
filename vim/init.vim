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

" }


" User Interface & Themes {

set showmatch                   " Show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set fillchars+=vert:\
highlight ColorColumn ctermbg=233

" Popup color.
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

" }


" Editing {

set fileformat=unix             " Use Unix Fileformat
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set completeopt-=preview

" Show trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Disable autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Set cursor to the first line when editing a git commit message
autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Python syntax highlighting features
let g:python_highlight_all=1


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

" Smart Indent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py set nocindent
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" }


" Folding {
set foldenable                  " Auto fold code
set foldcolumn=2
set colorcolumn=80
set foldlevelstart=99
" set foldmethod=indent

" }


" Files {
set foldenable                  " Auto fold code
set foldcolumn=2
set colorcolumn=80
set foldlevelstart=99
" set foldmethod=indent

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*

" Persistent Undo {
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

map <leader>wc :wincmd q<cr>
map <leader>wr <C-W>>
map <leader>H              :wincmd H<cr>
map <leader>K              :wincmd K<cr>
map <leader>L              :wincmd L<cr>
map <leader>J              :wincmd J<cr>

nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

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

" " No arrow keys
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>

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
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>ev :edit ~/.config/nvim/init.vim<cr>
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


" Functions {

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
function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>
" }


" Plugins {

" Load Plugins {
    call plug#begin('~/.vim/bundle')

" General {
Plug 'airblade/vim-rooter' "review
Plug 'tpope/vim-projectionist'
Plug 'int3/vim-extradite' "redundant
Plug 'svermeulen/vim-easyclip'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
" }

" Interface {
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'qpkorr/vim-bufkill'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'
Plug 'justinmk/vim-dirvish'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-rsi'
" }

" Integration {
Plug 'mtth/scratch.vim'
Plug 'benmills/vimux'
Plug 'wellle/tmux-complete.vim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'mileszs/ack.vim' "maybe eliminate
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kassio/neoterm'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
" Plug 'kovisoft/slimv' "depcricated in favor of vimux
" }

" Completion & Lint {
Plug 'Chiel92/vim-autoformat'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
" Plug 'ervandew/supertab' "depricated in favor of deoplete
" }

" Language {
" General
Plug 'sheerun/vim-polyglot'

" Python
Plug 'tmhedberg/SimpylFold'
Plug 'alfredodeza/pytest.vim' "review
Plug 'jmcantrell/vim-virtualenv' "review

" Javascript
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ternjs/tern_for_vim'
Plug 'moll/vim-node'

" HTML/CSS
Plug 'mattn/emmet-vim'
Plug 'Valloric/MatchTagAlways'

" Racket
Plug 'wlangstroth/vim-racket'

" Writing
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
" }

" Commands {
Plug 'tpope/vim-abolish'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'szw/vim-maximizer'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/switch.vim'

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

" Go to the previous buffer open
nmap <leader>jj :bprevious<cr>

" Go to the next buffer open
nmap <leader>kk :bnext<cr>

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
autocmd! QuitPre * let g:neomake_verbose = 0


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

map <Leader>vip :call VimuxIpy()<CR>
" vmap <silent> <Leader>e :python run_visual_code()<CR>
" }

" }

" Vim-Test {
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

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
"

let g:python_version = '/usr/bin/python3.4m'

" let g:python_version = matchstr(system("python --version 2>&1 | cut -d' ' -f2"), '^[0-9]')
" let s:uname = system("echo -n \"$(uname)\"")
" if !v:shell_error && s:uname == "Linux"
"   let g:has_pyenv = matchstr(system("command -v pyenv >/dev/null 2>&1; echo $?"), '0')
"   if g:has_pyenv =~ 0
"       if g:python_version =~ 3
"           let g:python_host_prog = "/usr/bin/python2"
"       else
"           let g:python3_host_prog = "/usr/bin/python3"
"       endif
"   endif
" else
"   let g:has_pyenv = matchstr(system("command -v pyenv >/dev/null 2>&1; echo $?"), '0')
"   if g:has_pyenv =~ 0
"       if g:python_version =~ 3
"           let g:python_host_prog = "/usr/local/bin/python2"
"       else
"           let g:python3_host_prog = "/usr/local/bin/python3"
"       endif
"   endif
" endif

" Autoformat
au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
 let g:autoformat_verbosemode=1

" Always search regular regex
nnoremap / /\v
vnoremap / /\v

" Switch between last two files
nnoremap <leader><leader> <c-^>

" Splitting and joining code blocks
nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>

" Moving code sideways
nnoremap s< :SidewaysLeft<CR>
nnoremap s> :SidewaysRight<CR>

" Sideways argument text object
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

let g:python3_host_prog = '/home/mike/venv/bin/python3'
