function pupdate
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U
    gem update
    gem cleanup
    npm update -g
    npm cache clean
    nvim +"PlugUpgrade | PlugClean! | PlugInstall | PlugUpdate | qa"
    fisher up
end
