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
set relativenumber
set number
set nowrap
set textwidth=79
set winminheight=0
set whichwrap=b,s,h,l,<,>,[,]
set colorcolumn=80
set breakindent
set showbreak=\\\\\
set clipboard=
if has('clipit')
  set clipboard=unnamed
endif
highlight ColorColumn ctermbg=233
highlight ColorColumn ctermbg=0 guibg=#eee8d5
" Files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.gif,*.jpg,*.png,*.log
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=node_modules/*
set wildignore+=*.swp,*~,._*
set wildignore+=.DS_Store

if has('nvim')
  let g:python_host_prog = expand('$HOME'). '/.virtualenvs/neovim2.7/bin/python'
  let g:python3_host_prog = expand('$HOME'). '/.virtualenvs/neovim3.5/bin/python'
endif

if has('persistent_undo')
  set undodir=$HOME/.config/nvim/undodir
  set undofile
  set undolevels=10000
  set undoreload=10000
endif

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
nnoremap <leader>q  :qa<CR>
nnoremap <leader>x  :bd<CR>
nnoremap <leader>%  :new<CR>
nnoremap <leader>"  :vnew<CR>
nnoremap <leader>c  :enew<CR>

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

nnoremap <leader>ez  :edit $HOME/.zshrc<CR>
nnoremap <leader>sz  :source $HOME/.zshrc<CR>
nnoremap <leader>ef  :edit $HOME/.config/fish/config.fish<CR>
nnoremap <leader>sf  :source $HOME/.config/fish/config.fish<CR>
nnoremap <leader>etd :edit $HOME/Dropbox/todo/todo.txt<CR>

inoremap jj <Esc>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-y> <C-r>"

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-y> <C-r>"

" }}}


" Functions {{{

source ~/.config/nvim/functions.vim

nnoremap <silent> <leader>lo :LocationListToggle<CR>
nnoremap <silent> <leader>qf :QuickfixToggle<CR>
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
nnoremap <leader><space> :call Rotate()<CR>
nnoremap <silent> <c-o> :call JumpInFile("\<c-i>", "\<c-o>")<cr>
nnoremap <silent> <c-i> :call JumpInFile("\<c-o>", "\<c-i>")<cr>

" let g:last_relative_dir = ''
" nnoremap \1 :call RelatedFile ("models.py")<cr>
" nnoremap \2 :call RelatedFile ("views.py")<cr>
" nnoremap \3 :call RelatedFile ("urls.py")<cr>
" nnoremap \4 :call RelatedFile ("admin.py")<cr>
" nnoremap \5 :call RelatedFile ("tests.py")<cr>
" nnoremap \6 :call RelatedFile ( "templates/" )<cr>
" nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
" nnoremap \8 :call RelatedFile ( "management/" )<cr>
" nnoremap \0 :e settings.py<cr>
" nnoremap \9 :e urls.py<cr>

" }}}


" Plugins {{{

source ~/.config/nvim/plugs.vim

" Seoul256
let g:seoul256_background = 233
colo seoul256

highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" Vim-diminactive
let g:diminactive_enable_focus = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#promptline#enabled = 1
let g:airline#extensions#ale#enabled = 1
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

" Vim-Notes
let g:notes_directories = [expand('$HOME'). '/Dropbox/notes']
let g:notes_suffix = '.txt'

" Vim-Maximizer
nnoremap <silent> <C-z> :MaximizerToggle<CR>
if has('nvim')
  tnoremap <silent> <C-z> :MaximizerToggle<CR>
endif

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
let g:EasyClipShareYanksDirectory = expand('$HOME'). '/.config/nvim/easyclip'
let g:EasyClipShareYanksFile = 'easyclip'
let g:EasyClipUsePasteToggleDefaults = 0

" nmap <C-p> <plug>EasyClipSwapPasteForward
" nmap <C-n> <plug>EasyClipSwapPasteBackwards

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" fzf.vim
set runtimepath+=$HOME/.fzf
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_history_dir = '$HOME/.fzf-history'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = { 'down': '~40%' }

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

nnoremap <silent> <C-f>       :Files<CR>
nnoremap <silent> <M-f>       :Files $PROJECT_HOME<CR>
nnoremap <silent> <leader>M   :Maps<CR>
nnoremap <silent> <leader>C   :Commands<CR>
nnoremap <silent> <leader>T   :Tags<CR>
nnoremap <silent> <leader>bT  :BTags<CR>
nnoremap <silent> <leader>/   :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>gC  :Commits<CR>
nnoremap <silent> <leader>bC  :BCommits<CR>
nnoremap <silent> <leader>?   :History<CR>

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
let g:VimuxUseNearestPane = 1

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

" Autoformat
let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_verbose = 0
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 1

" Ale
nmap <c-n> <Plug>(ale_next_wrap)
nmap <c-p> <Plug>(ale_previous_wrap)
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0

" Deoplete/Ultisnips/Supertab
let g:deoplete#enable_at_startup = 1

set completeopt=menuone
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'ultisnips']
let g:deoplete#sources.vim = ['buffer,','vim']
let g:deoplete#omni#functions ={}

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:UltiSnipsExpandTrigger='<c-j>'
let g:SupTabClosePreviewOnPopupClose=1
let g:SuperTabCrMapping = 'false'
let g:SuperTabMappingBackward ='false'

if exists('g:deoplete')
  inoremap <expr><TAB>  pumvisiblj() ? "\<C-n>" : "\<TAB>"
end

" Vim-virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_stl_format = '[%n]'
let g:virtualenv_directory = $WORKON_HOME

" PGSQL.vim
let g:sql_type_default = 'pgsql'

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

" " Omnisharp
" let g:OmniSharp_selector_ui = 'fzf'
" let g:OmniSharp_server_type = 'v1'
" let g:OmniSharp_server_type = 'roslyn'

" augroup omnisharp_commands
"   autocmd!
"   "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
"   autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
"   " Synchronous build (blocks Vim)
"   "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
"   " Builds can also run asynchronously with vim-dispatch installed
"   autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
"   " Automatically add new cs files to the nearest project on save
"   autocmd BufWritePost *.cs call OmniSharp#AddToProject()
"   "show type information automatically when the cursor stops moving
"   autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"   "The following commands are contextual, based on the current cursor position.
"   autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
"   autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
"   autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
"   autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
"   autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
"   "finds members in the current buffer
"   autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
"   " cursor can be anywhere on the line containing an issue
"   autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
"   autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
"   autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
"   autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
"   "navigate up by method/property/field
"   autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
"   "navigate down by method/property/field
"   autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>
" augroup END

" }}}


" Autogroups {{{

augroup General
  autocmd!
  autocmd WinEnter term://* startinsert
  " autocmd VimEnter * if isdirectory(expand('<amatch>')) | execute 'FZF! '.expand("<amatch>") | endif
  autocmd VimResized * wincmd =
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufWinEnter quickfix nnoremap <silent> <buffer>q :cclose<CR>:lclose<CR>
  autocmd BufWritePre * undojoin | Neoformat
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufReadPost * if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
  " autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  " autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
  autocmd FocusLost,WinLeave * :silent! noautocmd w
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
