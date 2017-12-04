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
ViewController继承UIViewController

### Storyboard
是应用程序的直观表示，显示内容的屏幕以及它们之间的转换。可以使用storyboard来驱
动应用的流程或者故事，可以在构建过程中准确的了解构建的结果，并即时的修改用户界面
。storyboard背后是一个canvas。

storyboard打开后显示一个scene，这个scene代表用户看到的内容。scene左边一个箭头显示
storyboard entry point，代表应用启动时进入。这个scene还包含一个简单的view controller。

开发的时候可以调用屏幕的方向显示，方便屏幕适配。

Xcode提供一个库对象，可以添加到storyboard中。这些元素可以添加到用户界面中，如一个
button和textview。还可以添加view controller和gesture recognizers,定义这些行为。

用户界面元素都是View，View是用来组合一个用户界面的基石。所有的View对象都是IOS中
的UIView或者它的子类.

在应用中所以可以被用户看见的文字都要[国际化](https://developer.apple.com/internationalization/).

### Auto Layout
使用Auto Layout来适配不同的屏幕。AutoLayout是一个强大的布局引擎，会根据定义的constraints
对于不同的屏幕计算位置和大小。

如果显示的效果没有达到预期，可以使用AutoLayoutDebug功能。可以使用Update Frames button
和Resolve Auto Layout Issues menu.

Update Frames 可以更新选中的View。
Resolve Auto Layout Issues menu 可以作用选中的View或者整个ViewController
可以刷新Constraints，还可以删除所有Constraints.
