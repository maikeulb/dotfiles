function mdlf
    youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" -a playlist
end
