function n --description 'n with fzf'
    set file (fasd -Rfl $argv \
  | sed "s:$HOME:~:" \
  | fzf -1 -0 --no-sort +m \
  | sed "s:~:$HOME:")
    nvim $file
end
