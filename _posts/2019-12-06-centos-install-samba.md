---
layout: post
title: "Centos 8 安装Samba"
categories: linux
tags: [centos, samba]
date: 2019-12-06
excerpt: "Centos 8 安装Samba"
---

## Centos8 安装Samba

查看centos版本

    rpm -q centos-release

安装Samba

    sudo yum install samba samba-client

开机启动

    sudo systemctl enable --now {smb,nmb}

### 1. 配置firewall

    sudo firewall-cmd --info-service samba
    sudo firewall-cmd --permanent --add-service=samba
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-services

### 2. 配置用户

    sudo adduser -M sambauser -s /sbin/nologin
    sudo smbpasswd -a sambauser

### 3. 配置samba

    见git config

### 4. 配置SELinux

    sudo chcon -R -t samba_share_t /mnt/shared
    sudo semanage fcontext -a -t samba_share_t "/mnt/shared(/.*)?"
    sudo semanage fcontext -l | grep /mnt/shared

    sudo semanage boolean -l|grep samba
    sudo setsebool samba_enable_home_dirs=1

### 5. 问题

### 6. 参考文献

    [How to install and configure samba on RHEL 8 / CentOS 8](https://linuxconfig.org/install-samba-on-redhat-8)
    [SAMBA 伺服器](http://linux.vbird.org/linux_server/0370samba.php#server_security)

