# {{{  Package Management and Cleanup

function apt-update
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get autoremove
    sudo apt-get clean
end

function package-update
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
    gem update
    gem cleanup
    npm update -g
    npm cache clean
    nvim +"PlugUpgrade | PlugClean! | PlugInstall | PlugUpdate | qa"
    fisher up
end

function package-freeze
    pip freeze --local >$HOME/dotfiles/packages/piplist.txt
    echo 'finished pip'
    gem list --local --no-versions --no-details -q >$HOME/dotfiles/packages/gemlist.txt
    echo 'finished gem'
    npm -g list -depth 0 | sed '1d' | cut -d ' ' -f 2 | cut -d '@' -f 1 | grep -vE 'npm|install' >$HOME/dotfiles/packages/npmlist.txt
    echo 'finished npm'
end

function package-install
    pip install --user -r $HOME/dotfiles/packages/piplist.txt
    cat $HOME/dotfiles/packages/gemlist.txt | xargs gem install
    cat $HOME/dotfiles/packages/npmlist.txt | xargs npm install -g
end

function gpip
    env PIP_REQUIRE_VIRTUALENV='' pip $argv
end

function gpip2
    env PIP_REQUIRE_VIRTUALENV='' pip2 $argv
end

# function _venvactivate --on-event virtualenv_did_activate
#     echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was activated"
# end

# function _venvdeactivate --on-event virtualenv_did_deactivate
#     echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was deactivated"
# end

# }}}

# {{{  FZF

function z --description 'z with fzf'
    set dir (fasd -Rdl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    cd $dir;
end

function n --description 'n with fzf'
    set file (fasd -Rfl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    nvim $file
end

function falias --description 'FZF fish aliases'
    if count $argv > /dev/null
        alias | ag $argv | fzf
    else
        alias | fzf
    end
end

function fbind --description 'FZF fish bindings'
    if count $argv > /dev/null
        bind | ag $argv | fzf
    else
        bind | fzf
    end
end

function fgit --description 'FZF git aliases'
    if count $argv > /dev/null
        git config --get-regexp alias | ag $argv | fzf
    else
        git config --get-regexp alias | fzf
    end
end

function ftkeys --description 'FZF Tmux keys'
    if count $argv > /dev/null
        command tmux list-keys | ag $argv | fzf
    else
        command tmux list-keys | fzf
    end
end

# FZF find file by name and open with nvim
bind \cf '__fzf_find_file'

function __fzf_find_file
  fd --type f | fzf | read -l result; and nvim $result
end

# FZF find file by name and pushd into directory
bind \ct '__fzf_cd'

# function __fzf_cd
#   fd --type f | fzf | read -l result; and pushd (dirname $result)
# end

# }}}

# {{{  File Management

function tmpdir --description "cd into a fresh, one-time temporary directory"
  function _tmpdir_clean
    functions -e _tmpdir_clean
    functions -e _tmpdir_usage
    functions -e _tmpdir
    functions -e _tmpdir_spawn
  end

  function _tmpdir_usage
    printf "Usage:  tmpdir\n"
    printf "        tmpdir [-s | --spawn]\n"
  end

  function _tmpdir
    if set --global --query TMPDIR_TAB
      cd $TMPDIR_TAB
      rm -rf -- {.*,*}
    else
      mkdir -p /tmp/tmpdir
      set --global TMPDIR_TAB (mktemp -d /tmp/tmpdir/XXXXXX)
      cd $TMPDIR_TAB
    end
  end

  function _tmpdir_spawn
    if set --global --query TMPDIR_TAB
      set --local old_tmpdir_tab $TMPDIR_TAB
      set --erase TMPDIR_TAB
    end

    _tmpdir
    fish
    cd -
    rm -rf -- $TMPDIR_TAB
    set --erase TMPDIR_TAB

    if set --local --query old_tmpdir_tab
      set --global TMPDIR_TAB $old_tmpdir_tab
    end
  end

  if test (count $argv) -eq 0
    _tmpdir
    _tmpdir_clean
    return
  end

  if test (count $argv) -eq 1
    switch "$argv[1]"
      case -s --spawn
        _tmpdir_spawn
        _tmpdir_clean
        return
    end
  end

  _tmpdir_usage
  _tmpdir_clean
  return 1
end

function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf -- $TMPDIR_TAB
  end
end

# }}}

# {{{  Utility Wrappers

# ls after changing directories
function chpwd --on-variable PWD
  status --is-command-substitution; and return
  ls
end

# cat
function ccat
    pygmentize -g $argv
end

# less
function cless
    pygmentize -g $argv | less -R
end    

# tree
function tree
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="bin|obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -T
end

# Use exa instead of ls
function ls
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="bin|obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv"
end

# Use exa instead of lsa
function la
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="bin|obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -a
end

# Use exa instead of ls1
function l1
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="bin|obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -1
end

# }}}

# {{{  Servers

function fmarkdown
    chromium-browser http://localhost:6419/
    grip
end

# }}}

# {{{  Development Utilities

function git-open
  pushd $PROJECT_HOME
  nvim (git status --porcelain | awk '{print $2}')
  popd
end

# }}}

# {{{  Misc

function nn
    nvim +edit note:$argv
end

function reload
    source $HOME/.config/fish/config.fish
end

function fishtime
    set start (date "+%s.%N")
    reload
    set end (date "+%s.%N")
    eval math $end-$start
end

function yank
    greadlink -f $argv > ~/.buffer &
end

function put
    cp (cat ~/.buffer) ./
end

function docker-stop-and-remove-all
    docker stop (docker ps -aq)
    docker rm (docker ps -aq)
end

# }}}
