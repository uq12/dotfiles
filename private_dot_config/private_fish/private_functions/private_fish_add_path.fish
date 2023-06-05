function fish_add_path --description "Add paths to the PATH"
    # Это должно быть простым универсальным магазином для добавления вещей в $PATH.
    # По умолчанию заданные пути добавляются к универсальному $fish_user_paths, за исключением уже включенных.
    #
    # Это означает, что его можно выполнить один раз в интерактивном сеансе или запихнуть в config.fish,
    # и он сделает все правильно.
    #
    # The options:
    # --prepend или --append, чтобы выбрать, ставить ли новые пути первыми или последними
    # --global или --universal, чтобы решить, использовать ли универсальный или глобальный fish_user_paths
    # --path для установки $PATH вместо этого
    # --move для перемещения существующих записей вместо их игнорирования
    # --verbose для вывода используемой команды set
    # --dry-run для печати команды set без ее запуска
    # Мы не допускаем универсальной установки $PATH.
    #
    # По умолчанию он сохраняет $fish_user_paths или создает универсальный, добавляя и игнорируя существующие записи.
    argparse -x g,U -x P,U -x a,p g/global U/universal P/path p/prepend a/append h/help m/move v/verbose n/dry-run -- $argv
    or return

    if set -q _flag_help
        __fish_print_help fish_add_path
        return 0
    end

    set -l scope $_flag_global $_flag_universal
    if not set -q scope[1]; and not set -q fish_user_paths
        set scope -U
    end

    set -l var fish_user_paths
    set -q _flag_path
    and set var PATH
    # $PATH должен быть глобальным
    and set scope -g
    set -l mode $_flag_prepend $_flag_append
    set -q mode[1]; or set mode -p

    # Чтобы сохранить порядок наших аргументов, пройдите и сохраните те, которые мы хотим сохранить.
    set -l newpaths
    set -l indexes
    for path in $argv
        # Realpath позволяет нам канонизировать путь, необходимый для дедупликации.
        # Мы могли бы добавить неканоническую версию заданного пути, если не существует дубликата, но это прямой путь к катастрофе.

        # realpath жалуется, если родительский каталог не существует, поэтому отключаем stderr.
        set -l p (builtin realpath -s -- $path 2>/dev/null)

        # Ignore non-existing paths
        if not test -d "$p"
            # path does not exist
            if set -q _flag_verbose
                # напечатать сообщение в подробном режиме
                printf (_ "Пропуск несуществующего пути: %s\n") "$p"
            end
            continue
        end

        if set -l ind (contains -i -- $p $$var)
            # В режиме перемещения мы удаляем его из текущей позиции и добавляем обратно.
            if set -q _flag_move; and not contains -- $p $newpaths
                set -a indexes $ind
                set -a newpaths $p
            end
        else if not contains -- $p $newpaths
            # Без перемещения мы добавляем его только в том случае, если его нет.
            set -a newpaths $p
        end
    end

    # Ensure the variable is only set once, by constructing a new variable before.
    # This is to stop any handlers or anything from firing more than once.
    set -l newvar $$var
    if set -q _flag_move; and set -q indexes[1]
        # We remove in one step, so the indexes don't move.
        set -e newvar["$indexes"]
    end
    set $mode newvar $newpaths

    # Finally, only set if there is anything *to* set.
    # This saves us from setting, especially in the common case of someone putting this in config.fish
    # to ensure a path is in $PATH.
    if set -q newpaths[1]; or set -q indexes[1]
        if set -q _flag_verbose; or set -q _flag_n
            # The escape helps make it unambiguous - so you see whether an argument includes a space or something.
            echo (string escape -- set $scope $var $newvar)
        end

        not set -q _flag_n
        and set $scope $var $newvar
        return 0
    else
        return 1
    end
end
