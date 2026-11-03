#!/bin/bash

# 写入 uci-defaults，开机自动配置源、时区、DNS
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-init-setup <<'EOF'
#!/bin/sh

cat > /etc/opkg/distfeeds.conf <<CONF
src/gz openwrt_core https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/targets/bcm53xx/generic/packages
src/gz openwrt_base https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/packages/arm_cortex-a9/base
src/gz openwrt_luci https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/packages/arm_cortex-a9/luci
src/gz openwrt_packages https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/packages/arm_cortex-a9/packages
src/gz openwrt_routing https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/packages/arm_cortex-a9/routing
src/gz openwrt_telephony https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/22.03.5/packages/arm_cortex-a9/telephony
src/gz kiddin9 https://opkg.ai/kiddin9/22.03
CONF

uci set system.@system[0].timezone='CST-8'
uci set system.@system[0].zonename='Asia/Shanghai'
uci commit system

uci set dhcp.lan.dhcp_option='6,223.5.5.5,223.6.6.6'
uci commit dhcp
/etc/init.d/dnsmasq restart

opkg update

rm -f /etc/uci-defaults/99-init-setup
exit 0
EOF

chmod +x files/etc/uci-defaults/99-init-setup

# 修改默认登录 IP（可选，不改就是默认 192.168.1.1）
# sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
