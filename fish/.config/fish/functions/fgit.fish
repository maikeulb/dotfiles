function fgit --description 'FZF git aliases'
    if count $argv > /dev/null
        git config --get-regexp alias | ag $argv | fzf
    else
        git config --get-regexp alias | fzf
    end
end
