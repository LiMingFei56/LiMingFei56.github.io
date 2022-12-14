---
layout: post
title: Linux 开机运行
categories: linux
tags: [linux]
date: 2022-12-14
---

## Linux 开机运行

### 1. crontab

    man 5 crontab

    其中有@reboot 每次开机执行一次

    grep CRON /var/log/syslog 查看crontab 日志
    因为crontab服务优先级很高, 有些操作过早执行 或者环境未设置前执行, 会执行失败


### 2. systemd

    [Unit]
    Description=trojan
    Documentation=https://trojan-gfw.github.io/trojan/config https://trojan-gfw.github.io/trojan/
    After=network.target network-online.target nss-lookup.target mysql.service mariadb.service mysqld.service

    [Service]
    ExecStartPost=/bin/sleep 30
    ExecStart=/some/command
    Type=oneshot
    RemainAfterExit=yes
    #Type=simple
    #StandardError=journal
    #ExecStart="/usr/local/bin/trojan" "/usr/local/etc/trojan/config.json"
    #ExecReload=/bin/kill -HUP $MAINPID
    #LimitNOFILE=51200
    #Restart=on-failure
    #RestartSec=1s

    [Install]
    WantedBy=multi-user.target

    
    设置systemd开机执行

    systemctl daemon-reload
    systemctl enable foo.service


## Reference

