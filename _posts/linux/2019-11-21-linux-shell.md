---
layout: post
title: "Linux kali 脚本报告报 -- [: 11: y: unexpected operator"
categories: linux
tags: [linux]
date: 2019-11-21
---

## Linux kali 脚本报告报 -- [: 11: y: unexpected operator

debian系的发行版本默认使用dash, 跟bash是不兼容的, 所以导致报错

使用bash ***\*.sh 来执行, 如果正常就是dash的原因

使用`sudo dpkg-reconfigure dash` 选择no, 设置成bash


### Reference



