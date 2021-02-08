---
layout: post
title: "Android Audio & Video"
categories: android
tags: [android]
date: 2020-07-01
---

## Android Audio & Video

### MediaPlayer

#### issues

1. prepareAsync called in state 8  
    MediaPlayer.prepare()调用多次, 如果使用MediaPlayer.create工厂方法, 那么create  
    方法内已经调用prepare()方法

2. Error (1,-2147483648)
    前面一个1表示[MEDIA_ERROR_UNKNOWN](https://developer.android.google.cn//reference/android/media/MediaPlayer.html#MEDIA_ERROR_UNKNOWN), -2147483648对应十六进制0x80000000  
    定义`frameworks/native/include/utils/Errors.h`, 表示错误很难定位.  
    一般是因为视频格式不支持.



### Reference

[Audio & Video](https://developer.android.google.cn/guide/topics/media)
