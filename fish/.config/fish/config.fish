set start (date "+%s.%N")

# {{{ Exports

set fish_greeting
set -x PATH $HOME/bin $PATH
set -U FZF_LEGACY_KEYBINDINGS 0
set -x EDITOR "nvim"

# Language
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# ADD XDG_CONFIG_HOME variable
set -x XDG_CONFIG_HOME $HOME/.config

# Add RVM to Path
if test -d $HOME/.gem
    set -x GEM_HOME $HOME/.gem
    set -x PATH $HOME/.rvm/bin $PATH
    set -x PATH $GEM_HOME/ruby/2.3.0/bin $PATH
end

# Add Local PIP to Path
if test -d $HOME/.pip/cache
    set -x PIP_DOWNLOAD_CACHE $HOME/.pip/cache
    set -x PATH $PATH:$HOME/.local/bin
end

# Add GOPATH to Path
if test -d $HOME/.go
    set -x GOPATH $HOME/.go
    set -x PATH $GOROOT/bin:$GOPATH/bin $PATH
end

# Add Heroku to Path
if test -d /usr/local/heroku/bin
    set -x PATH /usr/local/heroku/bin $PATH
end

# Xterm
if test $TERM = 'xterm'
    set -gx TERM xterm-256color
end

# Virtualfish

set -x VIRTUALFISH_HOME $HOME/.virtualenvs
set -x VIRTUALFISH_DEFAULT_PYTHON /usr/bin/python3
set -x PROJECT_HOME $HOME/projects
eval (python3 -m virtualfish auto_activation)

if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
end

# # Dropbox
# if eval (dropbox status) =~ "Dropbox isn't running\!"
#     eval (dropbox start)
# end

# }}}


# {{{ Abbreviations

# Apt-Get
abbr ar 'sudo apt-get autoremove'
abbr dug 'sudo apt-get dist-upgrade'
abbr i 'sudo apt-get install'
abbr r 'sudo apt-get remove'
abbr u 'sudo apt-get update'
abbr ug 'sudo apt-get upgrade'

# Git
abbr g 'git'
abbr ga 'git add'
abbr ga. 'git add .'
abbr gb 'git branch'
abbr gbd 'git branch -D'
abbr gca 'git commit -am'
abbr gcm 'git commit -m'
abbr gcm!!! 'git add .'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcod 'git checkout development'
abbr gi 'gitignore'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpl 'git pull'
abbr gpsu 'git push -u origin master'
abbr gs 'git status'
abbr gc 'git clone'
abbr gd 'git diff'
abbr grs "git reset --soft"
abbr grh "git reset --hard"
abbr gcp "git cherry-pick"
abbr gl "git lg"
abbr gpom="git pull origin master"

# Other
abbr pg 'pgrep -l'
abbr psg 'ps -ef | grep'
abbr ccat 'pygmentize -g'

# Source todo.txt
source "$HOME/.config/fish/todotxt.fish"

# }}}


# {{{ Aliases

alias python='python3'
alias rm ='echo "This is not the command you are looking for."
false'

alias ..='cd ..'
alias la='ls -Ga'
alias lsd='ls -l | grep "^d"'
alias ll='ls -ahlF'

alias D='cd $HOME/Downloads'
alias d='cd $HOME/Dropbox'
alias df='cd $HOME/dotfiles'
alias p='cd $HOME/project'

alias psef='ps -ef | peco '
alias top='top -o cpu'

alias etd='nvim $HOME/Dropbox/todo/todo.txt'
alias ez='nvim $HOME/.zshrc'
alias sz='source $HOME/.zshrc'
alias ezp='nvim $HOME/.zpreztorc'
alias ef='nvim $HOME/.config/fish/config.fish'
alias ev='nvim $HOME/.vimrc'
alias et='nvim $HOME/.tmux.conf'
alias en='nvim $HOME/.config/nvim/init.vim'
alias eg='nvim $HOME/.gitconfig'
alias ei='nvim $HOME/.ipython/profile_default/ipython_config.py'

alias json='python -m json.tool'
# alias tmux='TERM=screen-256color-bce tmux'
alias yaml='js-yaml'
alias mktmp='mktmpenv --no-cd'
alias cdg='cd (git rev-parse --show-toplevel)'
alias tagit='ctags -R --exclude=.git --exclude=log *'
alias rtags='ripper-tags -R -f TAGS'
# alias t='/home/mike/src/todo.txt_cli-2.9/todo.sh -d /home/mike/src/todo.txt_cli-2.9/todo.cfg'
alias gitsearch='git rev-list --all | xargs git grep'

alias gg='git grep -E'
alias grep='grep --color=auto'
alias gfrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# }}}


# {{{ Functions

function server --description "Start an HTTP server from a directory"
    open http://localhost:8080/
    and python -m SimpleHTTPServer 8080
end

function md
    open http://localhost:5000/
    and grip
end

function cd --description "auto ls for each cd"
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        and ls
    else
        builtin cd ~
        and ls
    end
end

function pkill --description "pkill a process interactively"
    ps aux | peco | awk '{ print $2 }' | xargs kill
end

function ppkill --description "kill -9 a process interactively"
    ps aux | peco | awk '{ print $2 }' | xargs kill -KILL
end

function pgrep --description "pgrep a process interactively"
    ps aux | peco | awk '{ print $2 }'
end

function gpip
    env PIP_REQUIRE_VIRTUALENV='' pip $argv
end

function mdu
    du -sh * | sort -h
end

function mdlf
    youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" -a playlist
end

function reload
    source $HOME/.config/fish/config.fish
end

function __go-to-git-root
    cd (git rev-parse --show-toplevel)
end

function gitroot
    if pwd != (git rev-parse --show-toplevel)
        __go-to-git-root
    else if test (cd ..; and git rev-parse --is-inside-work-tree > /dev/null ^&1; echo $status) -eq 0
        cd ..
        and __go-to-git-root
    end
end

function cleanpycs
    find . -name '.git' -prune -o -name '__pycache__' -delete
    find . -name '.git' -prune -o -name '*.py[co]' -delete
end

# {{{ FZF functions

# Fuzzy tmux keys
function ftk
    if count $argv >dev/null
        tmux list-keys | ag $argv | fzf
    else
        tmux list-keys | fzf
    end
end

# Fuzzy git alias
function fga
    if count $argv >dev/null
        git config --get-regexp alias | ag $argv | fzf
    else
        git config --get-regexp alias | fzf
    end
end

# Fuzzy fish alias
function fa
    if count $argv >dev/null
        alias | ag $argv | fzf
    else
        alias | fzf
    end
end

# Fuzzy fish abbr
function fab
    if count $argv >dev/null
        alias | ag $argv | fzf
    else
        alias | fzf
    end
end

# Fuzzy fish bindings
function fab
    if count $argv >dev/null
        bind | ag $argv | fzf
    else
        bind | fzf
    end
end

# n with fzf
function n
    set file (fasd -Rfl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    nvim $file
end

# z with fzf
function z
    set dir (fasd -Rdl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    and
    nvim $dir
    or
    return 1
end

# Fuzzy cd to previous
function fcp
    # Clear non-existent folders from cdhist.
    set -l buf
    for i in (seq 1 (count $dirprev))
        set -l dir $dirprev[$i]
        if test -d $dir
            set buf $buf $dir
        end
    end
    set dirprev $buf
    string join \n $dirprev | tac | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
    [ "$result" ]
    and cd $result
    commandline -f repaint
end

# }}}

# }}}


set end (date "+%s.%N")
math $end-$start


# Git
# The format of git-log output is configurable: brief, oneline, and medium
# zstyle ':prezto:module:git:log:context' format 'brief'

# # Start the dropbox daemon if it isn't running.
# if [[ $+commands[dropbox] == 1 &
# & $(dropbox status) =~ "Dropbox isn't running\!" ]]
# then
# dropbox start
# fi
