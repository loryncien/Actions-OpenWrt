#!/bin/sh
#===============================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG
# Blog: https://mlapp.cn
#===============================================

# [ -x /usr/bin/zsh ] && sed -i "s#^\(root.*root:\)/bin/ash#\1/usr/bin/zsh#g" /etc/passwd

# Set default theme to luci-theme-argon`
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

uci set nlbwmon.@nlbwmon[0].refresh_interval=2s
uci commit nlbwmon

# Disable opkg signature check
# sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
# Delete the line containing the keyword in distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf

# Check file system during boot
uci set fstab.@global[0].check_fs=1
uci commit fstab

# Disable IPV6 ula prefix
# sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Disable IPv6 DHCP, ULA
uci -q delete dhcp.lan.ra
uci -q delete dhcp.lan.dhcpv6
uci -q delete dhcp.lan.ra_management
uci commit dhcp
uci -q delete network.globals
uci -q delete network.wan6
uci commit network

# cron
# uci set system.@system[0].cronloglevel="9"
# uci commit system

# 开启ttyd账户密码登录(已开启)
# uci set system.@system[0].ttylogin=1

# sirpdboy luci-app-netdata-cn 不能启动
[ -f /etc/init.d/netdata ] && chmod +x /etc/init.d/netdata

exit 0
