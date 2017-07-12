function fserver
    # sleep 1
    chromium-browser http://localhost:8080/
    python -m http.server 8080 
end
