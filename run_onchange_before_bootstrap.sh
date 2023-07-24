#!/usr/bin/env fish
##
echo 'Выполняется до установки файлов'

# for i in awk basename bzip2 cat chmod cp curl cut du find grep gzip # head id mkdir proot rm sed tar xargs xz wget2; do
# if [ -z  ]; then
# echo
# echo Утилита ${i} не установлена. Невозможно продолжaть.
# echo
# exit 1
# fi
# done
# unset i

# for pkg in head id mkdir proot rm sed tar xargs xz wget2 head id mkdir proot rm sed tar xargs xz wget2
for pkg in exa bat direnv starship xorg-mkfontscale
    if [ -z  ]
        echo
        echo Утилита $pkg не установлена. Невозможно продолжaть.
        echo
	sudo pacman -S --noconfirm $pkg
    end
end 
