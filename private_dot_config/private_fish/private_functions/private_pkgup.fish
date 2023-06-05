#!/usr/bin/env fish
#
function pkgup --description 'pkg full up'
    apt update 
    clear
    sleep 2
    $PREFIX/bin/apt list --upgradable
    sleep 2
    pkg upgrade -y
    sleep 2
    pkg autoclean -y
    sleep 1
    pkg clean -y
    $PREFIX/bin/apt autoremove -y
end
