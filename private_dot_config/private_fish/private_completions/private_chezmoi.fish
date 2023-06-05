# fish completion for chezmoi                              -*- shell-script -*-

function __chezmoi_debug
    set -l file "$BASH_COMP_DEBUG_FILE"
    if test -n "$file"
        echo "$argv" >> $file
    end
end

function __chezmoi_perform_completion
    __chezmoi_debug "Starting __chezmoi_perform_completion"

    # Извлечь все аргументы, кроме последнего
    set -l args (commandline -opc)
    # Извлечь последний аргумент и экранировать его, если это пробел
    set -l lastArg (string escape -- (commandline -ct))

    __chezmoi_debug "args: $args"
    __chezmoi_debug "last arg: $lastArg"

    # Отключить ActiveHelp, который не поддерживается для оболочки рыбы
    set -l requestComp "CHEZMOI_ACTIVE_HELP=0 $args[1] __complete $args[2..-1] $lastArg"

    __chezmoi_debug "Calling $requestComp"
    set -l results (eval $requestComp 2> /dev/null)

    # Некоторые программы могут выводить лишние пустые строки после директивы.
    # Давайте проигнорируем их, иначе это нарушит завершение.
    # Ref: https://github.com/spf13/cobra/issues/1279
    for line in $results[-1..1]
        if test (string trim -- $line) = ""
            # Найдена пустая строка, удаляем ее
            set results $results[1..-2]
        else
            # Найдена непустая строка, у нас правильный вывод
            break
        end
    end

    set -l comps $results[1..-2]
    set -l directiveLine $results[-1]

    # Для Fish, при завершении флага с = (например, <program> -n=<TAB>)
    # завершение должно начинаться с флага
    set -l flagPrefix (string match -r -- '-.*=' "$lastArg")

    __chezmoi_debug "Comps: $comps"
    __chezmoi_debug "DirectiveLine: $directiveLine"
    __chezmoi_debug "flagPrefix: $flagPrefix"

    for comp in $comps
        printf "%s%s\n" "$flagPrefix" "$comp"
    end

    printf "%s\n" "$directiveLine"
end

# Эта функция делает две вещи:
# - Получить завершения и сохранить их в глобальном __chezmoi_comp_results
# - Вернуть false, если необходимо выполнить завершение файла
function __chezmoi_prepare_completions
    __chezmoi_debug ""
    __chezmoi_debug "========= starting completion logic =========="

    # Начать заново
    set --erase __chezmoi_comp_results

    set -l results (__chezmoi_perform_completion)
    __chezmoi_debug "Completion results: $results"

    if test -z "$results"
        __chezmoi_debug "No completion, probably due to a failure"
        # Можно также выполнить завершение файла, если это поможет
        return 1
    end

    set -l directive (string sub --start 2 $results[-1])
    set --global __chezmoi_comp_results $results[1..-2]

    __chezmoi_debug "Completions are: $__chezmoi_comp_results"
    __chezmoi_debug "Directive is: $directive"

    set -l shellCompDirectiveError 1
    set -l shellCompDirectiveNoSpace 2
    set -l shellCompDirectiveNoFileComp 4
    set -l shellCompDirectiveFilterFileExt 8
    set -l shellCompDirectiveFilterDirs 16

    if test -z "$directive"
        set directive 0
    end

    set -l compErr (math (math --scale 0 $directive / $shellCompDirectiveError) % 2)
    if test $compErr -eq 1
        __chezmoi_debug "Received error directive: aborting."
        # Можно также выполнить завершение файла, если это поможет
        return 1
    end

    set -l filefilter (math (math --scale 0 $directive / $shellCompDirectiveFilterFileExt) % 2)
    set -l dirfilter (math (math --scale 0 $directive / $shellCompDirectiveFilterDirs) % 2)
    if test $filefilter -eq 1; or test $dirfilter -eq 1
        __chezmoi_debug "File extension filtering or directory filtering not supported"
        # Do full file completion instead
        return 1
    end

    set -l nospace (math (math --scale 0 $directive / $shellCompDirectiveNoSpace) % 2)
    set -l nofiles (math (math --scale 0 $directive / $shellCompDirectiveNoFileComp) % 2)

    __chezmoi_debug "nospace: $nospace, nofiles: $nofiles"

    # If we want to prevent a space, or if file completion is NOT disabled,
    # we need to count the number of valid completions.
    # To do so, we will filter on prefix as the completions we have received
    # may not already be filtered so as to allow fish to match on different
    # criteria than the prefix.
    if test $nospace -ne 0; or test $nofiles -eq 0
        set -l prefix (commandline -t | string escape --style=regex)
        __chezmoi_debug "prefix: $prefix"

        set -l completions (string match -r -- "^$prefix.*" $__chezmoi_comp_results)
        set --global __chezmoi_comp_results $completions
        __chezmoi_debug "Filtered completions are: $__chezmoi_comp_results"

        # Important not to quote the variable for count to work
        set -l numComps (count $__chezmoi_comp_results)
        __chezmoi_debug "numComps: $numComps"

        if test $numComps -eq 1; and test $nospace -ne 0
            # We must first split on \t to get rid of the descriptions to be
            # able to check what the actual completion will be.
            # We don't need descriptions anyway since there is only a single
            # real completion which the shell will expand immediately.
            set -l split (string split --max 1 \t $__chezmoi_comp_results[1])

            # Fish won't add a space if the completion ends with any
            # of the following characters: @=/:.,
            set -l lastChar (string sub -s -1 -- $split)
            if not string match -r -q "[@=/:.,]" -- "$lastChar"
                # In other cases, to support the "nospace" directive we trick the shell
                # by outputting an extra, longer completion.
                __chezmoi_debug "Adding second completion to perform nospace directive"
                set --global __chezmoi_comp_results $split[1] $split[1].
                __chezmoi_debug "Completions are now: $__chezmoi_comp_results"
            end
        end

        if test $numComps -eq 0; and test $nofiles -eq 0
            # To be consistent with bash and zsh, we only trigger file
            # completion when there are no other completions
            __chezmoi_debug "Requesting file completion"
            return 1
        end
    end

    return 0
end

# Since Fish completions are only loaded once the user triggers them, we trigger them ourselves
# so we can properly delete any completions provided by another script.
# Only do this if the program can be found, or else fish may print some errors; besides,
# the existing completions will only be loaded if the program can be found.
if type -q "chezmoi"
    # The space after the program name is essential to trigger completion for the program
    # and not completion of the program name itself.
    # Also, we use '> /dev/null 2>&1' since '&>' is not supported in older versions of fish.
    complete --do-complete "chezmoi " > /dev/null 2>&1
end

# Remove any pre-existing completions for the program since we will be handling all of them.
complete -c chezmoi -e

# The call to __chezmoi_prepare_completions will setup __chezmoi_comp_results
# which provides the program's completion choices.
complete -c chezmoi -n '__chezmoi_prepare_completions' -f -a '$__chezmoi_comp_results'

