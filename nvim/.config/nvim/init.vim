" Settings {{{

" General
set title
set hidden
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
set noshowmode
set mouse=
set background=dark
set scrolloff=1
set sidescrolloff=5
set shortmess+=filmnrxoOtT
set iskeyword-=.,#,-,~
set synmaxcol=128
set pumheight=15
set fillchars+=vert:\
set completeopt-=preview

" Formatting
set relativenumber
set number
set nowrap
set textwidth=79
set winminheight=0
set whichwrap=b,s,h,l,<,>,[,]
set colorcolumn=80
set breakindent
set showbreak=\\\\\
highlight ColorColumn ctermbg=233

" Files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=node_modules/*
set wildignore+=*.swp,*~,._*
set wildignore+=.DS_Store

let g:python3_host_prog = '/home/mike/.virtualenvs/.neovim/bin/python3'
set undodir=$HOME/.config/nvim/undodir
set undofile
set undolevels=10000
set undoreload=10000
if executable('ag')
  set grepprg=ag
  set grepformat=%f:%l:%c:%m
endif

" }}}


" Mappings {{{

let g:mapleader = "\<Space>"

nnoremap <backspace> <nop>
nnoremap <S> <nop>

nnoremap ; :
nnoremap : ;

nnoremap ,; @:<CR>
nnoremap gm m
nnoremap gu gUiw`]

nnoremap g; g;zz
nnoremap g, g,zz
nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$
nnoremap D d$
nnoremap M m$
nnoremap H 0
nnoremap L $

nnoremap Q @q
vnoremap Q :normal @q<CR>

nnoremap oo o<Esc>k
nnoremap OO O<Esc>
nnoremap ss a<space><Esc>h
nnoremap SS i<space><Esc>h
nnoremap od 0D

nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap <leader>r :%sh\<<C-r>=expand('<cword>')<CR>\>//gc<Left><Left><Left>

nnoremap <leader>wr <C-W>r
nnoremap <leader>q  :BD<CR>
nnoremap <leader>x  :q<CR>

nnoremap <leader>% :new<CR>
nnoremap <leader>" :vnew<CR>

nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sc ea<C-X><C-S>

nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprevious<CR>
nnoremap <silent> <leader>ln :lnext<CR>
nnoremap <silent> <leader>lp :lprevious<CR>
nnoremap <silent> <leader>jj :bprevious<CR>
nnoremap <silent> <leader>kk :bnext<CR>

nnoremap <leader>en  :edit $MYVIMRC<CR>
nnoremap <leader>sv  :source $MYVIMRC<CR>
nnoremap <leader>ez  :edit /home/mike/.zshrc<CR>
nnoremap <leader>sz  :source /home/mike/.zshrc<CR>
nnoremap <leader>etd :edit /home/mike/Dropbox/todo/todo.txt<CR>

inoremap jj <Esc>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-y> <C-r>"

tnoremap <silent> <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-y> <C-r>"

" }}}


" Functions {{{

" LocationList Toggle
command! LocationListToggle call LocationListToggle()
function! LocationListToggle()
  if getwinvar(winnr(), 'locationlist_window', 0)
    lclose
    let w:locationlist_window = 0
  else
    if !empty(getloclist(0))
      lopen
      let w:locationlist_window = 1
    else
      echomsg 'LocList is empty'
    endif
  endif
endfunction

nnoremap <silent> <leader>lo :LocationListToggle<CR>

" Quickfix Toggle
command! QuickfixToggle call QuickfixToggle()
function! QuickfixToggle()
  if gettabvar(tabpagenr(), 'quickfix_window', 0)
    if t:quickfix_window == winnr()
      wincmd p
    endif
    cclose
    let t:quickfix_window = 0
  else
    copen
    let t:quickfix_window = winnr()
  endif
endfunction

nnoremap <silent> <leader>qf :QuickfixToggle<CR>

" Terminal Toggle
command! TerminalToggle call TerminalToggle()
let s:termbuf = 0
function! TerminalToggle()
  botright 10 split
  try
    execute 'buffer' . s:termbuf
    startinsert
  catch
    " terminal
    let s:termbuf = bufnr('%')
    tnoremap <buffer> <leader>te  <C-\><C-n>:close<CR>
  endtry
endfunction

nnoremap <leader>te :TerminalToggle<CR>

" Z within vim
command! -nargs=* Z call Z(<f-args>)
function! Z(...)
  let l:cmd = 'fasd -d -e printf'
  for l:arg in a:000
    let l:cmd = l:cmd . ' ' . l:arg
  endfor
  let l:path = system(l:cmd)
  if isdirectory(l:path)
    echo l:path
    execute 'cd ' . l:path
  endif
endfunction

" N within vim
command! -nargs=* E call E(<f-args>)
function! E(...)
  let l:cmd = 'fasd -f -e printf'
  for l:arg in a:000
    let l:cmd = l:cmd . ' ' . l:arg
  endfor
  let l:file = system(l:cmd)
  if filereadable(l:file)
    echo l:file
    execute 'edit ' . l:file
  endif
endfunction

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

" Change window layout
function! Rotate()
  let l:initial = winnr()
  execute 1 . 'wincmd w'
  wincmd l
  if winnr() != 1
    wincmd J
  else
    wincmd H
  endif
  execute l:initial . 'wincmd w'
endfunction

nnoremap <leader><space> :call Rotate()<CR>

" Better fold text
function! NeatFoldText()
  let l:fs = v:foldstart
  while getline(l:fs) =~# '^\s*$' | let l:fs = nextnonblank(l:fs + 1)
  endwhile
  if l:fs > v:foldend
    let l:line = getline(v:foldstart)
  else
    let l:line = substitute(getline(l:fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let l:w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let l:foldSize = 1 + v:foldend - v:foldstart
  let l:foldSizeStr = ' ' . l:foldSize . ' lines '
  let l:foldLevelStr = repeat('+--', v:foldlevel)
  let l:lineCount = line('$')
  let l:foldPercentage = printf('[%.1f', (l:foldSize*1.0)/l:lineCount*100) . '%] '
  let l:expansionString = repeat('.', l:w - strwidth(l:foldSizeStr.line.l:foldLevelStr.l:foldPercentage))
  return l:line . l:expansionString . l:foldSizeStr . l:foldPercentage . l:foldLevelStr
endf

set foldtext=NeatFoldText()

" Better Jumplist
function! JumpInFile(back, forw)
  let [n, i] = [bufnr('%'), 1]
  let p = [n] + getpos('.')[1:]
  sil! exe 'norm!1' . a:forw
  while 1
    let p1 = [bufnr('%')] + getpos('.')[1:]
    if n == p1[0] | break | endif
    if p == p1
      sil! exe 'norm!' . (i-1) . a:back
      break
    endif
    let [p, i] = [p1, i+1]
    sil! exe 'norm!1' . a:forw
  endwhile
endfunction

nnoremap <silent> <c-o> :call JumpInFile("\<c-i>", "\<c-o>")<cr>
nnoremap <silent> <c-i> :call JumpInFile("\<c-o>", "\<c-i>")<cr>
" }}}


" Plugins {{{

" Load Plugins {{{
call plug#begin('$HOME/.config/nvim/plugins')

" General
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'racket' }
Plug 'vim-airline/vim-airline'
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-dirvish'
Plug 'Raimondi/delimitMate'
Plug 'szw/vim-maximizer'
Plug 'othree/eregex.vim'
Plug 'Konfekt/FastFold'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

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
Plug 'janko-m/vim-test', { 'on': ['TestNearest','TestFile'] }
Plug 'kassio/neoterm', { 'on': ['Ttoggle','TREPLSend','TREPLSend'] }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }

" Completion, Formatters & Linters
Plug 'Chiel92/vim-autoformat'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim' | Plug 'zchee/deoplete-jedi' | Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neco-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'wellle/tmux-complete.vim'

" Language
Plug 'sheerun/vim-polyglot'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'wlangstroth/vim-racket'
Plug 'chrisbra/vim-zsh'
Plug 'lifepillar/pgsql.vim'
Plug 'pearofducks/ansible-vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'tweekmonster/braceless.vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'jinja2', 'css'] }
Plug 'alvan/vim-closetag', { 'for': ['html', 'jinja2', 'css'] }
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
let g:airline_inactive_collapse = 1
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_detect_crypt = 0
let g:airline_theme = 'dark'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Dirvish
nnoremap <silent>-      :Dirvish<CR>
nnoremap <silent> <M-d> :Dirvish $PROJECT_HOME<CR>

" Vim-Maximizer
nnoremap <silent> <C-z> :MaximizerToggle<CR>
tnoremap <silent> <C-z> :MaximizerToggle<CR>
" }}}

" Integration {{{
" Clever-F
let g:clever_f_fix_key_direction = 1

" Git-gutter
set updatetime=250
let g:gitgutter_enabled = 0

nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" Vim-EasyClip
let g:EasyClipShareYanks = 1
" let g:EasyClipShareYanksDirectory ='~/.config/nvim/easyclip/'
let g:EasyClipShareYanksDirectory ='$HOME/.tmp'
let g:EasyClipShareYanksFile = 'easyclip'
let g:EasyClipUsePasteToggleDefaults = 0

nmap <C-p> <plug>EasyClipSwapPasteForward
nmap <C-n> <plug>EasyClipSwapPasteBackwards

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" fzf.vim
set runtimepath+=$HOME/.fzf
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_history_dir = '$HOME/.fzf-history'
let g:fzf_tags_command = 'ctags -R'

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  let l:old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let l:selection = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  let &clipboard = l:old_clipboard
  execute 'Ag' l:selection
endfunction

function! SearchWithAgInDirectory(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

function! s:yank_list()
  redir => l:ys
  silent Yanks
  redir END
  return split(l:ys, '\n')[1:]
endfunction

function! s:yank_handler(reg)
  if empty(a:reg)
    echo "aborted register paste"
  else
    let l:token = split(a:reg, ' ')
    execute 'Paste' . l:token[0]
  endif
endfunction

command! FZFYanks call fzf#run({
      \ 'source': <sid>yank_list(),
      \ 'sink': function('<sid>yank_handler'),
      \ 'options': '-m',
      \ 'down': 12
      \ })

nnoremap <silent> <C-f>       :Files<CR>
nnoremap <silent> <M-f>       :Files $PROJECT_HOME<CR>
nnoremap <silent> <leader>M   :Maps<CR>
nnoremap <silent> <leader>R   :Marks<CR>
nnoremap <silent> <leader>S   :Snippets<CR>
nnoremap <silent> <leader>C   :Commands<CR>
nnoremap <silent> <leader>gL  :Lines<CR>
nnoremap <silent> <leader>bL  :BLines<CR>
nnoremap <silent> <leader>T   :Tags<CR>
nnoremap <silent> <leader>bT  :BTags<CR>
nnoremap <silent> <leader>/   :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>.   :AgIn
nnoremap <silent> <leader>gC  :Commits<CR>
nnoremap <silent> <leader>bC  :BCommits<CR>
nnoremap <silent> <leader>Y   :FZFYanks<CR>
nnoremap <silent> <leader>?   :History<CR>
nnoremap <silent> K           :call SearchWordWithAg()<CR>
vnoremap <silent> K           :call SearchVisualSelectionWithAg()<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
imap <leader><tab> <plug>(fzf-maps-i)
omap <leader><tab> <plug>(fzf-maps-o)

" TagBar
let g:tagbar_autofocus = 1
nnoremap <leader>tb :TagbarToggle<CR>

" Gutentag
let g:gutentags_cache_dir = '~/.tags'

" Vimux
let g:VimuxUseNearestPane = 0

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys('Enter')
endfunction

nnoremap <silent> <leader>vp :VimuxPromptCommand<CR>
nnoremap <silent> <leader>vl :VimuxRunLastCommand<CR>
nnoremap <silent> <leader>vq :VimuxCloseRunner<CR>
nnoremap <silent> <leader>vx :VimuxInterruptRunner<CR>
vnoremap <silent> <leader>vs "vy :call VimuxSlime()<CR>
nnoremap <silent> <leader>vs vip<LocalLeader>vs<CR><Paste>

" Neoterm
if exists('g:neoterm_loaded')
  set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
  set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
  set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*
endif

let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_run_tests_bg = 1
let g:neoterm_raise_when_tests_fail = 1
let g:neoterm_close_when_tests_succeed = 1

noremap <silent> <leader>rf :TREPLSendFile<CR>
noremap <silent> <leader>rs :TREPLSend<CR>
noremap <silent> <leader>rt :Ttoggle<CR>

" Vim-Test
let g:test#strategy = 'dispatch'

nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

" QuickRun
let g:quickrun_config=get(g:, 'quickrun_config', {})
let g:quickrun_config._={
      \'runner': 'vimproc',
      \'runner/vimproc/updatetime' : 10,
      \'outputter' : 'error',
      \'outputter/error/success' : 'message',
      \'outputter/error/error'   : 'quickfix',
      \'outputter/buffer/close_on_empty' : 1,
      \}

command! -nargs=0 QC call CloseQuickRunWindow()
function! CloseQuickRunWindow()
  execute "normal \<c-c>\<c-w>jZZ"
endfunction

nnoremap <silent> <leader>qc :QC<CR>
nnoremap <silent> <leader>qr :QuickRun -mode n<CR>
vnoremap <silent> <leader>qr :QuickRun -mode v<CR>
" }}}

" Completion, Formatters & Linters {{{
" Autoformat
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode = 0

" Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 0

" Deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=1

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Ultisnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsEditSplit = 'vertical'
" }}}

" Language {{{
" Vim-virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_stl_format = '[%n]'
let g:virtualenv_directory = $WORKON_HOME

" PGSQL.vim
let g:sql_type_default = 'pgsql'

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
  autocmd WinEnter term://* startinsert
  autocmd VimEnter * if isdirectory(expand('<amatch>')) | execute 'FZF! '.expand("<amatch>") | endif
  autocmd VimResized * wincmd =
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufWinEnter quickfix nnoremap <silent> <buffer>q :cclose<CR>:lclose<CR>
  autocmd BufWrite * if !exists('b:noAutoformat') | Autoformat | endif
  autocmd BufWrite * if !exists('b:noNeomake') | Neomake | endif
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufReadPost * if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
  autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
augroup END

augroup Working_Directory
  autocmd!
  autocmd BufLeave * let b:last_cwd = getcwd()
  autocmd BufEnter * if exists('b:last_cwd') |
        \   execute 'lcd' b:last_cwd |
        \ else |
        \   silent! Glcd |
        \ endif
  autocmd BufLeave * let b:last_cwd = getcwd()
augroup END

" }}}
