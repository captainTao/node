#!/bin/sh
# last update:2020/1/4,captain wang 
cd ~
# chinadns
echo "start to update chinadns..."
wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt
/etc/init.d/shadowsocks restart

echo "start to update China-list, GfwList..."
# China-List
# curl -L -o generate_dnsmasq_chinalist.sh https://github.com/cokebar/openwrt-scripts/raw/master/generate_dnsmasq_chinalist.sh
# chmod +x generate_dnsmasq_chinalist.sh

# GfwList
# curl -L -o gfwlist2dnsmasq.sh https://github.com/cokebar/gfwlist2dnsmasq/raw/master/gfwlist2dnsmasq.sh
# chmod +x gfwlist2dnsmasq.sh

# China-list
# ipset with dnsmasq-full installed:
# sh generate_dnsmasq_chinalist.sh -d 114.114.114.114 -p 53 -s ss_spec_dst_bp -o /etc/dnsmasq.d/accelerated-domains.china.conf

# with not-full dnsmasq--suggested:
sh generate_dnsmasq_chinalist.sh -d 114.114.114.114 -p 53 -o /etc/dnsmasq.d/accelerated-domains.china.conf


# GfwList
# ipset with dnsmasq-full installed:
# sh gfwlist2dnsmasq.sh -d 127.0.0.1 -p 5311 -s ss_spec_dst_fw -o /etc/dnsmasq.d/dnsmasq_gfwlist.conf

# with not-full-dnsmsaq--sugguested:
sh gfwlist2dnsmasq.sh -d 127.0.0.1 -p 5311 -o /etc/dnsmasq.d/dnsmasq_gfwlist.conf

# Restart dnsmasq
/etc/init.d/dnsmasq restart