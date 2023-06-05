#!/usr/bin/env fish
function tor-start
    pkill tor
    sleep 5
    printf api
    tor -f $HOME/.torrc
    curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/api/ip | jq .'IP'
    curl --socks5 localhost:9052 --socks5-hostname localhost:9052 -s https://check.torproject.org/api/ip | jq .'IP'
    curl --socks5 localhost:9053 --socks5-hostname localhost:9053 -s https://check.torproject.org/api/ip | jq .'IP'
    curl --socks5 localhost:9054 --socks5-hostname localhost:9054 -s https://check.torproject.org/api/ip | jq .'IP'
end
