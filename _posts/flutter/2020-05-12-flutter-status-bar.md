---
layout: post
title: "FLutter 状态栏"
categories: flutter
tags: [flutter]
date: 2020-05-12
---

## FLutter 状态栏

### Flutter 状态栏高度

> Android, iOS(无刘海), iOS(有刘海)的状态栏高度都不一样, 不能写死

    // 获取状态栏高度
    MediaQueryData.fromWindow(window).padding.top;
    // 系统默认的appBar参数
    Dart Packages/flutter/src/material/constans.dart

### Flutter 沉浸式状态栏

> 设置沉浸式状态需要把状态栏的背影设置成透明的, iOS状态栏一直是透明的, 所以需要
> 设置[Android状态栏](https://www.jianshu.com/p/fc5854895a10).

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

> 状态栏设置为透明后, View默认y轴从0开始. 

### Flutter 安全区域

> 为了阻止App内容跑到状态栏上, App需要注意安全区域.

Android:

    // 设置activity.contentView的子View
    ViewGroup parent = (ViewGroup) activity.findViewById(android.R.id.content);
        for (int i = 0, count = parent.getChildCount(); i < count; i++) {
            View childView = parent.getChildAt(i);
            if (childView instanceof ViewGroup) {
                childView.setFitsSystemWindows(true);
                ((ViewGroup) childView).setClipToPadding(true);
            }
    }

> 通过`setFitsSystemWindows(true)`和`setClipToPadding(true)`留出安全区域

iOS:
> 9.0前使用`Top Layout Guide`和`Bottom Layout Guide`, 9.0使用`SafeArea`

Flutter: 使用SafeArea控件
