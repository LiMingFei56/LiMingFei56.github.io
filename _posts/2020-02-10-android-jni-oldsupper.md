---
layout: post
title: "android使用老库，32位库支持64位"
categories: android
tags: [jni]
date: 2020-02-10
excerpt: "android使用老库，32位库支持64位"
---

## android使用老库，32位库支持64位
如果第三方库蛮老（使用旧版本的NDK编译）， 那么在新系统上会报错

    java.lang.UnsatisfiedLinkError: dlopen failed: 
    "/data/app/com.teamsun.community.report-1/lib/arm64/libIDCardengine.so"
    is 32-bit instead of 64-bit

目前常用的ABI平台有`arm64-v8a`,`armeabi-v7a`,`armeabi`, 前面两个较新

    java.lang.UnsatisfiedLinkError: dlopen failed: 
    "/data/app/com.teamsun.community.report-1/lib/arm64/libIDCardengine.so"
    has text relocations

Android目标版本需要小于等于22

## 使当前应用支持老库

1. build.gradle 中 defaultConfig 下 
    ndk {
            abiFilters "armeabi"
    }
    ndk.abiFilters

这个是指定ndk编译的平台(默认会编译所有平台)

2. gradle.properties 中 添加
    android.useDeprecatedNdk=true

3. build.gradle 中 targetSdkVersion 指定为22

4. so库不能放错目录, 如armeabi 不能放到其他目录里
