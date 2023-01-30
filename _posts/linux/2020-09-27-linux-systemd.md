---
layout: post
title: "Linux Systemd"
categories: linux
tags: [linux]
date: 2020-09-27
---

## Linux Systemd

### linux status

    Run Lvl Target Units                        Description
    0       runlevel0.target, poweroff.target   Shut down and power off
    1       runlevel1.target, rescue.target     Set up a rescue shell
    2,3,4   runlevel[234].target,               Set up a non-gfx multi-user shell
            multi-user.target
    5       runlevel5.target, graphical.target  Set up a gfx multi-user shell
    6       runlevel6.target, reboot.target     Shut down and reboot the system

### Reference
[systemd](https://systemd.io/)  
