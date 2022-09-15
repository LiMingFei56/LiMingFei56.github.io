---
layout: post
title: macOS 问题
categories: macos
tags: [macos]
date: 2022-09-15
---

## macOS 问题

### 应用图标不显示
[Apps Icons not appearing](https://apple.stackexchange.com/questions/280877/apps-icons-not-appearing)  

    sudo find /private/var/folders/ -name com.apple.dock.iconcache -exec rm {} \;
    sudo find /private/var/folders/ -name com.apple.iconservices -exec rm -rf {} \;
    sudo rm -rf /Library/Caches/com.apple.iconservices.store
    killall Dock

## Reference

