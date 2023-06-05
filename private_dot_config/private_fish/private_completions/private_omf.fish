# SYNOPSIS
#   Completions for Oh My Fish CLI

complete -c omf -f -d "Oh My Fish"

function __omf_assert_args_count -a count
    set -l cmd (commandline -poc)
    set -e cmd[1]
    test (count $cmd) -eq $count
end

set -l installed_themes (omf.packages.list --theme)
set -l installed_plugins (omf.packages.list --plugin)
set -l installed $installed_themes $installed_plugins
for subcommand in "r rm remove" "c cd" "u update"
  complete -c omf -f -n "__fish_seen_subcommand_from $subcommand; and __omf_assert_args_count 1" -a "$installed_themes" -d theme
  complete -c omf -f -n "__fish_seen_subcommand_from $subcommand; and __omf_assert_args_count 1" -a "$installed_plugins" -d plugin
end

set -l available_themes (omf.index.query --type=theme)
set -l available_plugins (omf.index.query --type=plugin)
for subcommand in "i install" "d describe"
  complete -c omf -f -n "__fish_seen_subcommand_from $subcommand" -a "$available_themes" -d theme
  complete -c omf -f -n "__fish_seen_subcommand_from $subcommand" -a "$available_plugins" -d plugin
end

complete -c omf -f -n "__fish_seen_subcommand_from d desc describe" -a (printf "%s " (omf.index.query --type=plugin))
complete -c omf -f -n "__fish_seen_subcommand_from t theme"         -a "$installed_themes"
complete -c omf -f -n "__fish_seen_subcommand_from channel"         -a "stable dev"
complete -c omf -f -n "__fish_seen_subcommand_from help"            -a "cd channel describe destroy doctor help install get list ls new reload remove uninstall repo repositories search theme update version"

complete -c omf -f -a cd       -n "__fish_use_subcommand" -d "Измените каталог на каталог plugin/theme"
complete -c omf -f -a channel  -n "__fish_use_subcommand" -d "Получает или изменяет канал обновления"
complete -c omf -f -a describe -n "__fish_use_subcommand" -d "Получить информацию о том, что делают пакеты"
complete -c omf -f -a destroy  -n "__fish_use_subcommand" -d "Удалить Oh My Fish"
complete -c omf -f -a doctor   -n "__fish_use_subcommand" -d "Устранение неполадок Oh My Fish"
complete -c omf -f -a help     -n "__fish_use_subcommand" -d "Показать эту справку"
complete -c omf -f -a install  -n "__fish_use_subcommand" -d "Установите один или несколько пакетов"
complete -c omf -f -a list     -n "__fish_use_subcommand" -d "Список локальных пакетов"
complete -c omf -f -a new      -n "__fish_use_subcommand" -d "Создать новый пакет из шаблона"
complete -c omf -f -a reload   -n "__fish_use_subcommand" -d "Перезагрузить текущую оболочку"
complete -c omf -f -a remove   -n "__fish_use_subcommand" -d "Удалить тему или пакет"
complete -c omf -f -a repositories -n "__fish_use_subcommand" -d "Управление репозиториями пакетов"
complete -c omf -f -n "__fish_seen_subcommand_from repo repositories; and __omf_assert_args_count 1" -a add -d "Добавить репозиторий пакетов"
complete -c omf -f -n "__fish_seen_subcommand_from repo repositories; and __omf_assert_args_count 1" -a list -d "Список установленных репозиториев"
complete -c omf -f -n "__fish_seen_subcommand_from repo repositories; and __omf_assert_args_count 1" -a remove -d "Удалить репозиторий пакетов"
complete -c omf -f -a search   -n "__fish_use_subcommand" -d "Поиск плагина или темы"
complete -c omf -f -a theme    -n "__fish_use_subcommand" -d "Установить и перечислить темы"
complete -c omf -f -a update   -n "__fish_use_subcommand" -d "Обновлить Oh My Fish"
complete -c omf -f -a version  -n "__fish_use_subcommand" -d "Показать версию"
