---
layout: post
title: "Android 刷机"
categories: tools
tags: [tools]
date: 2022-01-11
---

## Android 刷机

### Mode

> bootloader: 按住音量减+电源, 当振一下松开电源
> recovery: 按住音量加+电源, 当振一下松开音量加

### Unlock

	adb reboot bootloader	
	fastboot oem unlock ****************
	fastboot oem get-bootinfo
	fastboot reboot

### 刷Recovery

	adb reboot bootloader
	fastboot flash recovery twrp.img
	fastboot reboot

### 刷boot

	adb reboot bootloader
	fastboot flash boot boot.img
	fastboot reboot

### 刷boot

	adb reboot bootloader
	fastboot flash system system.img
	fastboot reboot

### Root

	1. 把Magisk-\*.zip和SuperSU-\*.zip 复制到手机
	2. 进入第三方Recovery
	3. 安装Magisk-\*.zip
	4. 重启
	5. SuperSU-\*.zip
	6. 重启

### 问题
#### 总是进入Recovery

> 有些手机有自检, 如果不是本身程序(特别是Recovery), 那么就进入eRecovery
> 解决: 使用完第三方Recovery, 刷回原生Recovery

#### SuperSU SU Binary Occupied errors

> 安装2.79版本

#### /system/app/ Read-only file system

> mount -o rw,remount /system
> mount -o ro,remount /system

### Reference
[TWRP for Huawei Honor 7](https://twrp.me/huawei/huaweihonor7.html)  
[Download Huawei Stock ROM](https://androidmtk.com/download-huawei-stock-rom-for-all-models)  
[How to ROOT Huawei Honor 7i](https://huaweiflash.com/how-to-root-huawei-honor-7i/)  
