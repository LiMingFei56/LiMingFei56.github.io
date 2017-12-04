---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /ios/guide/main
---

程序入口

使用Xcode创建项目后，会自动创建AppDelegate.swift文件，这个文件主要做两件事：

	* 定义AppDelegate类。创建内容的绘制窗口(UIWindow)，并提供一个位置来响应应用
	  的状态转换。
	* 给应用创建一个入口(entry point)和一个设备输入事件的监听(run loop)。这个工
	  作是使用UIApplicationMain(@UIApplicationMain)来完成的。

使用UIApplicatonMain属性相当于调用UIApplicationMain函数，把AppDelegate类名作为
参数传递。

作为响应，系统会创建一个application对象。这个对象负责管理应用的生命周期。系统也
会创建一个AppDelegate对象，并赋值给application对象，最后系统会启动App.

### AppDelegate

AppDelegate遵循UIApplicationDelegate协议,该协议定义了多个方法来设备应用。

	1. 响应应用的状态改变
	2. 处理其他的应用级事件

AppDelegate包含一个window属性，是UIWindows类型。这个window代表root view，是应用
所有内容被绘制的地方。它是一个optional，证明有可以为空。

AppDelegate实现了多个方法，这些方法用于代理和应用间的通信，我们不用管这个方法在
什么时候调用，IOS平台会自己管理这些方法的调用。方法上默认提供注释，说明什么时候
会调用这些方法。

### The View Controller Source File

