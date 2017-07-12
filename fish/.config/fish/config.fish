# {{{ Variables

set -g fish_greeting

set -x XDG_CONFIG_HOME $HOME/.config
set -x TERM screen-256color
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x RANGER_LOAD_DEFAULT_RC 0
set -x PIP_REQUIRE_VIRTUALENV 0
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_OPTS "--height 10"
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESSOPEN "| pygmentize -g %s"
set -x LESS " -RiF "

# Add bin and ./local/bin to Path
if test -d $HOME/bin
    set -x PATH $HOME/bin $PATH
end
if test -d $HOME/.local/bin
    set -x PATH $HOME/.local/bin $PATH
end

# Add GEM/RVM to Path
if test -d $HOME/.rvm
    set -x GEM_HOME $HOME/.rvm/gems/ruby-2.3.0
    set -x GEM_PATH $GEM_HOME
    set -x PATH $GEM_HOME/bin $PATH
    bash -c 'source $HOME/.rvm/scripts/rvm'
    set -x PATH $HOME/.rvm/bin $PATH
end

# Add Local PIP to Path
if test -d $HOME/.pip/cache
    set -x PIP_DOWNLOAD_CACHE $HOME/.pip/cache
end

# Add NPM to Path
if test -d $HOME/.npm-packages/bin
    set -x NPM_PACKAGES $HOME/.npm-packages
    set -x PATH $NPM_PACKAGES/bin $PATH
    # set -x NPM_CONFIG_PREFIX $HOME/.npm-packages
    # set -x MANPATH $NPM_PACKAGES/share/man (manpath)
    set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH
end

# Add GOPATH to Path
if test -d $HOME/.go
    set -x GOPATH $HOME
    set -x GOROOT /usr/local/go
    set -x PATH $GOPATH/bin $PATH
end

# Add Heroku to Path
if test -d /usr/local/heroku/bin
    set -x PATH /usr/local/heroku/bin $PATH
end

# Add Postgresql to Path
if test -d /usr/lib/postgresql/9.6/bin
    set -x PATH /usr/lib/postgresql/9.6/bin $PATH
end

# Virtualfish
set -x VIRTUALFISH_HOME $HOME/.virtualenvs
set -x VIRTUALFISH_DEFAULT_PYTHON /usr/bin/python3.5
set -x PROJECT_HOME $HOME/projects
if not set -q VIRTUAL_ENV
  eval ( python3 -m virtualfish auto_activation projects global_requirements)
end

# Overcommit
set -x GIT_TEMPLATE_DIR `overcommit --template-dir`

# Autoenv
# source $HOME/.config/fisherman/autoenv_fish/activate.fish

# Cheat
set -x CHEAT_EDITOR nvim
set -x VISUAL nvim
set -x EDITOR nvim
set -x DEFAULT_CHEAT_DIR $HOME/dotfiles/cheat/.config/cheat
set -x CHEATCOLORS true

# }}}


# {{{ Abbreviations

# Git
abbr g 'git'
abbr ga 'git add'
abbr ga. 'git add .'
abbr gb 'git branch'
abbr gbd 'git branch -D'
abbr gcm 'git commit -m'
abbr gca 'git commit --amend --no-edit'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcod 'git checkout development'
abbr gi 'gitignore'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push -f origin master'
abbr gpsu 'git push -u origin master'
abbr gpl 'git pull'
abbr gs 'git status'
abbr gc 'git clone'
abbr gd 'git diff'
abbr grs "git reset --soft"
abbr grh "git reset --hard"
abbr gcp "git cherry-pick"
abbr gl "git lg"
abbr gpom="git pull origin master"
abbr gfom="git fetch origin master"

# }}}


# {{{ Aliases

alias python='python3'
alias tmux='tmux new-session -A -s main'
# alias tmux='tmux attach'
alias todo "$HOME/src/todo.txt_cli-2.9/todo.sh"

alias ..='cd ..'
alias p='cd $OLDPWD'
alias la='ls -Ga'
alias lsd='ls -l | grep "^d"'
alias ll='ls -ahlF'

alias D='cd $HOME/Downloads'
alias N='cd $HOME/Dropbox/notes'
alias db='cd $HOME/Dropbox'
alias d='cd $HOME/dotfiles'
alias vi='cd $HOME/.virtualenvs'

alias etd='nvim $HOME/Dropbox/todo/todo.txt'
alias ez='nvim $HOME/.zshrc'
alias sz='source $HOME/.zshrc'
alias ezp='nvim $HOME/.zpreztorc'
alias ei3='nvim $HOME/.config/i3/config'
alias ef='nvim $HOME/.config/fish/config.fish'
alias ev='nvim $HOME/.vimrc'
alias et='nvim $HOME/.tmux.conf'
alias en='nvim $HOME/.config/nvim/init.vim $HOME/.config/nvim/plugs.vim'
alias eg='nvim $HOME/.gitconfig'
alias ei='nvim $HOME/.ipython/profile_default/ipython_config.py'

alias cdg='cd (git rev-parse --show-toplevel)'
alias tagit='ctags -R --exclude=.git --exclude=log *'
alias rtags='ripper-tags -R -f TAGS'

alias gg='git grep -E'
alias grep='grep --color=auto'

alias nlist='npm list -g --depth=0'
alias plist='pip freeze --local'
alias glist='gem list --local'

# }}}


# {{{ Functions

function start-mongo
  if test (lsb_release -cs) = 'xenial'
  sudo service mongod start
  #/usr/bin/mongod
  #/var/lib/mongodb
  #/etc/mongodb.conf
    else
  sudo mongod --fork --config /etc/mongodb.conf
  end
end

function stop-mongo
  if test (lsb_release -cs) = 'xenial'
  sudo service mongod stop
    else
  sudo mongod --dbpath /var/lib/mongodb --shutdown
  end
end

function start-postgres
  sudo service postgresql start
  #/usr/lib/postgresql/9.6/bin/pg_ctl
  #/var/lib/postgresql/9.3/main
  #/etc/postgresql/9.6/main/postgresql.conf
end

function stop-postgres
  sudo service postgresql stop
end

function start-redis
  sudo service redis_6379 stop
end

function stop-redis
  sudo service redis_6379 stop
end

function cd
    if [ -n $argv[1] ]
        builtin cd $argv[1]
        and ls
    else
        builtin cd ~
        and ls
    end
end

function _venvactivate --on-event virtualenv_did_activate
    echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was activated"
end

function _venvdeactivate --on-event virtualenv_did_deactivate
    echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was deactivated"
end

# }}}

# Always run TMUX
if test -n $TMUX
    command tmux attach ^/dev/null
end

function mtimes
  for dir in */
    pushd $dir > /dev/null
    echo $dir (mtime)
    popd > /dev/null
  end
end

# bash -c 'source ~/.nvm/nvm.sh ; nvm use node;'

# New Vim-notes
function nn
    nvim +edit note:$argv
end
