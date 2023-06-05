#
# Completions for the tealdeer implementation of tldr
# https://github.com/dbrgn/tealdeer/
#

complete -c tldr -s h -l help           -d 'Распечатать справочное сообщение.' -f
complete -c tldr -s v -l version        -d 'Показать информацию о версии.' -f
complete -c tldr -s l -l list           -d 'Список всех команд в кеше.' -f
complete -c tldr -s f -l render         -d 'Визуализация определенного файла md.' -r
complete -c tldr -s p -l platform       -d 'Override the operating system.' -xa 'linux macos sunos windows android'
complete -c tldr -s L -l language       -d 'Override the language' -x
complete -c tldr -s u -l update         -d 'Update the local cache.' -f
complete -c tldr      -l no-auto-update -d 'If auto update is configured, disable it for this run.' -f
complete -c tldr -s c -l clear-cache    -d 'Clear the local cache.' -f
complete -c tldr      -l pager          -d 'Use a pager to page output.' -f
complete -c tldr -s r -l raw            -d 'Display the raw markdown instead of rendering it.' -f
complete -c tldr -s q -l quiet          -d 'Suppress informational messages.' -f
complete -c tldr      -l show-paths     -d 'Show file and directory paths used by tealdeer.' -f
complete -c tldr      -l seed-config    -d 'Create a basic config.' -f
complete -c tldr      -l color          -d 'Controls when to use color.' -xa 'always auto never'

function __tealdeer_entries
    tldr --list | string replace -a -i -r "\,\s" "\n"
end

complete -f -c tldr -a '(__tealdeer_entries)'
