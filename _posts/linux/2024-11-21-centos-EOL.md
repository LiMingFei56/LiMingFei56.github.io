---
layout: post
title: CentOS EOL
categories: linux
tags: [linux]
date: 2024-11-21
---

## CentOS EOL

    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    sudo curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo


    sudo yum install iperf3

## Reference
