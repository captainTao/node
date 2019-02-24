#!/bin/sh
# according to cokebar's shell script, symlink: https://cokebar.info/archives/664
# update by captain, on 02/24/2019

INSTALLED=$(opkg list-installed)

for a in $(opkg print-architecture | awk '{print $2}'); do
	case "$a" in
		all|noarch)
			;;
		aarch64_armv8-a|aarch64_cortex-a53|aarch64_cortex-a72|aarch64_generic|arm_arm926ej-s|arm_arm1176jzf-s_vfp|arm_cortex-a5|arm_cortex-a5_neon-vfpv4|arm_cortex-a5_vfpv4|arm_cortex-a7_neon-vfpv4|arm_cortex-a8_vfpv3|arm_cortex-a9|arm_cortex-a9_neon|arm_cortex-a9_vfpv3|arm_cortex-a15_neon-vfpv4|arm_cortex-a53_neon-vfpv4|arm_fa526|arm_mpcore|arm_mpcore_vfp|arm_xscale|armeb_xscale|i386_pentium|i386_pentium4|mips64_octeon|mips_24kc|mips_mips32|mipsel_24kc|mipsel_24kc_24kf|mipsel_74kc|mipsel_mips32|powerpc_464fp|powerpc_8540|x86_64)
			ARCH=${a}
			;;
		*)
			echo "Architectures not support."
			exit 0
			;;
	esac
done

echo -e "\nTarget Arch:\033[32m $ARCH \033[0m\n"

if !(grep -q "openwrt_dist" /etc/opkg/customfeeds.conf); then
	wget http://openwrt-dist.sourceforge.net/packages/openwrt-dist.pub
	opkg-key add openwrt-dist.pub
	echo "src/gz openwrt_dist http://openwrt-dist.sourceforge.net/packages/base/$ARCH" >>/etc/opkg/customfeeds.conf
	echo "src/gz openwrt_dist_luci http://openwrt-dist.sourceforge.net/packages/luci" >>/etc/opkg/customfeeds.conf
fi

opkg update

if echo "$INSTALLED" | grep -q "luci"; then
	LuCI=yes
fi

read -p "Install the ChinaDNS [Y/n]?" INS_CD
read -p "Install the DNS-Forwarder [Y/n]?" INS_DF
read -p "Install the shadowsocks-libev [Y/n]?" INS_SS
read -p "Install the simple-obfs [Y/n]?" INS_SO
read -p "Install the ShadowVPN [Y/n]?" INS_SV
read -p "Install the usb-storage [Y/n]?" INS_US   #symlink: https://wizju.com/post/123/
read -p "Install the usb-storage-3.0 addition [Y/n]?" INS_US3
read -p "Install the usb-printer [Y/n]? " INS_UP

if echo ${INS_CD} | grep -qi "^y"; then
	opkg install ChinaDNS
	if [ "$LuCI" = "yes" ]; then
		opkg install luci-app-chinadns
	fi
fi

if echo ${INS_DF} | grep -qi "^y"; then
	opkg install dns-forwarder
	if [ "$LuCI" = "yes" ]; then
		opkg install luci-app-dns-forwarder
	fi
fi

if echo ${INS_SS} | grep -qi "^y"; then
	opkg install shadowsocks-libev
	if [ "$LuCI" = "yes" ]; then
		opkg install luci-app-shadowsocks
	fi
fi

if echo ${INS_SO} | grep -qi "^y"; then
	opkg install simple-obfs
fi

if echo ${INS_SV} | grep -qi "^y"; then
	opkg install ShadowVPN
	if [ "$LuCI" = "yes" ]; then
		opkg install luci-app-shadowvpn
	fi
fi

if echo ${INS_US} | grep -qi "^y"; then     
	opkg install kmod-usb-core kmod-scsi-core kmod-scsi-generic kmod-usb-uhci kmod-usb-ohci kmod-usb2 kmod-usb-storage kmod-usb-storage-extras kmod-fs-ext4 kmod-fs-msdos kmod-fs-ntfs kmod-fs-vfat mount-utils
fi

if echo ${INS_US3} | grep -qi "^y"; then
	opkg install kmod-usb3
fi

if echo ${INS_UP} | grep -qi "^y"; then
	opkg install kmod-usb-printer
	wget -q 'https://raw.githubusercontent.com/captainTao/node/master/3800/luci-app-usb-printer_svn-r9961-1_all.ipk' && opkg install luci-app-usb-printer_svn-r9961-1_all.ipk
fi
