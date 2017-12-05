---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /ios/guide/basic/view
---

User Interface

### StoryBoard与代码的关系
在StoryBoard中，一个Scene代表一个内容屏幕，通常是一个ViewController.ViewController
实现应用的行为，管理具有子View层次结构的内容View.ViewController协调数据模型与视图
间的信息流，管理内容View的生命周期，处理设备旋转时的方向更改，定义应用的导航，实现
用户输入的行为。所有的ViewController都是UIViewController的子类。

虽然StoryBoar与ViewController通过Idenity Inspector建立了连接，但还需要建立出口和行为
连接。

#### Outlet
outlet提供方法引用视图对象

@IBOutlet weak var nameTextField: UITextField!

	* @IBOutlet 在Interface Builder中创建对象连接。
	* weak表示弱引用

如果要保存对象存活在内存中，那么需要一个强引用在当前对象中，一般是SuperView，如果
SuperView存活在内存中，那么所有子View都存活在内存中，而且ViewController有内容View
的强引用。

当Storyboard加载一个ViewController后，系统会实例化View层次结构，并且给所有的Outlet
赋值。当这些完成时就调用viewDidLoad()方法。

### Action
IOS应用是基于事件驱动平台，也就是说应用流程是由事件决定的（系统事件和用户事件）。
Action是链接到应用可能被触放的事件的代码。

### First Responder
当用户点击一个TextField,那么这个TextField自动成为First Responder。First Responder
是第一个接收应用多种事件的对象。

当TextField完成输入，就需要交还First Responder给其他的对象。

需要在textFieldShouldReturn方法中处理输入完成，交还FR。


