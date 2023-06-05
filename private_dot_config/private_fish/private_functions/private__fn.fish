function _fn --description 'filename '
    set fn (date +%S%N)
    echo $fn.$argv[1]
    touch >$fn.$argv[1]
end
