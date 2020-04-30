---
layout: post
title: "WSL install Desktop"
categories: linux
tags: [wsl]
date: 2020-04-29
excerpt: "WSL install Desktop"
---

## WSL install Desktop

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

