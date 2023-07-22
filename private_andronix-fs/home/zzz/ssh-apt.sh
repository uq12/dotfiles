#!/bin/bash

#Получить необходимые компоненты
apt-get update
apt-get install openssh-server -y

#Установите необходимые файлы
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/SSH/Apt/sshd_config --no-check-certificate -P /etc/ssh

echo "Теперь вы можете запустить OpenSSH Server, запустив /etc/init.d/ssh start"
echo " "
echo "Открытый сервер будет запущен по адресу 127.0.0.1:22."
