#!/usr/bin/env fish
function pyhttp -a port -d "Start SimpleHTTPServer, optional argument for port number"
    if test -z "$port"
        set port 1025
    end

    echo "Собираюсь крутиться на http://0.0.0.0:$port"
    # nohup command command_arguments &
    # nohup __python -m SimpleHTTPServer $port &
    nohup python3 -m http.server $port &
    termux-open-url http://0.0.0.0:$port
end
