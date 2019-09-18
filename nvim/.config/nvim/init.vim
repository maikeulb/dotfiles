" Settings {{{

" General
set title
set hidden
set gdefault
set noswapfile
set autowrite
set expandtab
set lazyredraw
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
" set synmaxcol=128
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
set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*

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
  let g:python_host_prog = expand('$HOME'). '/.pyenv/shims/python'
  let g:python3_host_prog = expand('$HOME'). '/.pyenv/shims/python3'
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

set nofoldenable
set foldlevel=20
set foldlevelstart=20

" }}}

" Mappings {{{

let g:mapleader = "\<Space>"

nnoremap <backspace> <nop>
nnoremap <S> <nop>

nnoremap ; :
nnoremap : ;

nnoremap ,; @:<CR>
" marks
nnoremap gm m  
nnoremap gu gUiw`]

nnoremap g; g;zz
nnoremap g, g,zz
nnoremap n nzz
nnoremap N Nzz

nnoremap Y y$
nnoremap D d$
nnoremap C m$
nnoremap H 0
nnoremap L $

nnoremap oo o<Esc>k
nnoremap OO O<Esc>
nnoremap ss a<space><Esc>h
nnoremap SS i<space><Esc>h
nnoremap od 0D

nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap <leader>r :%sh\<<C-r>=expand('<cword>')<CR>\>//gc<Left><Left><Left>

nnoremap <leader>wr <C-W>r
nnoremap <leader>q  :qa!<CR>
nnoremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>.

nnoremap <leader>"  :split<CR>
nnoremap <leader>%  :vsplit<CR>
nnoremap <leader>c  :enew<CR>

nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprevious<CR>
nnoremap <silent> <leader>ln :lnext<CR>
nnoremap <silent> <leader>lp :lprevious<CR>
nnoremap <silent> <leader>jj :bprevious<CR>
nnoremap <silent> <leader>kk :bnext<CR>

nnoremap <leader>en  :edit $MYVIMRC<CR>
nnoremap <leader>sv  :source $MYVIMRC<CR>
nnoremap <leader>ef  :edit $HOME/.config/fish/config.fish<CR>
nnoremap <leader>etd :edit $HOME/Dropbox/todo/todo.txt<CR>

inoremap jj <Esc>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-y> <C-r>"

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-y> <C-r>"

nnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>y "+y
vnoremap <leader>d "+d

nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
nnoremap <leader>P :set paste<CR>"+P:set nopaste<CR>
vnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>P :set paste<CR>"+P:set nopaste<CR>
" }}}


" Functions {{{

source ~/.config/nvim/functions.vim

nnoremap <silent> <leader>lo :LocationListToggle<CR>
nnoremap <silent> <leader>qf :QuickfixToggle<CR>
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
nnoremap <leader><space> :call Rotate()<CR>
nnoremap <silent> <c-o> :call JumpInFile("\<c-i>", "\<c-o>")<cr>
nnoremap <silent> <c-i> :call JumpInFile("\<c-o>", "\<c-i>")<cr>

" }}}


" Plugins {{{

source ~/.config/nvim/plugs.vim

" Color
let g:seoul256_background = 233
colorscheme seoul256

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
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.g:airline_symbols.space, 'linenr', 'maxlinenr', g:airline_symbols.space.'%2.3c%-.3V'])
let g:airline_detect_crypt = 0
let g:airline_theme = 'dark'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Dirvish
nnoremap <silent>- :Dirvish<CR>

" Vim-Notes
let g:notes_directories = [expand('$HOME'). '/Dropbox/notes']
let g:notes_suffix = '.txt'

" Vim-Maximizer
nnoremap <silent> <C-z> :MaximizerToggle<CR>

" Clever-F
let g:clever_f_fix_key_direction = 1

" Vim-EasyClip
let g:EasyClipShareYanks = 1
let g:EasyClipShareYanksDirectory = expand('$HOME'). '/.config/nvim/easyclip'
let g:EasyClipShareYanksFile = 'easyclip'
let g:EasyClipUsePasteToggleDefaults = 0

" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>

" Ferret
let g:FerretMap = 0

" fzf.vim
set runtimepath+=$HOME/.fzf
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_history_dir = '$HOME/.fzf-history'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = { 'down': '~40%' }

" gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif
let g:gutentags_trace=0
let g:gutentags_enabled=0
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <silent> <C-f>       :Files<CR>
nnoremap <silent> <C-_>       :BLines<CR>
nnoremap <silent> <C-t>       :Tags<CR>
nnoremap <silent> <C-b>       :Buffers<CR>
nnoremap <silent> <C-g>       :Ag<CR>
nnoremap <silent> <leader>M   :Maps<CR>
nnoremap <silent> <leader>C   :Commands<CR>

" " Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:autoformat_verbosemode=1
let g:jsx_ext_required = 0
" " format paragraph with gq

" Vim-go
let g:go_fmt_autosave=0

" Ale
nmap <c-n> <Plug>(ale_next_wrap)
nmap <c-p> <Plug>(ale_previous_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Vim-virtualenv
let g:virtualenv_auto_activate = 1
let g:virtualenv_stl_format = '[%n]'
let g:virtualenv_directory = $WORKON_HOME

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Clever F
let g:clever_f_across_no_line=1
let g:clever_f_ignore_case=1

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

" Committia
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    setlocal spell

    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif
endfunction

" }}}


" Autogroups {{{

augroup General
  autocmd!
  autocmd WinEnter term://* startinsert
  autocmd VimResized * wincmd =
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufWinEnter quickfix nnoremap <silent> <buffer>q :cclose<CR>:lclose<CR>
  autocmd BufWritePre * call AutoFormatFiles()
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufReadPost * if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
  autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
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

augroup EditLastFile
  autocmd!
  autocmd VimEnter * nested
        \  if argc() == 0
        \|   let last = filter(filter(copy(v:oldfiles), 'match(v:val, getcwd()) == 0'), 'filereadable(v:val)')
        \|   if !empty(last)
          \|     execute 'edit' fnameescape(last[0])
          \|   endif
          \| endif
augroup END

fun! AutoFormatFiles()
  if exists('b:noAutoFormat')
    return
  endif
  undojoin | :Autoformat
endfun

augroup AutoFormatFileExtensions
  autocmd!
  autocmd BufEnter *.fsproj | setlocal noAutoFormat=1
augroup END

augroup filetypedetect
  au! BufNewFile,BufRead *.csx setf cs
  au! BufNewFile,BufRead *.env setf sh
  au! BufNewFile,BufRead *.envrc setf sh
augroup END

" }}}
