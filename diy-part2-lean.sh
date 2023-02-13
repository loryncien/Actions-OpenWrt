#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# git clone --depth=1 https://github.com/fw876/helloworld.git
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
# git clone --depth=1 -b luci https://github.com/xiaorouji/openwrt-passwall luci-app-passwall

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

pushd package
# Add luci-app-openclash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Add luci-app-unblockneteasemusic
git clone --depth=1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

# Add aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt aliyundrive
rm -rf ../feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf ../feeds/packages/multimedia/aliyundrive-webdav

# Add smartdns（必选）
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git
# git clone https://github.com/pymumu/smartdns.git package/smartdns
# rm -rf ../feeds/packages/net/smartdns

# Add gowebdav
#git clone --depth=1 https://github.com/immortalwrt/openwrt-gowebdav.git
svn export https://github.com/kenzok8/jell/trunk/luci-app-gowebdav
svn export https://github.com/kenzok8/jell/trunk/gowebdav

# Add luci-app-eqos
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos

# Add luci-app-poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff.git

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan.git

# Add luci-app-ddnsto
svn export https://github.com/linkease/nas-packages/trunk/network/services/ddnsto
svn export https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto

# Add luci-app-bandwidthd
git clone https://github.com/AlexZhuo/luci-app-bandwidthd.git

# Add luci-app-omcproxy
git clone --depth=1 -b 18.06 https://github.com/riverscn/luci-app-omcproxy.git

# Add Theme
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-tomato
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-mcat
git clone --depth=1 https://github.com/sirpdboy/luci-theme-opentopd
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git
# jerrykuku Argon theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../feeds/luci/themes/luci-theme-argon
popd

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# Modify localtime in Homepage
echo 'Modify localtime in Homepage...'
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm
# Modify hostname in Homepage
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

# Match Vermagic
#wget https://mirrors.cloud.tencent.com/lede/snapshots/targets/x86/64/packages/Packages.gz
#zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
#sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk

# ssrp duplicate nodes
sed -i 's#jsonStringify(result)#alias#g' $(find feeds/ -path '*shadowsocksr/subscribe.lua')
# luci-app-wrtbwmon 5s to 2s
sed -i 's#interval: 5#interval: 2#g' $(find feeds/ -name 'wrtbwmon.js')
sed -i 's# selected="selected"##' $(find feeds/ -name 'wrtbwmon.htm')
sed -i 's#"2"#& selected="selected"#' $(find feeds/ -name 'wrtbwmon.htm')

# 添加poweroff按钮
# curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
# curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# 修正连接数（by ベ七秒鱼ベ）
# sed -i '1i net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

pushd package/lean/default-settings/files
# 设置密码为空
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' zzz-default-settings
# 版本号里显示一个自己的名字
export date_version=$(date +'%Y.%m.%d')
sed -ri "s#(R[0-9].*[0-9])#\1 Build ${date_version} By Cheng #g" zzz-default-settings
popd

# custom settings
mkdir -p files/etc/uci-defaults
cp $GITHUB_WORKSPACE/scripts/init-settings.sh files/etc/uci-defaults/99-init-settings
chmod a+x files/etc/uci-defaults/*

