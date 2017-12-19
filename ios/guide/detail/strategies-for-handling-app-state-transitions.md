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
当基于警告的打断产生时（如来了电话），应用会暂时移动到`inactive`状态。应用会保持这个状态，直到用户解除警告。在这个时候，应用会回到
`active`状态或者到后台状态。

*处理警告打断*
![处理警告打断](/assets/ios/ios-guide-app-interruptions.png)

通知会显示一个标示，而不会关闭应用。这个标示会长时间在屏幕的顶部边缘，应用可以继续接收触摸事件。然而当用户
下拉这个标示显示通知中心，用户会移动到`inactive`状态，基于警告的打断就发生了。用户取消这个通告，或者开启其他的应用，应用会
移动到`active`状态或者`background`状态。应用可以使用Setting APP配置通知显示是一个banner或者是一个alert。

按Sleep/Wake按钮是其他类型的打断，会短暂的停止应用。当用户触发这个事件时，系统会停止触摸事件，把应用移动到`background`状态，
设置应用`applicationState`属性成`UIApplicationStateBackground`，并且锁住屏幕。


### 当应用进入前台时要做什么
当应用从后台进入前台，需要重新开始在进入后台时停止的任务。`applicationWillEnterForeground:`方法应该
撤消在`applicationDidEnterBackground:`方法中完成的任何事，`applicationDidBecomeActive:`方法应该继续
执行同样的事情在启动时。

*从后台进入前台*
![从后台进入前台](/assets/ios/ios-guide-app-back-to-fort.png)

注: `UIApplicationWillEnterForegroundNotification`通知也可以用于跟踪应用何时重新进入前台。可以使用默认的通知来注册。

#### 准备处理通知队列
应用在`Suspended`状态时应该准备返回到前台或者后台时处理通知队列。`Suspended`状态的应用不能执行任何的代码，所以这个时候
发生影响应用运行的事件（方向改变，时间改变，首选项改变等）时应用不能处理。为了让这些事件不丢失，系统会用一个队列保存所以
的通知，当应用可以处理时发送给应用。为了防止事件的重复，系统会确保每种类型的通知只有一个。

下面是可以合并和分发的通知，大多数通知是直接发送到注册的观察者。一些，像设备方向有关的通知，一般系统框架会拦截下来，以
另一种方式发送。

![通知分发](/assets/ios/ios-guide-app-notification-delivered.png)

通知队列分发到应用的主运行环中，一般发生在所有触摸事件或者其他用户输入之前。处理这些通知应该快速，不要造成延迟。如果延迟发
生，可以使用`Instruments`确定发生延迟的地方。

应用返回到前台也会收到View更新的通知，告诉应用最后更新后产生的脏View。应用在后台运行，可以调用`setNeedDisplay`
或者`setNeedDisplayInRect`方法请求更新View。但是后台应用不能更新视图，所以系统会合并这些请求，在应用返回前台时通知
应用。

#### 处理iCloud改变
如果iCloud因为任何原因而改变状态，系统会分发`NSUbiquityidentityDidChangNotification`通知给应用。这个状态是当iCloud
当用户登入或者登出或者打开同步或者关闭同步。这个通知暗示应用更新缓存和跟iCloud相关的用户界面。例如，当用户登出iCloud时，
应用应该删除所以iCloud相关的文件和数据。

如果应用已经提示用户保存文件在iCloud中，不要当iCloud状态改变后重复提示用户。在第一次提示后，应该在首选项中提供给应用选择
保存的位置。

#### 处理位置改变
当应用处于`Suspended`状态时，用户位置发生重大改变，应用可以在回到前台时使用`NSCurrentlocaleDidChangeNotification`通知
去强制更新所有跟位置信息有关的视图。

* 使用NSLocale的`autoupdatingCurrentLocale`方法。这个方法返回一个本地对象。
* 每当当前语言环境信息更改时，重新创建任何缓存的日期和数字格式化程序对象。

#### 处理应用配置改变
应用使用Settings app管理应用的配置时，应该观察`NSUserDefaultsDidChangeNotification`通知。因为用户可以在应用不在前台时修改
应用的配置，所以可以使用这个通知去响应重要的配置的改变。即时响应配置有时候可以消除安全漏洞。在接收到配置改变通知时，应用
方法重新读取所有配置，如果有必要，需要重置用户界面。

### 应用进入后台做些什么
当应用从前台进入后台，可以使用` applicationDidEnterBackground: `方法来完成下面的事情：

* 准备好应用的快照，当` applicationDidEnterBackground: `方法返回，系统会抓拍应用的快照。
* 保存应用状态相关的信息，用户关键数据与应用状态。
* 根据需要释放内存，如果应用占用了太多的内存，系统会第一时间终止应用。

` applicationDidEnterBackground: `方法最多执行5秒钟，如果在5秒内没有返回，那么应用会被杀死。如果需要更多的时间，
可以使用`beginBackgroundTaskWithExpirationHandler:`方法异步执行任务。

系统除了调用生命周期方法外，还会在应用从前台进入后台后发送`UIApplicationDidEnterBackgroundNotification`通知。

#### 后台转换生命周期
当用户按下Home键，按下Sleep/wake键，或者启动其他的应用，会使应用从前台进入到后台，这个过程会调用应用的`applicationWillResignActive:`
方法和`applicationDidEnterBackground:`方法。进入后台之后，大多应用会在短时间内进入到Suspended状态，除非设置了后台服务。

*应用从前台进入后台*
![应用从前台进入后台](/assets/ios/ios-guide-app-fort-to-back.png)

#### 准备应用快照
当应用的`applicationDidEnterBackground:`方法调用之后，系统会获取应用的快照。当一个应用程序被唤醒来执行后台任务时，系统可能
会拍摄一个新的快照以反映任何相关的变化。

如果确定在后台对View进行了改变，可以调用`snapshotViewAfterScreenUpdates: `方法强制重新绘制主View。调用`setNeedsDisplay`方法对
快照无效。

#### 减少内存占用
进入后台后，应用应该释放尽可能多的内存。系统会在内存中保留尽可能多的应用，但是当内存不足时，会终止Suspended状态的应用的。占用大量内存
的应用是第一个被终止的。

应用在不需要对象时，应立即移除对象的强引用。移除对象的强引用，可让编译器可以释放对应的内存空间，当需要缓存对象，提高性能时。
可以当应用移动到后台，再删除他们的强引用。

需要尽快删除强引用的对象：
* 创建的Image对象（UIImage返回的对象，系统会自动清除）
* 大的视频或者数据文件。
* 其他的数据，应用不再需要，并且可以重新创建。

当应用移动到后台，系统会帮忙清理一些数据：
* 清除所有的Core Animation layer。
* 清除所有系统引用的Image
* 清除系统管理的强引用的数据缓存
