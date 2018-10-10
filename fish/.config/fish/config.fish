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
set -x ASPNETCORE_ENVIRONMENT Development

# Add bin and ./local/bin to Path
if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end
if test -d $HOME/.local/bin
  set -x PATH $HOME/.local/bin $PATH
end

set -x PATH $HOME/.local/bin $PATH
# Add GEM/RVM to Path
if test -d $HOME/.rvm
  set -x GEM_HOME $HOME/.rvm/gems/ruby-2.3.0
  set -x GEM_PATH $GEM_HOME
  set -x PATH $GEM_HOME/bin $PATH
  bash -c 'source $HOME/.rvm/scripts/rvm'
  set -x PATH $HOME/.rvm/bin $PATH
end

# Add Linuxbrew to Path
if test -s $HOME/.linuxbrew
  set -x PATH "$HOME/.linuxbrew/brew/bin" $PATH
end

# Add Cargo to Path
if test -d $HOME/.cargo
  set -x CARGO_HOME $HOME/.cargo
  set -x CARGO_HOME $CARGO_HOME
  set -x PATH $CARGO_HOME/bin $PATH
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
  set -x GOROOT /usr/lib/go-1.9
  set -x GOPATH $HOME/Projects-Go
  set -x PATH $GOROOT/bin $PATH
end

# Add Heroku to Path
if test -d /usr/local/heroku/bin
  set -x PATH /usr/local/heroku/bin $PATH
end

# Add sqlcmd/bcp to Path
if test -d /opt/mssql-tools/bin
  set -x PATH /opt/mssql-tools/bin $PATH
end

# Add Postgresql to Path
if test -d /usr/lib/postgresql/9.6/bin
  set -x PATH /usr/lib/postgresql/9.6/bin $PATH
end

# # Virtualfish
# set -x VIRTUALFISH_HOME $HOME/.virtualenvs
# set -x VIRTUALFISH_DEFAULT_PYTHON /usr/bin/python3.5
# if not set -q VIRTUAL_ENV
#   eval ( python3 -m virtualfish auto_activation projects global_requirements)
# end

# Cheat
set -x CHEAT_EDITOR nvim
set -x VISUAL nvim
set -x EDITOR nvim
set -x DEFAULT_CHEAT_DIR $HOME/dotfiles/cheat/.config/cheat
set -x CHEATCOLORS true

# }}}


# {{{ Aliases

alias python='python3'
alias piggy ='~/.src/piggy/piggy-1.0.35-ubuntu.16.04-x64/piggy'
alias tmux='tmux new-session -A -s main'
alias todo "$HOME/.src/todo.txt_cli-2.9/todo.sh"

alias lss='exa --group-directories-first -G --color always --git-ignore'
alias lsa='exa --group-directories-first -G --color always --git-ignore -a'
alias nv='nvim'
alias etd='nvim $HOME/Dropbox/todo/todo.txt'
alias ei3='nvim $HOME/.config/i3/config'
alias ef='nvim $HOME/.config/fish/config.fish $HOME/.config/fish/functions/functions.fish'
alias ev='nvim $HOME/.vimrc'
alias et='nvim $HOME/.tmux.conf'
alias en='nvim $HOME/.config/nvim/init.vim $HOME/.config/nvim/plugs.vim'
alias eg='nvim $HOME/.gitconfig'
alias ee='nvim $PROJECT_HOME/.envrc'
alias ewp='nvim $PROJECT_HOME/webpack.config.js'

alias cdg='cd (git rev-parse --show-toplevel)'
alias tagit='ctags -R --exclude=.git --exclude=log *'
alias rtags='ripper-tags -R -f TAGS'

alias nlist='npm list -g --depth=0'
alias plist='pip freeze --local'
alias glist='gem list --local'

alias ag='ag --path-to-ignore ~/.ignore'

alias restartnet='sudo /etc/init.d/networking restart; and sudo dhclient'

alias pgstart='docker run --name postgres -e POSTGRES_PASSWORD=P@ssw0rd! -d postgres'
alias rabbitstart='docker run --name postgres --hostname my-rabbit -d rabbitmq:3'
alias redisstart='docker run --name redis -d redis'
alias mongostart='docker run --name mongo -d mongo'
alias mysqlstart='docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=P@ssw0rd! -d mysql'
alias elasticstart="docker run --name elastic -p 9200:9200 -p 9300:9300 -e 'discovery.type=single-node' -d docker.elastic.co/elasticsearch/elasticsearch:6.2.2"
alias sqlstart='docker run --name sql1 -p 1401:1433 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=P@ssw0rd!' -d microsoft/mssql-server-linux:2017-latest'

alias pgconnect='pgcli postgresql://postgres:P@ssw0rd!@172.17.0.2:5432/'
alias myconnect='mycli mysql://root:P@ssw0rd!@172.17.0.3:3306/'
alias redisconnect="redis-cli -h '172.17.0.3'"
alias dockerservices='docker start postgres mysql sql1 some-mongo redis'
alias pgconnect="pgcli postgresql://postgres:P@ssw0rd!@172.17.0.2:5432/'$DB'"

# }}}


# {{{ Functions

source $HOME/.config/fish/functions/functions.fish

# }}}


# {{{ Loadings

# Load direnv
eval (direnv hook fish)

# Load fishmarks
. $HOME/.fishmarks/marks.fish

# Load nvm
# bash -c 'source ~/.nvm/nvm.sh ; nvm use node;'

# Ensure LS colors are set
if not set -q LS_COLORS
  if type -f dircolors >/dev/null
    eval (dircolors -c ~/.dircolors | sed 's/>&\/dev\/null$//')
end
end

# }}}
