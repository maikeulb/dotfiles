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

# }}}

# {{{  FZF

function falias --description 'FZF fish aliases'
  if count $argv > /dev/null
    alias | rg $argv | fzf
  else
    alias | fzf
  end
end

function fbind --description 'FZF fish bindings'
  if count $argv > /dev/null
    bind | rg $argv | fzf
  else
    bind | fzf
  end
end

function fgit --description 'FZF git aliases'
  if count $argv > /dev/null
    git config --get-regexp alias | rg $argv | fzf
  else
    git config --get-regexp alias | fzf
  end
end

function ftkeys --description 'FZF Tmux keys'
  if count $argv > /dev/null
    command tmux list-keys | rg $argv | fzf
  else
    command tmux list-keys | fzf
  end
end

# FZF find file by name and pushd into directory
# bind \ct '__fzf_cd'

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

function chpwd --on-variable PWD --description "ls after changing directories"
  status --is-command-substitution; and return
  ls
end

function tree --description "tree"
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -T
end

function ls --description "use exa instead of ls"
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" $argv
end

function la --description "use exa instead of lsa"
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -a
end

function l1 --description "use exa instead of ls1"
  exa --group-directories-first --sort=extension -G --color always --git-ignore \
  --ignore-glob="obj|node_modules|dotfiles|Pictures|Videos|Music|__pycache__|venv" -1
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

function reload --description "reload fish config"
  source $HOME/.config/fish/config.fish
end

function yank --description "yank files to buffer"
  greadlink -f $argv > ~/.buffer &
end

function put --description "copy yanked files to current directory"
  cp (cat ~/.buffer) ./
end

function mput --description "move yanked files to current directory"
    mv (cat ~/.buffer) ./
end

# }}}
