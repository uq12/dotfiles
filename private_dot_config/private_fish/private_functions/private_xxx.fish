#!/usr/bin/env fish
function xxx --description 'fix chebang and chmod 7777'
    termux-fix-shebang $argv
    chmod +x $argv
    stat $argv
end
