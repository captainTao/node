#!/bin/sh 

wget -qO /tmp/openwrt-dist.pub http://openwrt-dist.sourceforge.net/openwrt-dist.pub
opkg-key add /tmp/openwrt-dist.pub
rm /tmp/openwrt-dist.pub

opkg update
for ipk in $(opkg list-upgradable | awk '$1!~/^kmod|^Multiple/{print $1}'); do
  opkg upgrade $ipk
done
