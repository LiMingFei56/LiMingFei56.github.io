---
layout: post
title: "Raspberry pi 安装 Kali Linux"
categories: linux
tags: [linux]
date: 2019-11-19
excerpt: "Raspberry pi 安装 Kali Linux"
summary: Raspberry pi 安装 Kali Linux
---

## Raspberry pi 安装 Kali Linux

## 1. 准备

* Respberry pi 3/b+
* SDcard 32G
* usb 键盘/鼠标
* 读卡器

## 2. 烧录

### Unix

	使用shasum校验文件正确性
	dd if=kali-2.1.2-rpi.img of=/dev/sdb bs=512k
	
### Windows

	certutil -hashfile yourfilename.ext SHA1
	使用win32diskmanager写入sdcard
	UltraISO 写入硬盘  一般选择USB-HDD+ 不能启动时换RWA

## 3. 换源

  /etc/apt/sources.list

## 4. 安装raspi-config

  wget http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20200226_all.deb
  dpkg -i raspi-config_20200226_all.deb
  apt --fix-broken install

## 5.安装中文输入法

  apt install fcitx fcitx-table-wubi fonts-wqy-zenhei

## 6. 扩展分区
烧录后分区只站了sdcard一部分, 所以需要扩展分区.
	
	1. macOS使用Gparted工具扩展
  2. 使用raspi-config


## 7. 开启ssh
Kali是debian的分支, 所以也采用Systemd

	systemctl start ssh
	systemctl enable ssh

## 8. 开机自动进入图形界面

	vim /etc/lightdm/lightdm.conf

	#autologin-user=
	#autologin-user-timeout=0

	改成

	autologin-user=root
	autologin-user-timeout=0

	vim /etc/pam.d/lightdm-autologin
	注释 auth required pam_succeed_if.so user != root quiet_success

## 9. 配置无线
networkctl list 查看网络设备
systemctl start systemd-networkd 开启网络管理服务


### Reference
[HOW-TO:Install Kodi on Raspberry Pi](https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi)  
