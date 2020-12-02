---
layout: post
title: "Android TV"
categories: android
tags: [tv]
date: 2020-03-21
excerpt: "Android TV"
---

## Android TV

### 准备工作


### 适配Android 4.0 系统电视
Android TV 最低支持5.0 系统，但是5.0系统不能覆盖所有设备， 需要支持到4.0系统。
    app/build.gradle
    把minSdkVersion 改成16

    AndroidManifest.xml 设置覆盖库的配置， 解决库的最低版本支持
    <uses-sdk tools:overrideLibrary="androidx.tvprovider,androidx.leanback,androidx.leanback.preference"/>
    MainActivity 添加启动Intent过滤器
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />

        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>

    使用ResourcesCompat, ContextCompat API 取代5.0及以后的Api

Activity 替换成 import androidx.fragment.app.FragmentActivity
Fragment 替换成 androidx.fragment.app.Fragment 
\*Fragment 替换成 import androidx.leanback.app.\*SupportFragment 如 ErrorFragment 替换成 ErrorSupportFragment
BrowseSupportFragment headersState = HEADERS_DISABLED


### Reference
[Android TV 概览](https://developer.android.google.cn/training/tv)
