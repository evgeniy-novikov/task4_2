#!/bin/bash

ntp_conf=/etc/ntp.conf
ntp_conf_orig=/opt/controlled_files/ntp.conf

ntp_stat=`ps ax | grep -v grep | grep ntpd | wc -l`

if [ $ntp_stat -eq "0" ];
then
    echo "NOTICE: ntp is not running"
    /etc/init.d/ntp start
fi

change_ntp=`diff -q $ntp_conf_orig $ntp_conf |wc -l`

if [ $change_ntp -eq "1" ];
then
    echo "NOTICE: $ntp_conf was changed. Calculated diff:"
    diff -U 0 $ntp_conf_orig $ntp_conf
    cat $ntp_conf_orig > $ntp_conf
    /etc/init.d/ntp restart
fi