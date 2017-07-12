function z --description 'z with fzf'
    set dir (fasd -Rdl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    cd $dir; ls
end
