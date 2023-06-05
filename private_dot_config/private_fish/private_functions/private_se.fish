#!/usr/bin/env fish
#
function se --description 'search packages'
    pkg se $argv[1]
    python -c 'print("#"*55)'
    poetry search $argv[1]
    python -c 'print("#"*55)'
    npm search $argv[1]
end
