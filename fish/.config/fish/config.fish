# {{{ Variables

set -g fish_greeting
set -x XDG_CONFIG_HOME $HOME/.config
set -x TERM screen-256color
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESSOPEN "| pygmentize -g %s"
set -x LESS " -RiF "
set -x TODO $HOME/Dropbox/todo/
set -x BBHOME $HOME/Birchbox
set -g fish_user_paths "/usr/local/opt/mysql@5.6/bin" $fish_user_paths

set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_OPTS "--height 40"
set -x FZF_DEFAULT_COMMAND "rg --files --hidden --smart-case"
set -x RIPGREP_CONFIG_PATH "$HOME/.rgrc"

set -x CHEAT_USER_DIR $HOME/cheat
set -x CHEAT_COLORS true
set -x CHEAT_EDITOR nvim

set -x REVIEW_BASE master

set -x PATH /Users/michael.barnes/Library/Python/3.7/bin $PATH

# source develoment credentials (BIRCHBOX)
if test -e $HOME/.dev.env.fish
  source $HOME/.dev.env.fish
  # source $HOME/.dev.env.uk.fish
  # source $HOME/.dev.env.mike.fish
  load_dev_env_variables
end

# Add bin, .local/bin, /usr/local/bin, and /usr/local/sbin to Path
if test -d $HOME/bin
  set -x PATH $HOME/bin $PATH
end
if test -d $HOME/.local/bin
  set -x PATH $HOME/.local/bin $PATH
end
if test -d /usr/local/bin
  set -x PATH /usr/local/bin $PATH
end
if test -s /usr/local/sbin
  set -x PATH /usr/local/sbin $PATH
end
if test -s /Library/Frameworks/Mono.framework/Versions/Current/bin
  set -x PATH /Library/Frameworks/Mono.framework/Versions/Current/bin $PATH
end

# Add RVM to Path
if test -d $HOME/.rvm
  bash -c 'source $HOME/.rvm/scripts/rvm'
  set -x PATH $HOME/.rvm/bin $PATH
  rvm default
end

# Add Cargo to Path
if test -d $HOME/.rvm
  set -x PATH $HOME/.cargo/bin $PATH
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
  set -x NODE_PATH $NPM_PACKAGES/lib/node_modules $NODE_PATH
end

# Add GOPATH to Path
if test -d $HOME/.go
  set -x GOROOT /usr/lib/go-1.9
  set -x GOPATH $HOME/Projects-Go
  set -x PATH $GOROOT/bin $PATH
end

# # Add pyenv to Path
# if test -e $HOME/.pyenv/bin/pyenv
#   set -xg PATH $PATH $HOME/.pyenv/bin
#   set -xg PYENV_ROOT $HOME/.pyenv
# end

# # If pyenv exists then run it
# set pyenv_exists (which pyenv)
# if [ $pyenv_exists ];  test -x $pyenv_exists
#   source (pyenv init - --no-rehash | psub)
#   source (pyenv virtualenv-init - | psub)
#   if test -z "$VIMRUNTIME"
#     pyenv rehash
#   end
# end

# }}}


# {{{ Aliases

# alias tmux='tmux new-session -A -s main'
alias todo '$HOME/.src/todo.txt_cli-2.9/todo.sh'

alias nvimdiff='nvim -d'
alias lss='exa --group-directories-first -G --color always --git-ignore'
alias lsa='exa --group-directories-first -G --color always --git-ignore -a'
alias nv='nvim'
alias etd='nvim $TODO/todo.txt'
alias ei3='nvim $HOME/.config/i3/config'
alias ef='nvim $HOME/.config/fish/config.fish $HOME/.config/fish/functions/functions.fish $HOME/.config/fish/functions/bb_functions.fish'
alias ev='nvim $HOME/.vimrc'
alias evim='cheat -e vim'
alias et='nvim $HOME/.tmux.conf'
alias en='nvim $HOME/.config/nvim/init.vim $HOME/.config/nvim/plugs.vim $HOME/.config/nvim/functions.vim'
alias eg='nvim $HOME/.gitconfig'
alias ee='nvim $PROJECT_HOME/.envrc'
alias ewp='nvim $PROJECT_HOME/webpack.config.js'
alias getdate='date "+%Y%m%d%H%M%S"'

alias cdg='cd (git rev-parse --show-toplevel)'

alias nlist='npm list -g --depth=0'
alias plist='pip freeze --local'
alias glist='gem list --local'

alias restartnet='sudo /etc/init.d/networking restart; and sudo dhclient' # hacky dhclient solution
alias listen='netstat -anp tcp | rg listen'

# }}}


# {{{ Functions

source $HOME/.config/fish/functions/functions.fish
source $HOME/.config/fish/functions/bb_functions.fish

# }}}


# {{{ Loadings

# Load direnv
eval (direnv hook fish)

# Ensure LS colors are set
if not set -q LS_COLORS
  switch (uname)
    case Linux
      if type -f dircolors >/dev/null
        eval (dircolors -c ~/.dircolors | sed 's/>&\/dev\/null$//')
      end
    case Darwin
      set -x LS_COLORS "no=00;38;5;244:rs=0:di=00;38;5;33:ln=00;38;5;37:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=00;38;5;64:*.tar=00;38;5;61:*.tgz=00;38;5;61:*.arj=00;38;5;61:*.taz=00;38;5;61:*.lzh=00;38;5;61:*.lzma=00;38;5;61:*.tlz=00;38;5;61:*.txz=00;38;5;61:*.zip=00;38;5;61:*.z=00;38;5;61:*.Z=00;38;5;61:*.dz=00;38;5;61:*.gz=00;38;5;61:*.lz=00;38;5;61:*.xz=00;38;5;61:*.bz2=00;38;5;61:*.bz=00;38;5;61:*.tbz=00;38;5;61:*.tbz2=00;38;5;61:*.tz=00;38;5;61:*.deb=00;38;5;61:*.rpm=00;38;5;61:*.jar=00;38;5;61:*.rar=00;38;5;61:*.ace=00;38;5;61:*.zoo=00;38;5;61:*.cpio=00;38;5;61:*.7z=00;38;5;61:*.rz=00;38;5;61:*.apk=00;38;5;61:*.gem=00;38;5;61:*.jpg=00;38;5;136:*.JPG=00;38;5;136:*.jpeg=00;38;5;136:*.gif=00;38;5;136:*.bmp=00;38;5;136:*.pbm=00;38;5;136:*.pgm=00;38;5;136:*.ppm=00;38;5;136:*.tga=00;38;5;136:*.xbm=00;38;5;136:*.xpm=00;38;5;136:*.tif=00;38;5;136:*.tiff=00;38;5;136:*.png=00;38;5;136:*.PNG=00;38;5;136:*.svg=00;38;5;136:*.svgz=00;38;5;136:*.mng=00;38;5;136:*.pcx=00;38;5;136:*.dl=00;38;5;136:*.xcf=00;38;5;136:*.xwd=00;38;5;136:*.yuv=00;38;5;136:*.cgm=00;38;5;136:*.emf=00;38;5;136:*.eps=00;38;5;136:*.CR2=00;38;5;136:*.ico=00;38;5;136:*.tex=00;38;5;245:*.rdf=00;38;5;245:*.owl=00;38;5;245:*.n3=00;38;5;245:*.ttl=00;38;5;245:*.nt=00;38;5;245:*.torrent=00;38;5;245:*.xml=00;38;5;245:*Makefile=00;38;5;245:*Rakefile=00;38;5;245:*Dockerfile=00;38;5;245:*build.xml=00;38;5;245:*rc=00;38;5;245:*1=00;38;5;245:*.nfo=00;38;5;245:*README=00;38;5;245:*README.txt=00;38;5;245:*readme.txt=00;38;5;245:*.md=00;38;5;245:*README.markdown=00;38;5;245:*.ini=00;38;5;245:*.yml=00;38;5;245:*.cfg=00;38;5;245:*.conf=00;38;5;245:*.h=00;38;5;245:*.hpp=00;38;5;245:*.c=00;38;5;245:*.cpp=00;38;5;245:*.cxx=00;38;5;245:*.cc=00;38;5;245:*.objc=00;38;5;245:*.sqlite=00;38;5;245:*.go=00;38;5;245:*.sql=00;38;5;245:*.csv=00;38;5;245:*.log=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.lof=00;38;5;240:*.lol=00;38;5;240:*.lot=00;38;5;240:*.out=00;38;5;240:*.toc=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*~=00;38;5;240:*#=00;38;5;240:*.part=00;38;5;240:*.incomplete=00;38;5;240:*.swp=00;38;5;240:*.tmp=00;38;5;240:*.temp=00;38;5;240:*.o=00;38;5;240:*.pyc=00;38;5;240:*.class=00;38;5;240:*.cache=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.mpc=00;38;5;166:*.ogg=00;38;5;166:*.opus=00;38;5;166:*.ra=00;38;5;166:*.wav=00;38;5;166:*.m4a=00;38;5;166:*.axa=00;38;5;166:*.oga=00;38;5;166:*.spx=00;38;5;166:*.xspf=00;38;5;166:*.mov=00;38;5;166:*.MOV=00;38;5;166:*.mpg=00;38;5;166:*.mpeg=00;38;5;166:*.m2v=00;38;5;166:*.mkv=00;38;5;166:*.ogm=00;38;5;166:*.mp4=00;38;5;166:*.m4v=00;38;5;166:*.mp4v=00;38;5;166:*.vob=00;38;5;166:*.qt=00;38;5;166:*.nuv=00;38;5;166:*.wmv=00;38;5;166:*.asf=00;38;5;166:*.rm=00;38;5;166:*.rmvb=00;38;5;166:*.flc=00;38;5;166:*.avi=00;38;5;166:*.fli=00;38;5;166:*.flv=00;38;5;166:*.gl=00;38;5;166:*.m2ts=00;38;5;166:*.divx=00;38;5;166:*.webm=00;38;5;166:*.axv=00;38;5;166:*.anx=00;38;5;166:*.ogv=00;38;5;166:*.ogx=00;38;5;166:"
  end
end

# }}}
