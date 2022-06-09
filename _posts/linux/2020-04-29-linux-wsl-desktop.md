---
layout: post
title: "Linux WSL"
categories: linux
tags: [linux]
date: 2020-04-29
---

## Linux WSL

### 1. 使用xrdp

[Run Kali Linux on Windows 10](https://tweaks.com/windows/67261/run-kali-linux-on-windows-10/)

#### 1. 
    
    wget https://kali.sh/xfce4.sh
    chmod -x xfce4.sh
    sudo ./xfce4.sh
    sudo /etc/init.d/xrdp start

    #!/bin/bash
    echo "[+] Installing XFCE4, this will take a while"
    apt-get update
    apt-get dist-upgrade -y --force-yes
    apt-get --yes --force-yes install kali-desktop-xfce xorg xrdp
    echo "[+] Configuring XRDP to listen to port 3390 (but not starting the service)..."
    sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini



### 2. 使用VcXsrv

#### 1. 安装软件

    1. Microsoft Store 安装linux 子系统
    2. [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
    3. [PulseAudio on Windows](https://www.freedesktop.org/wiki/Software/PulseAudio/Ports/Windows/Support/)

#### 2. Linux 安装 Xfce

    sudo apt install xfce4 xfce4-terminal

    or 

    sudo apt install xubuntu-destop

    systemctl enable dbus

#### 3. 配置PulseAudio on Windows

1. unzip
    
2. etc/pulse/default.pa

    load-module module-waveout sink-name=output source_name=input `record=0`
    open load-module module-native-protocol-tcp `auth-ip-acl=127.0.0.1`

3. etc/pulse/deamon.conf

    exit-idle-time = -1

#### 4. XLaunch

    1. One Lage window
    2. Start no client
    3. additional -screen 0 1920x1080@1

#### 5. startx bat

    start /B config.xlaunch
    start "" /B "C:\bin\pulseaudio-1.1\bin\pulseaudio.exe"
    ubuntu.exe run "if [ -z \"$pidof xfce4-session\"" ]; then export DISPLAY=127.0.0.1:0.0; export PULSE_SERVER=tcp:127.0.0.1; xfce4-session; pkill '(gpg|ssh)-agent'; taskkill.exe /IM pulseaudio.exe /F; taskkill.exe /IM vcxsrc.exe; fi;"

### 3. 安装WSL 2

> 安装WSL 2需要 2004 系统版本, 所以先需要在`下载 Windows 10 光盘映像`工具, 升级
> 到 2004.

> WSL 是使用SysInit


### Reference
[How to upgrade to Windows 10 version 2004, May 2020 Update](https://pureinfotech.com/upgrade-windows-10-2004/)
[下载 Windows 10 光盘映像（ISO 文件)](https://www.microsoft.com/zh-cn/software-download/windows10ISO)
[关于 WSL 2](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-about?view=sql-server-ver15)
[WSL 2 的安装说明](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-install)
[更新 WSL 2 Linux 内核](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-kernel)
