---
layout: page
permalink: /ios/guide/detail/strategies-for-handling-app-state-transitions
---

Strategies for Handling App State Transitions

系统期望应用在转换运行状态时，有不同的表现。如当应用从前台转到后台，应该保存用户
数据，并且停止正在执行的任务。

### 应用启动时做了哪些
当应用启动（到前台或者后台），使用应用代理`application:willFinishLaunchingWithOptions:`和
`application:didFinishLaunchingWithOptions:`方法做下面的事情:

* 检查应用启动字典项信息，判断为什么启动，并作出适合的响应。
* 初始化关键数据结构。
* 准备应用的window和view的显示。
	+ OpenGL ES 需要推迟到`applicationDidBecomeActive:`方法再初始化。
	+ 使用`application:willFinishLaunchingWithOptions:`方法呈现window，因为UIKit提交构建window现实，是
		在这个方法之后。

这两个启动方法还支持状态恢复，需要决定当应用是状态恢复时应用执行的操作。这两个方法应该是轻量的、快速的，
需要在5秒内完成任务，不然系统会因为应用无响应而杀死应用。

#### 应用启动周期
当应用启动时，应用状态会从`no-running`到`inactive`，短暂停留`inactive`到`active`或者`background`。
在启动周期里，系统会创建一个进程，并且创建一个主线程，在主线程里调用应用的main方法。
这个main方法是UIKit框架提供。

*启动应用到前台*
![启动应用到前台](/assets/ios/ios-guide-app-launch-foreground.png)

*启动应用到后台*
![启动应用到后](/assets/ios/ios-guide-app-launch-background.png)

应用启动到后台，一般是处理后台事件。短暂的处理事件后，应用还会被挂起。所以后台启动的程序不会
显示用户界面。

区分应用是启动到前台还是后台，在初始化的两个方法里，使用UIApplication对象的`applicationState`属性来判断。
如果是fore，那么这个属性包含`UIApplicationStateInactive`；如果是back，那么这个属性包含`UIApplicationStateBackground`。

如果应用是从URL启动时，事件流程又会不一样。


#### 从横向模式中启动
通常应用是从Portrait Orientation启动，然后根据设备的方向去调整是Portrait还是Landscape。
支持两种方向的应用，应该总是配置Portrait视图，然后使用ViewController处理旋转。

如果只支持Landscape，那么需要显示的配置:

* 在Info.plist文件中添加`UIInterfaceOrientation`关键字。
* 让view在landscape方向中正确的显示布局和大小。
* 重写ViewController的`shouldAutorotateToInterfaceOrientation:`方法，return YES。

应用应该总是使用ViewController管理基于Window的内容。

配置了`UIInterfaceOrientation`关键字，告诉系统让状态栏横向显示，并且让ViewController处理
视图的横向显示。相当于在UIApplicaton对象中调用`setStatueBarOrientation:animated:`。

#### 安装特殊的文件在第一次启动
在应用第一次启动时，可以根据需要创建特殊的文件或者配置文件。应用的特殊文件可以创建在Library/
Application Support/<BundleID>/directory在应用的沙箱中。<bundleID>是应用包的身份识别。

也可以创建文件在其他的目录，如iCloud目录，或者本地Documents目录，根据需要。

如果需要修改应用包中的数据文件，应该复制出来修改，而不能修改包下面的任何内容。因为iOS应用包中的文件
是通过代码签名的，如果修改的文件，那么会使得签名无效，系统会防止应用以后启动。

### 当应用暂时打断时做什么
基于警告的打断会使应用临时失去控制权。应用可以继续运行在前台，但是不能接收触摸事件（可以继续接收通知和其他类型的
事件，如加速设备的事件）。响应这种变化，应用需要在`applicationWillResignActive:`方法中作下面的事情:

* 保存数据和相应的状态信息
* 停止Timers和其他定时任务
* 停止正在运行的元数据查询
* 不要启动新的任务
* 暂停视频的播放（除了在AirPlay中的播放）
* 如果是游戏APP需要进入暂停状态
* 调整OpenGL ES帧速率
* 挂起执行非关键代码的任何高度队列或操作队列（可以在不活动时继续处理网络请示和其他时间敏感的后台任务）

当应用从后台到active状态时，应该使用`applicationDidBecomeActive:`方法恢复所有在`applicationWillResignActive:`方法设置的内容。

当用户按下Sleep/Wake按钮时，应用应该释放通过NSFileProtectiongCompleta属性保护的文件。因为设备配置了一个适当的密码，当用户按下
Sleep/Wake按钮后会锁住系统屏幕，并抛弃打开被保护文件的密钥，任何在这个时候访问这些文件都会失败。所以应该在
`applicationWillResignActive:`中关闭文件，在`applicationDidBecomeActive:`中打开。

注:在应用的几个检查点中总是保存相应的用户数据。虽然可以在应用状态转换时保存，但不要总等到应用状态转换才保存。例如，当ViewController
消失时就应该保存他的数据。

#### 响应短暂的打断
当基于警告的打断产生时（如）


### 当应用进入前台时要做什么
当应用从后台进入前台，需要重新开始在进入后台时停止的任务。`applicationWillEnterForeground:`方法应该
撤消在`applicationDidEnterBackground:`方法中完成的任何事，`applicationDidBecomeActive:`方法应该继续
执行同样的事情在启动时。
