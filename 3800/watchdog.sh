#!/bin/sh

# watch the network status, if down, then restart or reboot.

PING=`ping -c 4 www.baidu.com|grep -v grep|grep '64 bytes' |wc -l`
if [ ${PING} -ne 0 ];then
    exit 0
else
    echo `date +%Y-%m-%d_%H:%M:%S` "restart network" >> watchdog.log
    /etc/init.d/network restart

    sleep 15

    PING2=`ping -c 4 www.baidu.com|grep -v grep|grep '64 bytes' |wc -l`
    if [ ${PING2} -ne 0 ];then
        exit 0
    else
        echo `date +%Y-%m-%d_%H:%M:%S` "reboot device" >> watchdog.log
        reboot
    fi
fi