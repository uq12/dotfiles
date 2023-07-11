# Arch Linux

Чтобы отключить угадывание URL-адреса репозитория git, передайте параметр
`--guess-repo-url=false`

```sh
chezmoi init uq12 --branch=manjaro --ssh
```


### Убедитесь, что цель удалена ###

Создайте файл с именем `.chezmoiremove` в исходном каталоге, содержащий список
шаблонов файлов для удаления. chezmoi удалит все, что в целевом каталоге
соответствует шаблону. Поскольку эта команда потенциально опасна, вам следует
заранее запустить chezmoi в подробном режиме сухого запуска, чтобы посмотреть,
что будет удалено:


  chezmoi apply --dry-run --verbose 


`.chezmoiremove` интерпретируется как шаблон,поэтому вы можете удалять разные
файлы на разных компьютерах. Отрицательныесовпадения (шаблоны с префиксом a
!) или цели, перечисленные в `.chezmoiignore`, никогда не будут удалены.
