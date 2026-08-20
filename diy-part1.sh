#!/bin/bash
# diy-part1.sh - feeds & patches for JDCloud Arthur LibWrt

# 追加第三方插件源（示例：openclash、passwall、ssr-plus）
# 注意：具体源地址按你习惯的仓库调整

FEEDS_FILE="feeds.conf.default"

# 确保在源码根目录执行
if [ ! -f "$FEEDS_FILE" ]; then
  echo "请在 openwrt 源码根目录运行 diy-part1.sh"
  exit 1
fi

# 添加常见第三方源
cat >> "$FEEDS_FILE" <<'EOF'
src-git helloworld https://github.com/fw876/helloworld
src-git passwall https://github.com/xiaorouji/openwrt-passwall
src-git openclash https://github.com/vernesong/OpenClash.git
EOF

# 如需额外补丁，可在此处添加：
# mkdir -p package/custom
# cp ../patches/*.patch package/custom/
