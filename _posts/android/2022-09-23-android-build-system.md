---
layout: post
title: Android Build System
categories: aosp
tags: [aosp]
date: 2022-09-23
---

## Android Build System

### OTA update

> over-the-air update, 不需要网络更新

### lunch

> `aosp_arm-eng` 或者 `aosp_arm64-eng` 创建的img适合模拟器, 不能在真实设备上工作.
> andorid 系统编译如果没有指定硬件, 那么不会生成依赖硬盘的`boot.img`和`recovery.img`.
> 


## Reference
[Android Build System](https://elinux.org/Android_Build_System#:~:text=Use%20the%20%27mm%27%20or%20%27,from%20the%20top%20of%20tree.)  
[AOSP build instructions](https://developer.sony.com/develop/open-devices/guides/aosp-build-instructions)  
[Android Building](https://groups.google.com/g/android-building)  

[Establishing a Build Environment](https://source.android.com/docs/setup/start/initializing)  
[Building Android](https://source.android.com/docs/setup/build/building)  

[Android FileHost](https://androidfilehost.com/)  
[TeamWin - TWRP](https://twrp.me/)  
