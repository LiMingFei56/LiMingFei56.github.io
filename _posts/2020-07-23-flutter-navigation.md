---
layout: post
title: "Flutter 导航"
categories: flutter
tags: [navigator]
date: 2020-07-23
excerpt: "Flutter 导航"
---

## Flutter 导航

* MaterialApp.initialRoute 初始路线
* MaterialApp.routes 命名路线

* Navigator 页面间导航
* Route 就是页面
* MaterialPageRoute

### Navigator 方法

    Navigator.of(context).push /// 使用构造函数传参
    Navigator.of(context).pushAndRemoveUntil
    Navigator.of(context).pop

    Navigator.of(context).pushNamed
    arguments 可以传参数

    /// 提取arguments
    1. ModalRoute.of(context).settings.arguments
    2. MaterialApp.onGenerateRoute settings.arguments  然后传递给MaterialPageRoute.PassArgumentsScreen

    /// 获取返回值
    final result = await Navigator.push


### 监听回退按钮(包换Android Back按钮)

WillPopScope


### Reference
[Navigation and routing](https://flutter.dev/docs/development/ui/navigation)
[Navigation](https://flutter.dev/docs/cookbook/navigation)
[Learning Flutter’s new navigation and routing system](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade)
