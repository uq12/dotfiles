#!/data/data/com.termux/files/usr/bin/env bash

for i in awk basename bzip2 cat chmod cp curl cut du find grep gzip \
	head id mkdir proot rm sed tar xargs xz wget2; do
	if [ -z "$(command -v "$i")" ]; then
		echo
		echo "Утилита '${i}' не установлена. Невозможно продолжaть."
		echo
		exit 1
	fi
done
unset i

