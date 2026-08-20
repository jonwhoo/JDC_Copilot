#!/bin/bash
# 描述: 编译前引入第三方软件源 (Feeds)

# 强制进入 openwrt 目录（最关键）
cd openwrt || exit 1

FEEDS_FILE="feeds.conf.default"

# 先删除可能重复的源，避免重复添加导致冲突
sed -i '/openclash/d' $FEEDS_FILE
sed -i '/passwall_packages/d' $FEEDS_FILE
sed -i '/passwall$/d' $FEEDS_FILE
sed -i '/helloworld/d' $FEEDS_FILE

# 1. OpenClash（推荐 dev 分支）
echo "src-git openclash https://github.com/vernesong/OpenClash.git;dev" >> $FEEDS_FILE

# 2. PassWall 及其依赖包
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> $FEEDS_FILE
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> $FEEDS_FILE

# 3. SSR+ (helloworld)
echo "src-git helloworld https://github.com/fw876/helloworld.git;master" >> $FEEDS_FILE
