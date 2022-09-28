---
layout: post
title: ubuntu 14.04
categories: linux
tags: [linux]
date: 2022-09-26
---

## ubuntu 14.04
    // 解决没有system setting
    sudo apt install ubuntu-desktop
    // 解决依赖
    sudo apt-get autoremove libcheese-gtk23 libcheese7
    sudo apt install xserver-xorg-core xserver-xorg-video-dummy -y
    sudo apt-get install --install-recommends linux-generic-lts-wily xserver-xorg-core-lts-wily xserver-xorg-lts-wily xserver-xorg-video-all-lts-wily xserver-xorg-input-all-lts-wily libwayland-egl1-mesa-lts-wily


## Reference
