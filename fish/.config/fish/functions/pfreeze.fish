function pfreeze
    pip freeze --local >$HOME/dotfiles/packages/piplist.txt
    echo 'finished pip'
    gem list --local --no-versions --no-details -q >$HOME/dotfiles/packages/gemlist.txt
    echo 'finished gem'
    npm -g list -depth 0 | sed '1d' | cut -d ' ' -f 2 | cut -d '@' -f 1 | grep -vE 'npm|install' >$HOME/dotfiles/packages/npmlist.txt
    echo 'finished npm'
end
