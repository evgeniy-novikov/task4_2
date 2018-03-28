#!/bin/bash

apt-get -y install ntp

mkdir /opt/controlled_files/

#echo -e "server ua.pool.ntp.org iburst prefer" ; cat /etc/ntp.conf | grep -v "server "
sed -i '/server [[:digit:]]\+/d' /etc/ntp.conf
echo "server ua.pool.ntp.org iburst" >> /etc/ntp.conf

cat /etc/ntp.conf > /opt/controlled_files/ntp.conf

cat /opt/controlled_files/ntp.conf > /etc/ntp.conf

/etc/init.d/ntp stop ; sleep 1 ; /etc/init.d/ntp start

scr_dir=`pwd`
(cat /etc/crontab | grep ntp_verify.sh) || echo "*/5* * * * root $scr_dir/ntp_verify.sh" >> /etc/crontab
