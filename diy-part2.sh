#!/bin/bash
# diy-part2.sh - system tweaks & LuCI config for JDCloud Arthur

# 确保在源码根目录执行
if [ ! -f ".config" ]; then
  echo "未找到 .config，请先拷贝 configs/arthur.config 到 openwrt/.config"
  exit 1
fi

# 强制启用关键 LuCI 插件（防止被 defconfig 覆盖）
# openclash
sed -i '/CONFIG_PACKAGE_luci-app-openclash/d' .config
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config

# passwall（含 SingBox、Xray）
sed -i '/CONFIG_PACKAGE_luci-app-passwall/d' .config
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y" >> .config

# ssr-plus（含 Mihomo、ChinaDNS_NG、SSR Libev）
sed -i '/CONFIG_PACKAGE_luci-app-ssr-plus/d' .config
echo "CONFIG_PACKAGE_luci-app-ssr-plus=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Mihomo=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ChinaDNS_NG=y" >> .config
echo "CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y" >> .config

# 你提供的 config 里已经有这些项：
# CONFIG_PACKAGE_luci-app-openclash=y
# CONFIG_PACKAGE_luci-app-ssr-plus=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_Mihomo=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ChinaDNS_NG=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_ShadowsocksR_Libev_Client=y
# CONFIG_PACKAGE_luci-app-passwall=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y

# 可以在这里做一些默认设置微调，例如：
# 修改默认 LAN IP
# sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 关闭不需要的服务（示例）
# sed -i 's/ttyS0/ttyS1/g' package/base-files/files/etc/inittab
