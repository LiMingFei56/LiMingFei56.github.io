---
layout: post
title: Android IPC
categories: android
tags: [android]
date: 2022-09-13
---

## Android IPC

1. Binder
2. AIDL
3. Messager
4. FILE
5. bundle
6. socket
7. Pipe

### Binder

* Messager 是依赖AIDL, AIDL依赖Binder
* 使用`/dev/binder`, Android中的虚拟设备
* 一个进程只打开设备一次

## Reference
[深入理解Android：Binder](https://wongzhenyu.cn/2019/08/27/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3Android%EF%BC%9ABinder/)  
