#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Uncomment a feed source and Add a feed source
#echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall.git;packages' >>feeds.conf.default
#echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;luci' >>feeds.conf.default

mkdir package/openwrt-package
pushd package/openwrt-package
git clone --depth=1 https://github.com/fw876/helloworld.git
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
git clone --depth=1 -b luci https://github.com/xiaorouji/openwrt-passwall luci-app-passwall
# Add luci-app-openclash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Add luci-app-autotimeset
#git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset.git
# Add luci-app-advanced
#svn export https://github.com/sirpboy/sirpdboy-package/trunk/luci-app-advanced
#rm -rf luci-app-advanced/luasrc/controller/filebrowser.lua
#rm -rf luci-app-advanced/luasrc/view

# Add luci-app-unblockneteasemusic
git clone --depth=1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
rm -rf ../../feeds/luci/applications/luci-app-unblockmusic

# Add aliyundrive-fuse
svn export https://github.com/messense/aliyundrive-fuse/trunk/openwrt
rm -rf ../../feeds/luci/applications/luci-app-aliyundrive-fuse
rm -rf ../../feeds/packages/multimedia/aliyundrive-fuse
# Add aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt
rm -rf ../../feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf ../../feeds/packages/multimedia/aliyundrive-webdav

# Add gowebdav
#git clone --depth=1 https://github.com/immortalwrt/openwrt-gowebdav.git
svn export https://github.com/kenzok8/jell/trunk/luci-app-gowebdav
svn export https://github.com/kenzok8/jell/trunk/gowebdav

# Add luci-app-v2ray-server
#svn export https://github.com/kenzok8/jell/trunk/luci-app-v2ray-server
#rm -rf ../../feeds/luci/applications/luci-app-v2ray-server

# Add luci-app-shortcutmenu
svn export https://github.com/kenzok8/jell/trunk/luci-app-shortcutmenu

# Add luci-app-eqos
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos

# Add luci-app-sqm
#git clone --depth=1 https://github.com/loryncien/luci-app-sqm.git
##svn export https://github.com/siropboy/sirpdboy-package/trunk/luci-app-sqm
# Add sqm-scripts
#svn export https://github.com/openwrt/packages/trunk/net/sqm-scripts
#svn export https://github.com/openwrt/packages/trunk/net/sqm-scripts-extra

# Add luci-app-speedlimit
git clone --depth=1 https://github.com/loryncien/luci-app-speedlimit.git

# Add luci-app-netdata
#git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata
#svn export https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata
#rm -rf ../../feeds/luci/applications/luci-app-netdata

## Lienol https://github.com/Lienol/openwrt-package
git clone --depth=1 https://github.com/immortalwrt/openwrt-filebrowser.git
#svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-fileassistant
#svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl
svn export https://github.com/Beginner-Go/my-packages/trunk/luci-app-control-weburl
#svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction
svn export https://github.com/Beginner-Go/my-packages/trunk/luci-app-control-webrestriction
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-socat
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-pppoe-server

# Add luci-app-poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff.git

# Add luci-app-dockerman
#git clone --depth=1 https://github.com/lisaac/luci-app-dockerman.git
#git clone --depth=1 https://github.com/lisaac/luci-lib-docker.git

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan.git

# Add luci-app-ddnsto
svn export https://github.com/linkease/nas-packages/trunk/network/services/ddnsto
svn export https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto

# Add luci-app-bearDropper
git clone --depth=1 https://github.com/NateLol/luci-app-bearDropper
mv luci-app-bearDropper/po/zh_Hans luci-app-bearDropper/po/zh-cn

# Add luci-app-bandwidthd
git clone https://github.com/AlexZhuo/luci-app-bandwidthd.git

# Add luci-app-omcproxy
git clone --depth=1 -b 18.06 https://github.com/riverscn/luci-app-omcproxy.git

########### 安装smartdns（必选）###########
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git
#git clone https://github.com/pymumu/smartdns.git package/smartdns

# Add Theme
#git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git
#find -name '10_luci-theme-infinityfreedom' | xargs rm
git clone --depth=1 https://github.com/kenzok8/luci-theme-ifit.git
find -name '10_luci-theme-ifit' | xargs rm
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-tomato
svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-mcat
git clone --depth=1 https://github.com/sirpdboy/luci-theme-opentopd
git clone --depth=1 https://github.com/esirplayground/luci-theme-atmaterial-ColorIcon.git
git clone --depth=1 https://github.com/thinktip/luci-theme-neobird.git
# jerrykuku Argon theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../../feeds/luci/themes/luci-theme-argon
popd

