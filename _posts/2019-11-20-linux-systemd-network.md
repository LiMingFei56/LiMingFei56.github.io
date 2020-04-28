---
layout: post
title: "systemd-networkd"
categories: linux
tags: [systemd]
date: 2019-11-20
excerpt: "systemd-networkd 工作方法"
---

# systemd-networkd
systemd 使用 `systemd-networkd` 提供的网络管理服务, 可以完全管理以太网. 对于
无线网卡, wifi需要wpa_supplicant@.service, PPP需要ppp@.service

配置文件
	
	/etc/systemd/network
	/usr/lib/systemd/network

主要用来配置IP, 虚拟网络, 


## NetworkManager
有些linux系统安装完成后, eth0设备就可以使用, 但是使用`networkctl list`会发现,
systemd-networkd服务没有启动.

使用`pstree -Apn` 会发现NetworkManager这个服务正在运行.

NetworkManager目前比systemd-networkd有更强的功能, 所以有些linux发行版本仍然采
用NetworkManager为网络管理服务. 但是没有systemd-networkd与systemd其他网络部分
的紧密结合

systemd-resolved /run/systemd/resolv.conf /etc/resolv.conf 域名解析
systemd-timesyncd NTP时间服务
systemd-udevd 设备管理

NetworkManager是一个支持GUI配置网络的程序, 对PC和笔记本等桌面系统很有用.


### NetworkManager 切换成systemd-networkd
要用systemd就直接用一套, 避免学习多个网络管理程序

配置文件`Name`需要使用udev分配给网络适配器的名称

	/etc/systemd/network/20-wired.network
	----------
	[Match]
	Name=enp1s0

	[Network]
	DHCP=ipv4

	[DHCP]
	RouteMetric=10
	
	**********************

	/etc/systemd/network/25-wireless.network
	------------
	[Match]
	Name=wlp2s0

	[Network]
	DHCP=ipv4

	[DHCP]
	RouteMetric=20

	************************
	systemctl disable NetworkManager
	systemctl enable systemd-networkd
	systemctl enable systemd-resolved
	systemctl stop NetworkManager
	systemctl start systemd-networkd
	systemctl start systemd-resolved
	ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf 
		(systemd-resolved开启后会生成/run/systemd/resolve/resolv.conf文件)


### systemd-networkd配置
systemd的`systemd-modules-load.service`负责在系统启动时静态加载内核模块, 它会
从以下路径搜索可用的配置文件:

	/etc/modules-load.d/*.conf
	/run/modules-load.d/*.conf
	/usr/lib/modules-load.d/*.conf

配置文件的内容就是一个内核模块名称的列表，可以用井号 # 或者分号 ; 注释单个模块。

sytemd-network.service 的配置文件可以位于****/usr/lib/systemd/network/* 
或者 */etc/systemd/network/* 目录下，后者具有最高优先级。配置文件有三种类型：

	* .network 文件，设置网卡的 IP 等各项属性
	* .netdev 文件，新建一个虚拟网卡
	* .link 文件，每当一个网卡出现时，udev 都会查找与它同名的 .link 文件

这几类文件都遵循下面的规则：
	
	* 各选项的值都支持星号 * 通配符
	* 当 [Match] 段内的条件都匹配时，后面的配置项才会被激活
	* 如果 [Match] 段为空，表示后面的配置项在任何情况下都可用
	* 无论配置文件在哪个目录，都会统一安装字典顺序进行加载
	* 同名文件可以相互替换

## Wifi配置
systemctl start wpa_supplicant 开启wpa_supplicant
wpa_cli 来管理wifi

/lib/systemd/system/wpa_supplicant提供多种服务的文件：

	* wpa_supplicant.service - 使用 D-Bus, 推荐 NetworkManager 的用户.
	* wpa_supplicant@.service - 接受接口名作为参数，并为该接口启动wpa_supplicant守护进程。它读取/etc/wpa_supplicant/wpa_supplicant-interface.conf的配置文件
	* wpa_supplicant-nl80211@.service -  也是接口特定的,但明确强制nl80211驱动程序 (见下文). 配置文件路径是/etc/wpa_supplicant/wpa_supplicant-nl80211-interface.conf
	* wpa_supplicant-wired@.service - 也是接口特定的, 使用 wired 驱动. 配置文件路径是/etc/wpa_supplicant/wpa_supplicant-wired-interface.conf
	
### 配置wpa_supplicant

	vim /lib/systemd/system/wpa_supplicant.service
	------
	#ExecStart=/sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
	ExecStart=/sbin/wpa_supplicant -u -s -i [interface] -c /etc/wpa_supplicant/wpa_supplicant.conf

### 连接wifi
如果不指定interface的话, wpa_cli会使用查找的第一个适配器, 这不一定是你想要的

	wpa_cli -i [interface]
	scan
	scan_result
	add_network
	0 // 返回network标号, 用来设置属性
	set_network 0 ssid "MYSSID"
	set_network 0 psk "passphrase"
	enable_network 0
	save_config

# 参考文献
[archlinux systemd-networkd](https://wiki.archlinux.org/index.php/Systemd-networkd)
[archlinux WPA supplicant](https://wiki.archlinux.org/index.php/WPA_supplicant)
