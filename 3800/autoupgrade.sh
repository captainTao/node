#!/bin/sh
# last update:2019/1/26,captain wang 
cd ~
# 备份原来的文件
echo "start to backup the previous file..."
cp generate_dnsmasq_chinalist.sh ./backupfile
cp gfwlist2dnsmasq.sh ./backupfile
cp /etc/chinadns_chnroute.txt ./backupfile
cp -r /etc/dnsmasq.d/. ./backupfile

#更新所有ipk
echo "start to update the latest ipk..."
opkg update
for ipk in $(opkg list-upgradable | awk '$1!~/^kmod|^Multiple/{print $1}'); do
	opkg upgrade $ipk
done
# 另外一种更新方法：
# opkg list-upgradable | awk -F ' - ' '{print $1}' | xargs opkg upgrade

# 更新chinadns
echo "start to update chinadns..."
wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt
/etc/init.d/shadowsocks restart

echo "start to update China-list, GfwList..."
# China-List
curl -L -o generate_dnsmasq_chinalist.sh https://github.com/cokebar/openwrt-scripts/raw/master/generate_dnsmasq_chinalist.sh
chmod +x generate_dnsmasq_chinalist.sh
# GfwList
curl -L -o gfwlist2dnsmasq.sh https://github.com/cokebar/gfwlist2dnsmasq/raw/master/gfwlist2dnsmasq.sh
chmod +x gfwlist2dnsmasq.sh

# China-list  114可以换成ISP的dns,这样运营商分配最近的服务器
sh generate_dnsmasq_chinalist.sh -d 114.114.114.114 -p 53 -o /etc/dnsmasq.d/accelerated-domains.china.conf
# GfwList
sh gfwlist2dnsmasq.sh -d 127.0.0.1 -p 5311 -o /etc/dnsmasq.d/dnsmasq_gfwlist.conf
# Restart dnsmasq
/etc/init.d/dnsmasq restart