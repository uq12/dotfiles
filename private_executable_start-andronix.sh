cd $(dirname $0)
pulseaudio -k >>/dev/null 2>&1
pulseaudio --start >>/dev/null 2>&1
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r andronix-fs"
if [ -n "$(ls -A andronix-binds)" ]; then
for f in andronix-binds/* ;do
. $f
done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b andronix-fs/root:/dev/shm"
command+=" -b andronix-fs/proc/fakethings/stat:/proc/stat"
command+=" -b andronix-fs/proc/fakethings/vmstat:/proc/vmstat"
command+=" -b andronix-fs/proc/fakethings/version:/proc/version"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=ru_RU.UTF-8"
command+=" LC_ALL=C"
command+=" LANGUAGE=ru_RU"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
exec $command
else
$command -c "$com"
fi
