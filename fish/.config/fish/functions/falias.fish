function falias --description 'FZF fish aliases'
    if count $argv > /dev/null
        alias | ag $argv | fzf
    else
        alias | fzf
    end
end
