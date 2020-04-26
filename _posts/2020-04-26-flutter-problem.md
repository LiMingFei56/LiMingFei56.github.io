---
layout: post
title: "Flutter 遇到的问题200426"
categories: flutter
tags: [problem]
date: 2020-04-26
excerpt: "Flutter 遇到的问题200426"
---

## Flutter 遇到的问题200426

### 1. Failed to register bundle identifier. The app identifier "com.example.\*" cannot be registered to your development team because it is not available. Change your bundle identifier to aunique string to try again. (in target 'Runner' from project 'Runner')

> 应用ID不合法, 需要换一个有意义的Bundle Identifier

### 2. error: module importing failed: invalid pathname dyld: Library not loaded: @rpath/Flutter.framework/Flutter

> 使用个人签名运行在iOS13.3.1真机时出现

    1. 运行在13.3.1以下的系统的真机
    2. 换开发者证书
    3. 使用模拟器

### 3. Error: Building for iOS Simulator, but the linked and embedded framework 'App.framework' was built for iOS(or iOS Simulator)

> XCode升级造成这个错误, 原因是App.framework适用与真机设备, 不适用与模拟器.
> 需要删除App.framework后, 编译重新生成.
> 不管是模拟器切换成真机运行, 还是真机切换成模拟器运行, 都需要删除后重新生成.

    rm -rf ios/Flutter/App.framework/
    flutter run

### 4. \* iPhone has denied the launch request. Internal launch error: process launch failed: failed to get the task for precess \*

> 不能跟踪Debug

    1. xcode 中配置启动Scheme
    2. 取消Debug executable

### 5. device crashes on startup: code signature invalid for "path/to/Flutter.framework/Flutter"

> 同问题2, 在ios 13.4 beta3 修复

### 6. error: module importing failed: invalid pathname

> Xcode 11.4.1 Swift 5.2.2 时报错, 不管编译Flutter 还是 iOS, 甚至直接运行Swift, 
> 都会出现这个错误, 不清楚什么原因, 不影响使用.

