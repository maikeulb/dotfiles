function udlf
    youtube-dl -o '%(playlist)s/%(chapter_number)s - %(chapter)s/%(playlist_index)s - %(title)s.%(ext)s' --cookies ~/Udemy/udemy-cookies.txt --min-sleep-interval 30 --max-sleep-interval 180 -a playlist
end

# youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" --cookies ~/Udemy/udemy-cookies.txt --min-sleep-interval 20 --max-sleep-interval 120 -a playlist

