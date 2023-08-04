function tor-check
curl --socks5 localhost:9050 --socks5-hostname localhost:9050 -s https://check.torproject.org/api/ip | jq .'IP'
end
