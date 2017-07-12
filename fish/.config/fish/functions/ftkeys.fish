function ftkeys --description 'FZF Tmux keys'
    if count $argv > /dev/null
        command tmux list-keys | ag $argv | fzf
    else
        command tmux list-keys | fzf
    end
end
