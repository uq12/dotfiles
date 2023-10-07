# Ubuntu Linux (server)

Чтобы отключить угадывание URL-адреса репозитория git, передайте параметр
`--guess-repo-url=false`

```sh
chezmoi init uq12 --branch=ubuntu --ssh
```

```
sh -c "$(curl -fsLS git.io/chezmoi)" -- init uq12 --branch=ubuntu --apply --one-shot
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


Describe the solution you'd like
To add --no-scripts and --re-run-scripts to chezmoi apply, which would respectively apply but not run scripts, and apply and re-run the scripts already marked as ran.

It would be also good if we could have those options available on chezmoi init --apply as well.
