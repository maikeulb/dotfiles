function fishtime
    set start (date "+%s.%N")
    reload
    set end (date "+%s.%N")
    eval math $end-$start
end
