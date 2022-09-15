---
layout: post title: "macOS arm 安装kali linux"
categories: linux
tags: [linux]
date: 2022-03-21
---

## macOS arm 安装kali linux

### libwacom9 : 依赖: libwacom-common (= 2.1.0-2) 但是 1.12-1 正要被安装

sudo apt install libwacom9 libwacom2-

### Clipboard Sharing And Shared Directory

sudo apt install spice-vdagent spice-webdavd

### 安装mysql 在 kali arm64

	libicu67_67.1-7_arm64.deb
	mysql-server-core-8.0_8.0.23-3+b1_arm64.deb
	mysql-server-8.0_8.0.23-3+b1_arm64.deb
	mysql-client-core-8.0_8.0.23-3+b1_arm64.deb
	mysql-client-8.0_8.0.23-3+b1_arm64.deb
	mysql-apt-config_0.8.22-1_all.deb
	mecab-ipadic-utf8_2.7.0-20070801+main-3_all.deb

mysql-apt-config: 是x86的, 其他是arm的  从[debian](https://www.debian.org/distrib/packages)中下载的包

1. 安装包
	sudo apt install ./libicu67_67.1-7_arm64.deb ./mecab-ipadic-utf8_2.7.0-20070801+main-3_all.deb ./mysql-client-core-8.0_8.0.23-3+b1_arm64.deb ./mysql-server-core-8.0_8.0.23-3+b1_arm64.deb ./mysql-client-8.0_8.0.23-3+b1_arm64.deb ./mysql-server-8.0_8.0.23-3+b1_arm64.deb

2. 配置启动用户和datadir

	sudo vim /etc/mysql/my.cnf
	添加"user=mysql"
	sudo chown mysql:mysql -R /var/lib/mysql
	sudo chmod 740 -R /var/lib/mysql
	sudo mkdir /var/lib/mysql-files
	sudo chown mysql:mysql -R /var/lib/mysql-files
	sudo chmod 740 -R /var/lib/mysql-files
	sudo mkdir /var/run/mysqld
	sudo chown mysql:mysql -R /var/run/mysqld
	sudo chmod 740 -R /var/run/mysqld

	# 如果有问题可以重新初始化mysqld, Failed to initialize DD Storage Engine.
	mysqld -remove MySQL
	sudo mysqld --initialize-insecure

### Install oh-my-zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	

### Reference
[UTM](https://getutm.app/guide/)  
[Guide](https://mac.getutm.app/guide/)  
[UTM - Sharing a Folder with a Linux Guest](https://support.cci.drexel.edu/software-courses/utm-virtualization-m1-macs/utm-sharing-folder-linux-guest/)  
[Install Kali Linux on Apple M1 with UTM \[100% Working\]](https://www.golinuxcloud.com/install-kali-linux-on-apple-m1-with-utm/)  
[How to Setup SQLi Penetration Testing Lab on Kali Linux](https://www.kalilinux.in/2021/09/how-to-setup-sql-injection-labs-kali-linux.html)  
