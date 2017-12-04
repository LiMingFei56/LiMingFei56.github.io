---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /ios/guide/main
---

## 程序入口

使用Xcode创建项目后，会自动创建AppDelegate.swift文件，这个文件主要做两件事：

	* 定义AppDelegate类。创建内容的绘制窗口(UIWindow)，并提供一个位置来响应应用
	  的状态转换。
	* 给应用创建一个入口(entry point)和一个设备输入事件的监听(run loop)。这个工
	  作是使用UIApplicationMain(@UIApplicationMain)来完成的。

使用UIApplicatonMain属性相当于调用UIApplicationMain函数，把AppDelegate类名作为
参数传递。

作为响应，系统会创建一个application对象。这个对象负责管理应用的生命周期。系统也
会创建一个AppDelegate对象，并赋值给application对象，最后系统会启动App.

### UIApplicationDelegate

AppDelegate遵循UIApplicationDelegate协议
