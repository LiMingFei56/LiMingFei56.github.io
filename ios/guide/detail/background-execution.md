---
layout: page
permalink: /ios/guide/detail/background-execution
---

Background Execution

当用户启动一个不同的应用，或者锁住屏幕，那么系统会改变应用的状态到background。如无必要
（对提高用户体验没有帮助）那么应该停止当前正在进行的工作，使用系统改变应用的状态到Suspended
或者直接终止。这样做可以对设备资源（电池和内存）做到有效的使用。

如果应用进入后台后，还有不得不做的任务，比如记录用户移动轨迹，播放音乐，下载应用内容放便用户
下次快速打开。那么应该使用iOS提供的后台执行技术，在保证系统资源的前提下完成后台工作。
iOS提供的技术分为三类：

* 在应用处于前台时开启的短任务，可以在应用转到后台时请示相应的时间来完成这个任务。
* 在应用处于前台时开启的下载任务，可以把下载任务交给系统，应用可以在下载过程中Suspended或者terminated。
* 需要在后台运行以支持特定类型任务的应用程序可以声明对一个或多个后台执行模式的支持。

### 执行有限长度的任务
如果应用任务执行一半，但是应用要进入Background状态，那么可以跟系统请求一些时间来执行完
这个任务。使用`beginBackgroundTaskWithName:expirationHandler:`和`beginBackgroundTaskWithExpirationHandler:`
方法都可以请示一些时间，当任务处理完成需要调用`endBackgroundTask:`方法告诉系统应用已结束任务，
可以被Suspended。

每一次调用上面2个方法，都会生成唯一一个Token，当任务结束时需要使用这个Token调用`endBackgroundTask:`方法
来告诉系统任务已结束。如果应用没有调用`endBackgroundTask:`方法，那么系统会退出这个应用。如果没有调用
`endBackgroundTask:`方法，并且提供一个过期的处理程序开启一下任务，那么系统会执行这个任务，并且最后提供一
次调用`endBackgroundTask:`方法的机会。

不用等到应用进行后台再进行上面的操作，应该在前台执行任务时就使用这个模式。

如果想知道应用运行了多长时间，可以访问backgroundTimeRemaining属性。

有限长度的任务，不能执行太长时间，因为应用已经非常接近到期时间了。

### 下载任务
当下载文件时，应用应该使用`NSURLSession`对象来下载，当应用被Suspended或者Terminate系统会接管
这个下载任务并继续执行。当`NSURLSessing`对象配置为background传输时，系统会在单独的进程中管理
这些任务，当任务完成时会通知应用，如果应用终止了会视情况来判断是否启动应用。

创建支持后台运行的下载任务：

	1. NSURLSessionConfiguration的`backgroundSessionConfigurationWithIdentifier:`方法创建一
		个配置对象。
	2. 设置配置对象`sessionSendsLaunchEvents`为YES。
	3. 如果下载任务是在前台开始的，建议把`discretionary`属性设置为YES。
	4. 配置对象其他的属性。
	5. 使用配置对象创建`NSURLSession`对象。

配置完成后，`NSURLSession`对象会在适当的时候无缝地将上传和下载任务交给系统。如果任务完成并且应用
在运行，那么这个Session对象会通知代理。如果任务没有完成，但是系统终止了应用，那么系统会自动管理这
个任务，在后台执行。如果用户终止应用，那么系统会取消任何待处理任务。

当于后台Session相关的所有任务都完成了，系统会重新启动一个终止了的应用（`sessionSendsLaunchEvents`
设置为YES，并且用户没有手动终止应用），而且会调用回调应用代理的
`application:handleEventsForBackgroundURLSession:completionHandler:`方法（系统有可能也会重新启动应用
关注的身份信息，或者其他相关的任务事件）。在应用代理的回调方法中，使用提供的Identifier创建一个新的
`NSURLSessionConfiguration`和`NSURLSession`对象，配置要一样。系统会使下载任务连接到新创建的Session对象，
并将其状态报告给Session对象的委托。

### 实现长时间任务
有些任务需要长时间的运行，应用必须审请特殊的权限才能在后台运行从而不被系统Suspended。
在iOS中，只有特殊的应用才允许运行在后台: 

* 在后台播放音频的应用
* 在后台录制音频的应用
* 随时向用户通知其位置的应用程序
* 支持VoIP的应用
* 应用需要经常下载和处理新内容
* 从外部配件定期更新的应用

实现这些服务的应用程序必须声明它们支持的服务，并使用系统框架来实现这些服务的相关方面。
声明这些服务让系统知道你使用了哪些服务，在某些情况下，阻止系统框架Suspended应用。

#### 声明应用支持后台任务
Xcode5及以后，应用需要在Info.plist文件中声明使用的服务。在Info.plist文件中添加`UIBackgroundModes`关键字
，选择一个或多个应用需要的服务。

后台模式列表
![后台模式列表](/assets/ios/ios-guide-app-background-mode.png)

上面每一下模式都可以使系统在适当的时候唤醒应用或者启动应用来响应相关事件，并且让
系统继续发送事件到应用。否则应用到后台后，会在短时间内停止。

#### 跟踪用户的位置

