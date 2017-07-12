function pinstall
    pip install --user -r $HOME/dotfiles/packages/piplist.txt
    cat $HOME/dotfiles/packages/gemlist.txt | xargs gem install
    cat $HOME/dotfiles/packages/npmlist.txt | xargs npm install -g
end
