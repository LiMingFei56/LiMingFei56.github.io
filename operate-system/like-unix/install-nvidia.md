---
layout: page
permalink: /operate-system/like-unix/install-nvidia
---

Install nvidia

### 1. 屏蔽开源NVIDIA显卡驱动

    vi /etc/modprobe.d/blacklist.conf 如果没有文件就新建
    blacklist nouveau

### 2. 安装Linux内核头文件

    aptitude -r install linux-headers-$(uname -r)

### 3. 安装Nvidia内核和驱动

    apt-get install nvidia-kernel-3.12-kali1-adm64
    aptitude install nvidia-kernel-dkms

### 4. 配置xserver-xorg

    aptitude install nvidia-xconfig

### 5. 检查驱动是否安装成功

    lsmod | grep nvidia
