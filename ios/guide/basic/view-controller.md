---
layout: page
permalink: /ios/guide/basic/view-controller
---

View Controller

### View Controller生命周期
UIViewController管理View的层次结构，IOS会自动在适合的状态下调用UIViewController中
的方法。所以我们需要实现对应的方法来处理View。

	* viewDidLoad() - 当ViewController的内容视图从StoryBoard中创建，并且保证Outlet
		中都有值时调用。可以在这个方法中对View做其他的设置。该方法只能在内容视图
		被创建时调用一次。然而内容视图不是必然在controller实例化时创建，反面会在
		系统或者其他代码访问controller中view属性时lazy创建。

	* viewWillAppear() - 在ViewController的内容视图被添加到app view层次结构之前
		调用。这个方法可以触发内容视图添加到屏幕之前的任务，但是不保证视图会显示
		（有可能被其他view遮挡或者view隐藏了）。

	* viewDidAppear() - 在ViewController的内容视图被添加到app view层次结构之后
		调用。这个方法可以触发内容视图出现到屏幕时的任务，如加载数据或者显示动画。
		这个方法也不保存内容视图是可见的。

	* viewWillDisappear() - 在ViewController的内容视图将要从app view层次结构之中删除
		。这个方法可以执行清理任务，如改变或者释放FirstResponder状态。该方法不管
		内容视图的可见性。只要将被删除，就会调用这个方法。

	* viewDidDisappear() - 在ViewController的内容视图已经从app view层次结构之中删除
		。使用这个方法执行其他的释放操作。不管可见性，只要被删除了就会调用。

### Intrinsic content size(真正的内容大小)
一个View的真正大小是基于内容的小。一个空的ImageView是没有真正大小的，设置了图片
后，View的真正大小就图片的大小。

Placeholder可以提供一个临时的真正大小。此值仅在Interface Builder中设计界面时使用；
在运行时，布局引擎改为使用视图的实际真正内容大小。

### View And Controls，Create a Gesture Recognizer
View和Controls有细微差别，它们以特定的方法来响应用户的Action。View是显示内容，Controls
是修改内容。一个Control（UIControl）是UIView的子类。

View(Labels,ImageView)
Controls(TextFields, Button)

ImageView不是一个Controls，所以不能像一般的Controls一样添加Action。另一种方法是
添加Gesture Recognizer。GR是一个附加到View上的对象，用来像Controls来响应用户输入。
UITapGestureRecognizer

### 自定义View
继承一个UIView后，需要实现2个初始化的方法，init(frame:)和init?(coder:).一个是设计
界面时Interface Builder添加View到Canvas后实例化时使用，另一个是在运行时，应用从
StoryBoard中加载。
	
当实例化一个View时，translatesAutoresizingMaskIntoConstraints属性默认为true。这个
属性告诉布局引擎通过frame和autoresizingmask属性创建一个Constraints定义View大小和
位置。通常需要使用自定义的Constraints。当添加一个View到StackView时，StackView会自动
设置这个值为flase。但是显示的调用这个方法是一个好习愦。

### Interface Builder Supports Basic types
	* Booleans
	* Numbers
	* Strings
	* CGRect
	* CGSize
	* CGPoint
	* UIColor

添加Inspectable properties 需要在上面的类型的属性前加上@IBInspectable


### Button states
	* normal
	* highlighted
	* focused
	* selected
	* disabled

### Accessibility Information
IOS内置有辅助功能信息，可以为特殊需求的人群提供卓越的移动体验。这些包括 VoiceOver
, Switch Control, playback of closed captioned or audio described video
, Guided Access, Text to Speech等等

### 自定义View @IBInspectable 和 @IBDesignable

@IBInspectable 可以让Attributes Inspector配置自定义属性
@IBDesignable 可以让Interface Builder显示自定义View
