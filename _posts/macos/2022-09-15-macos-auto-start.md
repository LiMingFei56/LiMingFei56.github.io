---
layout: post
title: macOS 自动开机
categories: macos
tags: [macos]
date: 2022-09-15
---

## macOS 自动开机

### 开盖自动开机

    // disable
    sudo nvram AutoBoot=%00

    // enable
    sudo nvram AutoBoot=%03

### 启动铃声

    // enable
    sudo nvram BootAudio=%01

    // disable
    sudo nvram BootAudio=%00


## Reference    
[How to stop the new MacBook Pro from automatically turning on when the lid is open](https://www.idownloadblog.com/2016/10/31/how-to-stop-the-new-macbook-pro-from-automatically-turning-on-when-the-lid-is-open/#:~:text=To%20disable%20the%20startup%20tone,you%20un%2Dmute%20the%20volume.)  
