#!/bin/bash

#Get the necessary components
apt-get update
apt-get install xfce4 xfce4-terminal tightvncserver dbus-x11 -y
apt-get install xfe -y
apt-get clean

#Setup the necessary files
mkdir ~/.vnc
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Xfce4/xstartup --no-check-certificate -P ~/.vnc/
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Xfce4/vncserver-start --no-check-certificate -P /usr/local/bin/
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Xfce4/vncserver-stop --no-check-certificate -P /usr/local/bin/

chmod +x ~/.vnc/xstartup
chmod +x /usr/local/bin/vncserver-start
chmod +x /usr/local/bin/vncserver-stop

echo " "
echo "Теперь вы можете запустить vncserver, запустив vncserver-start"
echo " "
echo "Он попросит вас ввести пароль при первом запуске."
echo " "
echo "Сервер VNC будет запущен по адресу 127.0.0.1:5901."
echo " "
echo "Вы можете подключиться к этому адресу с помощью VNC Viewer, который вы предпочитаете"
echo " "
echo "При подключении к этому адресу откроется окно с Xfce4 Desktop Environment."
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
