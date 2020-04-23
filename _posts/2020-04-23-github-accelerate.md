---
layout: post
title: "Github 加速"
categories: git
tags: [git]
date: 2020-04-23
excerpt: "Github 加速"
---

## Github 加速

### 1. 配置hosts
× 注：github服务器地址会变动

1. https://www.ipaddress.com/ip-lookup 查看`github.com`和
    `github.global.ssl.fastly.net`ip地址

2. 修改hosts文件

    windows: "C:\Windows\System32\drivers\etc\hosts"
    linux/macos: "/etc/hosts"

    140.82.114.3 github.com
    199.232.69.194 github.global.ssl.fastly.net

3. ipconfig /flushdns 刷新dns
