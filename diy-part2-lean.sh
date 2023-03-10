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

pushd package
# Add luci-app-openclash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Add luci-app-unblockneteasemusic
git clone --depth=1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
# unblockneteasemusic core
NAME=$"luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic" && mkdir -p $NAME/core
curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)">"$NAME/core_local_ver"
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o $NAME/core/app.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o $NAME/core/bridge.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o $NAME/core/ca.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o $NAME/core/server.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o $NAME/core/server.key
# uclient-fetch Use IPv4 only
sed -i 's/uclient-fetch/uclient-fetch -4/g' luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic/update.sh

# Add luci-app-mosdns
# drop mosdns and v2ray-geodata packages that come with the source
find ../ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ../ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns mosdns
git clone https://github.com/sbwml/v2ray-geodata v2ray-geodata

# Add aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt aliyundrive
rm -rf ../feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf ../feeds/packages/multimedia/aliyundrive-webdav

# Add smartdns????????????
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git
# git clone https://github.com/pymumu/smartdns.git package/smartdns
# rm -rf ../feeds/packages/net/smartdns

# Add alist
rm -rf ../feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x ../feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/luci-app-alist

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

# Add luci-app-netdata
git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata
rm -rf ../feeds/luci/applications/luci-app-netdata
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git

# Add Theme
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-tomato
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-mcat
git clone --depth=1 https://github.com/sirpdboy/luci-theme-opentopd
# luci-theme-design theme
rm -rf ../feeds/luci/themes/luci-theme-design
git clone --depth=1 https://github.com/gngpp/luci-theme-design.git
# jerrykuku Argon theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../feeds/luci/themes/luci-theme-argon
sed -i '/letter-spacing: 1px/{N;s#text-transform: uppercase#text-transform: none#}' luci-theme-argon/htdocs/luci-static/argon/css/cascade.css
popd

# ?????? po2lmo (?????????po2lmo?????????)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# ??????????????????by ??????????????????
#sed -i '1i net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Change default shell to zsh
#sed -i 's#/bin/ash#/usr/bin/zsh#g' package/base-files/files/etc/passwd

# Modify localtime in Homepage
echo 'Modify localtime in Homepage...'
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm
# Modify hostname in Homepage
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

# ssrp duplicate nodes
sed -i 's#jsonStringify(result)#alias#g' $(find feeds/ -path '*shadowsocksr/subscribe.lua')
# luci-app-wrtbwmon 5s to 2s
sed -i 's#interval: 5#interval: 2#g' $(find feeds/ -name 'wrtbwmon.js')
sed -i 's# selected="selected"##' $(find feeds/ -name 'wrtbwmon.htm')
sed -i 's#"2"#& selected="selected"#' $(find feeds/ -name 'wrtbwmon.htm')

# ??????poweroff??????
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

pushd package/lean/default-settings/files
# ??????????????????
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' zzz-default-settings
# ???????????????????????????????????????
export date_version=$(date +'%Y.%m.%d')
sed -ri "s#(R[0-9].*[0-9])#\1 Build ${date_version} By @Cheng #g" zzz-default-settings
popd

# custom settings
mkdir -p files/etc/uci-defaults
cp $GITHUB_WORKSPACE/scripts/init-settings.sh files/etc/uci-defaults/99-init-settings
chmod a+x files/etc/uci-defaults/*
