---
layout: post
title: "Linux 基本配置"
categories: linux
tags: [remote]
date: 2020-08-12
excerpt: "Linux 基本配置"
---

## Linux 基本配置

### 基本PATH

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH


### 添加sudo

```
    1. 切换root
    2. vim /etc/sudoers
```

### 自动登陆

1. xfce
```
    vim /etc/lightdm/lightdm.conf
    [SeatDefaults]
    autologin-user=username    #需要登录的用户名
    autologin-user-timeout=delay
```

### 无显示器, 实现运程控制

需要使用Xorg, 创建虚拟显示器
1. 安装 xserver-xorg-core
2. 安装 xserver-xorg-video-dummy

vim /usr/share/X11/xorg.conf.d/xorg.conf

    Section "Device"
        Identifier  "Configured Video Device"
        Driver      "dummy"
    EndSection

    Section "Monitor"
        Identifier  "Configured Monitor"
        HorizSync 31.5-48.5
        VertRefresh 50-70
    EndSection

    Section "Screen"
        Identifier  "Default Screen"
        Monitor     "Configured Monitor"
        Device      "Configured Video Device"
        DefaultDepth 24
        SubSection "Display"
        Depth 24
        Modes "1920x1080"
        EndSubSection
    EndSection

    

### Reference
[如何在没有图像用户界面 (GUI)的 Linux 系统上安装 TeamViewer](https://community.teamviewer.com/t5/TeamViewer-Knowledge-Base-ZH/%E5%A6%82%E4%BD%95%E5%9C%A8%E6%B2%A1%E6%9C%89%E5%9B%BE%E5%83%8F%E7%94%A8%E6%88%B7%E7%95%8C%E9%9D%A2-GUI-%E7%9A%84-Linux-%E7%B3%BB%E7%BB%9F%E4%B8%8A%E5%AE%89%E8%A3%85-TeamViewer/ta-p/33724#toc-hId--1331402631)  
[【LINUX】（Ubuntu）无显示器接入，使用虚拟显示器且远程控制](https://blog.csdn.net/qq_29757283/article/details/102604431)  
