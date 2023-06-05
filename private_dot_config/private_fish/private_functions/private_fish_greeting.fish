

function fish_greeting -d "Приветственное сообщение при запуске сеанса оболочки"

    echo ""
    echo -en "        |         " (welcome_message) "\n"
    echo -en "       / \        \n"
    echo -en "      / _ \       " (show_date_info) "\n"
    echo -en "     |.o '.|      \n"
    echo -en "     |'._.'|       Компьютер космического корабля:\n"
    echo -en "     |     |      " (show_os_info) "\n"
    echo -en "   ,'|  |  |`.    " (show_cpu_info) "\n"
    echo -en "  /  |  |  |  \   " (show_mem_info) "\n"
    echo -en "  |,-'--|--'-.|   " (show_net_info) "\n"
    echo ""
    set_color grey
    echo "Желаю хорошей поездки"
    set_color normal
end


function welcome_message -d "Приветствуйте пользователя"

    echo -en "Добро пожаловать на борт капитана "
    set_color FFF  # белый
    echo -en (whoami) "!"
    set_color normal
end


function show_date_info -d "Выводит информацию о дате"

    set --local up_time (uptime | cut -d "," -f1 | cut -d "p" -f2 | sed 's/^ *//g')

    set --local time (echo $up_time | cut -d " " -f2)
    set --local formatted_uptime $time

    switch $time
    case "days" "day"
        set formatted_uptime "$up_time"
    case "min"
        set formatted_uptime $up_time"utes"
    case '*'
        set formatted_uptime "$formatted_uptime ч"
    end

    echo -en "Сегодня "
    set_color cyan
    echo -en (date +%d.%m.%Y)
    set_color normal
    echo -en ", мы работаем "
    set_color cyan
    echo -en "$formatted_uptime"
    set_color normal
    echo -en "."
end


function show_os_info -d "Выводит информацию об операционной системе"

    set_color yellow
    echo -en "\tOS: "
    set_color 0F0  # green
    echo -en (uname -mo)
    set_color normal
end


function show_cpu_info -d "Выводит информацию о процессоре"

    set --local os_type (uname -s)
    set --local cpu_info ""

    if [ "$os_type" = "Linux" ]

        set --local procs_n (grep -c "^processor" /proc/cpuinfo)
        set --local cores_n (grep "cpu cores" /proc/cpuinfo | head -1 | cut -d ":"  -f2 | tr -d " ")
        set --local cpu_type (grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2)
        set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"

    else if [ "$os_type" = "Darwin" ]

        set --local procs_n (system_profiler SPHardwareDataType | grep "Number of Processors" | cut -d ":" -f2 | tr -d " ")
        set --local cores_n (system_profiler SPHardwareDataType | grep "Cores" | cut -d ":" -f2 | tr -d " ")
        set --local cpu_type (system_profiler SPHardwareDataType | grep "Processor Name" | cut -d ":" -f2 | tr -d " ")
        set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"
    end

    set_color yellow
    echo -en "\tCPU: "
    set_color 0F0  # green
    echo -en $cpu_info
    set_color normal
end


function show_mem_info -d "Распечатывает информацию о памяти"

    set --local os_type (uname -s)
    set --local total_memory ""

    if [ "$os_type" = "Linux" ]
        set total_memory (free -h | grep "Mem" | cut -d " " -f 12)

    else if [ "$os_type" = "Darwin" ]
        set total_memory (system_profiler SPHardwareDataType | grep "Memory:" | cut -d ":" -f 2 | tr -d " ")
    end

    set_color yellow
    echo -en "\tОбъем памяти: "
    set_color 0F0  # green
    echo -en $total_memory
    set_color normal
end


function show_net_info -d "Распечатывает информацию о сети"

    set --local os_type (uname -s)
    set --local ip ""
    set --local gw ""

    # if [ "$os_type" = "Linux" ]
    # set ip (ip address show | grep -E "inet .*" | cut -d " " -f6)
    set ip (myip)
    set gw (ip route | cut -d " " -f9)

    # else if [ "$os_type" = "Darwin" ]
        # set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        # set gw (netstat -nr | grep -E "default.*UGSc" | cut -d " " -f13)
    # end

    set_color yellow
    echo -en "\tNet: "
    set_color 0F0  # green
    echo -en "IP-адрес $ip, шлюз по умолчанию $gw"
    set_color normal
end
