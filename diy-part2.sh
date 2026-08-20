#!/bin/bash
# diy-part2.sh - system tweaks & LuCI config for JDCloud Arthur

# 确保在源码根目录执行
if [ ! -f ".config" ]; then
  echo "未找到 .config，请先拷贝 configs/arthur.config 到 openwrt/.config"
  exit 1
fi

# ================================
# 1. 强制设置目标设备（京东云亚瑟）
# ================================
sed -i '/CONFIG_TARGET_ipq50xx/d' .config
sed -i '/jdcloud_re-ss-01/d' .config

cat >> .config <<EOF
CONFIG_TARGET_ipq50xx=y
CONFIG_TARGET_ipq50xx_generic=y
CONFIG_TARGET_ipq50xx_generic_DEVICE_jdcloud_re-ss-01=y
EOF

# ================================
# 2. 强制启用三套代理插件
# ================================

# ---- OpenClash ----
sed -i '/luci-app-openclash/d' .config
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_coreutils-nohup=y
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_ipset=y
CONFIG_PACKAGE_iptables-mod-tproxy=y
CONFIG_PACKAGE_kmod-tun=y
EOF

# ---- Passwall ----
sed -i '/luci-app-passwall/d' .config
sed -i '/passwall_INCLUDE/d' .config
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
CONFIG_PACKAGE_sing-box=y
CONFIG_PACKAGE_xray-core=y
CONFIG_PACKAGE_tcping=y
EOF

# ---- SSR+ ----
sed -i '/luci-app-ssr-plus/d' .config
sed -i '/ssr-plus_INCLUDE/d' .config
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Mihomo=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ChinaDNS_NG=y
CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y
CONFIG_PACKAGE_mihomo=y
CONFIG_PACKAGE_chinadns-ng=y
CONFIG_PACKAGE_shadowsocksr-libev=y
CONFIG_PACKAGE_dns2socks=y
CONFIG_PACKAGE_ipt2socks=y
EOF

# ================================
# 3. NSS 加速（TurboACC 必备）
# ================================
sed -i '/kmod-qca-nss/d' .config
cat >> .config <<EOF
CONFIG_PACKAGE_kmod-qca-nss-ecm=y
CONFIG_PACKAGE_kmod-qca-nss-dp=y
CONFIG_PACKAGE_kmod-qca-nss-gmac=y
CONFIG_PACKAGE_kmod-qca-nss-crypto=y
EOF

# ================================
# 4. 可选系统微调（按需开启）
# ================================

# 修改默认 LAN IP（示例）
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 关闭不需要的服务（示例）
# sed -i 's/ttyS0/ttyS1/g' package/base-files/files/etc/inittab

echo "diy-part2.sh 已完成配置补全与修复。"
