function fbind --description 'FZF fish bindings'
    if count $argv > /dev/null
        bind | ag $argv | fzf
    else
        bind | fzf
    end
end
