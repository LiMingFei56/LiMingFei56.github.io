---
layout: post
title: Linux install package By iso
categories: linux
tags: [linux]
date: 2023-04-19
---

## Linux install package By iso

    [media]
    name=Redflag x86_64 Linux 7 - media
    baseurl=file://mnt
    enabled=1
    gpgcheck=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redflag-7-x86_64


    yum install --disablerepo=\* --enablerepo=media -y install <rpm>

## Reference
