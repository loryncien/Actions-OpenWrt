#!/bin/sh
#===============================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG
# Blog: https://mlapp.cn
#===============================================

([ -x /bin/bash ] && ! grep -q "^root.*bash" /etc/passwd) && sed -i "s/^\(root.*\/\)ash/\1bash/g" /etc/passwd

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# Disable opkg signature check
# sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
# 删除distfeeds.conf里面包含关键词的所在行
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf

# Disable IPV6 ula prefix
# sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Check file system during boot
# uci set fstab.@global[0].check_fs=1
# uci commit fstab

# 默认关闭ipv6 dhcp、ULA
uci -q delete dhcp.lan.ra
uci -q delete dhcp.lan.dhcpv6
uci -q delete dhcp.lan.ra_management
uci commit dhcp
uci -q delete network.globals
uci -q delete network.wan6
uci commit network

# 计划任务
# uci set system.@system[0].cronloglevel="9"
# uci commit system

# 开启ttyd账户密码登录(已开启)
# uci set system.@system[0].ttylogin=1

exit 0