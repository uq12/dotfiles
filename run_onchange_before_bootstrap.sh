#!/bin/sudo bash

#Получить необходимые компоненты
apt-get update -y
apt install -y xfce4 xfce4-goodies
apt-get install -y mate-desktop-environment-core mate-terminal tightvncserver dbus-x11 
apt-get install xfe -y
apt install -y tigervnc-standalone-server
apt-get clean
##Установите необходимые файлы
#mkdir ~/.vnc
# wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Mate/xstartup --no-check-certificate -P ~/.vnc/
#wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Mate/vncserver-start --no-check-certificate -P /usr/local/bin/
#wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Mate/vncserver-stop --no-check-certificate -P /usr/local/bin/

#chmod +x ~/.vnc/xstartup
#chmod +x /usr/local/bin/vncserver-start
#chmod +x /usr/local/bin/vncserver-stop

apt install -y wireguard
# sudo wget https://cp.beget.com/shared/e6Jmxu-7HNF6kc5jffrWJ0vU2mOQrGgE/wireguard.conf -O /etc/wireguard/beget.conf
# Установите необходимые пакеты:
# Ubuntu/Debian
# sudo apt install wireguard
# Fedora
# sudo dnf install wireguard-tools
# CentOS 8
# sudo yum install elrepo-release epel-release && sudo yum install kmod-wireguard wireguard-tools
# Названия пакетов для других дистрибутивов вы можете найти на официальном сайте.
# Скачайте конфигурационный файл в директорию Wireguard: sudo wget https://cp.beget.com/shared/e6Jmxu-7HNF6kc5jffrWJ0vU2mOQrGgE/wireguard.conf -O /etc/wireguard/beget.conf.
# Для подключения VPN используйте команду sudo wg-quick up beget в терминале.
# Для отключения VPN используйте команду sudo wg-quick down beget в терминале.
#
apt update && sudo apt install -y strongswan network-manager-strongswan libcharon-extra-plugins 
echo " "
echo "Теперь вы можете запустить vncserver, запустив vncserver-start"
echo " "
echo "Он попросит вас ввести пароль при первом запуске."
echo " "
echo "Сервер VNC будет запущен по адресу 127.0.0.1:5901."
echo " "
echo "Вы можете подключиться к этому адресу с помощью VNC Viewer, который вы предпочитаете"
echo " "
echo "При подключении к этому адресу откроется окно с Mate Desktop Environment."
echo " "
echo " "
echo " "
echo "Запуск vncserver-start"
echo " "
echo " "
echo " "
echo "Чтобы убить VNC-сервер, просто запустите vncserver-stop"
echo " "
echo " "
echo " "

echo "export DISPLAY=":1"" >> /etc/profile
source /etc/profile

vncserver-start
