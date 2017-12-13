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
iOS提供了几种方法来跟踪用户的位置，大多数方法不需要应用在后台连续的运行。

* 大变化位置服务（推荐）
* 仅前台位置服务
* 后台位置服务

##### 大变化位置服务（iOS4以后，只存在有蜂窝无线电的设备上）
不需要高精度的位置信息的应用里，推荐使用大变化位置服务。这个位置服务只在用户位置发生大的变化的
时候才能更新位置。因此它非常适合为用户提供非关键的位置相关信息。如果位置更新时，应用处于Suspended状态，
那么系统会唤醒应用处理这个位置信息；应用处于terminated状态，应用会重新启动应用。

##### 前后台位置服务
前后台位置服务都是使用标准的核心位置服务去取回位置信息。不一样的地方在于，前台位置服务只会在应用处于
前台的时候工作，如果应用处于后台，就不会接收位置信息。后台位置服务需要在Info.plist文件中配置
（配置Capabilities或者UIBackgroundModes，location）。后台位置服务不会阻止系统Suspending应用，只会告诉系统
当有新的位置信息时唤醒应用。

*位置服务需要使用无线电设备，当连接使用这个设备时，会消耗大量的电量。所以要谨慎使用。*

#### 后台播放和录制音频
应用可以常时间的在后台执行播放和录制音频的任务。需要在Info.plist文件中配置(Capabilities或者UIBackgroundModes，audio)。
在后台播放音频内容的应用，必须播放声音内容，不能沉默。

后台音频的例子：

* 音乐播放应用
* 音频录制应用
* 支持通过AirPlay播放音频或视频的应用
* VoIP应用

当配置了Audio服务后，系统媒体框架会自动的防止应用Suspended。应用需要在后台连续的播放音频视频，或者录制音频，如果
停止的话，系统会Suspended应用。

可以使用系统提供的Audio框架来处理音频（视频可以使用Media Player或者AV Foundation framework）。
因为应用没有被Suspended，所以应用可以在后台接收回调，不过在回调方法中，应该只作与播放有关的操作。

因为支持音频的应用有很多，系统会在给定的时间内决定哪个应用可以播放或者录制音频。在前台的应用总是
优先操作音频。也有可以有多个后台应用允许播放音频，这是基于应用的Audio session配置的。所以应用总是需要
配置Audio session对象，小心的处理系统框架的中断信号和其他类型的Audio相关的通知。

#### 实现VoIP应用
Voice over Internet Protocol(VoIP，语音网络传输协议)，允许用户使用互联网代替手机设备来播打
电话。VoIP需要应用保持一个长连接，系统不会保持VoIP应用唤醒，而是允许应用Suspended并监控连接，当
检测到有数据传入，系统会唤醒应用。

配置VoIP应用的方法:

1. 配置支持VoIP应用的BackgroundMode，在Info.plist文件（Capabilities或UIBackgroundModes，voip）。
2. 配置一个Socket给VoIP使用
3. 在应用进行后台前，调用`setKeepAliveTimeout:handler:`方法去安装一个定期的处理任务，
	使用这个任务可以保持连接
4. 配置Audio Session处理音频的输入和输出

系统会允许应用运行在后台，并且管理应用的Socket连接。在系统启动之后，使用VoIP的应用会立即在后
台重新启动，以确保VoIP服务始终可用

#### 获取小量内容的机会
应用如果需要定期的检查新内容，可以向系统请求时间去处理这些。要支持这个模式，需要在Info.plist
文件中配置(Capabilities或者UIBackgroundModes，fetch)。

使用这个模式不保存系统会在任何时间执行应用的后台fetch，系统会在系统与所有应用间平衡Fetch操作，当
系统判断是一个Fetch的机会时，会在后台唤醒或启动应用，并调用应用的代理`application:performFetchWithCompletionHandler:`方法
。使用这个方法可以检查新内容和开启一个下载，当下载完成必须调用完成的回调方法，通知这个内容可用。
执行这个回调告诉系统可以Suspended应用并评估用电量。

快速下载少量内容，准确地反映何时可以下载内容的应用程序，比下载时间较长的应用程序或声称内容可用但
不下载任何内容的应用程序更可能在将来获得执行时间。

#### 使用推送通知启动下载
配置Remote-notification BackgroundMode，在Info.plist(Capabilities或UIBackgroundModes，remote-notification)。
服务启对用户设备推送一条信息，系统会在后台唤醒或启动你的应用，应用可以下载新内容。这样的话比启动应用后再
下载花的时间要少。

需要推送触发下载的模式，推送必需包含`content-available`关键字为`1`，当推送来了，系统会调用
应用代理的`application:didReceiveRemoteNotification:fetchCompletionHandler: `方法。

#### 后台下载新间
新间应用可以在后台下载新的杂志或者新间，需要在Info.plist中配置(Capabilities或UIBackgroundModes，newsstand-content)。
当使用Nesstand Kit framework去开启一个下载，应用Suspended或者Terminated时系统会继续这个下载。当下载完成，系统会把文件
传给应用。如果应用没有开启，系统会唤本应用来处理新文件。如果下载出错，系统也会唤醒应用来处理。


#### 连接外部设备
当外部设备有新操作时会唤醒应用。支持这个模式需要在Info.plist中配置(Capabilities或UIBackgroundModes，external-accessory)。
当启动这个模式时，External Accessory framework不会关闭与外部设备的Session（IOS4前会在应用挂启时自动关闭）。
当外部设备有新的操作时，外部设备框架会唤醒应用来处理这个操作。系统还会唤醒应用来处理外部设备的连接和断开通知。

支持外部设备的后台模式需要遵循一些原则：

* 应用必须提供一个接口让用户可以打开或关闭外部设备操作更新的事件。这个接口应用在适当的时候打开或关闭外部设备Session。
* 应用唤醒后有10秒的时间来处理数据。如果需要更多的时间，可以调用`beginBackgroundTaskWithExpirationHandler: `方法。

#### 连接蓝牙设备
当蓝牙设备有新的操作时唤醒应用。支持这个模式需要在Info.plist中配置(Capabilities或UIBackgroundModes，bluetooth-central)。
当启动这个模式时，Core Bluetooth framework会保持蓝牙设备的Session，系统会在蓝牙设备有新的事件或者连接、断开设备时唤醒应用。

在ios6,应用也可以使用蓝牙外部模式运行。支持这个模式需要在Info.plist中配置(Capabilities或UIBackgroundModes，bluetooth-peripheral)
Core Bluetooth framework 可以短暂的唤醒应用来处理事件。

支持蓝牙设备的后台模式需要遵循一些原则:

* 应用必须提供一个接口让用户打开或关闭接收蓝牙事件
* 唤醒后只有10秒的处理事件的时间，需要更多时间使用`beginBackgroundTaskWithExpirationHandler: `方法。

### 在后台获取用户的关注
Notifications是应用不是前台（Background,Suspended,Not Running）而引起用户注意的方法。应用可以使用本地Notification
显示一个警报，播放声音，显示一个icon或者3个组合使用。在一个Notification分发到用户，用户需要决定是否让应用进入前台
（如果应用是在前台，Notification会悄悄的分发给应用，而不会给用户）。

实现一个本地Notification：

1. 创建UILocalNotification。
2. 配置这个Notification
3. 使用UIApplicaton对象立即或定时启动Notification。

应用在同一时间可以有最多128个Notification，每个Notification允许在一个间隔时间里重复。如果应用在前台
，应用代理`application:didReceiveLocalNotification: `会被调用。

Notification中使用的声音文件和推送Notification要求一样。声音文件必须在应用的主包里，格式支持PCM,MA4,u-Law,a-law.
或者使用`UILocalNotificationDefaultSoundName `常量播放系统的默认声音

### 了解应用程序何时启动到后台
应用程序支持后台执行，那么系统有可能会在有事件进来时重新启动应用来处理事件。如果应用被终止（除用户强制退出），系统会在
下面的事件发生时启动用户：

#### 使用位置服务的应用
* 系统收到一个符合应用配置条件的位置更新。
* 设备进入或离开注册区域。（区域可以是地理位置区域或者是iBeacon区域）。

#### 音频应用
Audio framework需要应用来处理一些数据。

#### 蓝牙应用
* 以中心规则从连接设备接收数据的应用。
* 以连接设备为规则从中心接收命令的应用。

#### 后台下载应用
* 推送通知到达应用，并且推送通知内容包含`content-available`为1
* 系统会在特定的时间唤醒应用
* 使用NSURLSession，session中的任务全完成或者出现错误
* 由Newsstand发启的下载任务完成


在大多数情况下，系统在用户强制退出后不会重新启动应用程序。一个例外是使用位置服务的应用，在iOS8及以后的位置应用会
在应用强制退出后也会重启。然而在其他情况下，用户必须明确地启动应用程序或重新启动设备，然后系统才能将应用程序自动
启动到后台。

### 做一个负责任的后台应用程序
前台应用总是优先使用设备的资源，后台应用必须准备这个差异并且调整后台应用的行为。当应用移动到后
台需要遵守下面一些原则:

* 不要在代码里调用任何OpenGL ES。
* 在Suspended前，取消所有Bonjour-related services。
* 准备好处理基于网络的Socket中的连接失败。应用Suspended后，系统有可能关闭Socket连接。
* 在应用进入后台前保存应用状态。IOS6中的状态保存机制。
* 移动到后台前，删除不需要对象的强引用。
* 在被Suspended前，停止使用共享的系统资源。
* 避免更新Windows和Views。例外情况是为了拍摄应用程序快照而更新。
* 响应外部设备连接和断开连接的通知。
* 移动到后台前清理活动的Alerts。
* 移动到后台前删除View上的敏感信息。
* 在后台做最少的工作。

### 选择退出后台执行
在Info.plist文件中配置`UIApplicationExitsOnSaspend`为YES后，应用不会进入Background和Suspended状态。
而是调用`applicationWillTerminate:`方法后进入No-running。`applicationWillTerminate`大约有5秒的执行时间，
来执行清理工作。

这个行为是不推荐的，但是可以简化应用的逻辑（不用考虑后台状态），当应用使用大内存并且不容易释放时，
系统可以直接杀死应用，帮忙应用释放内存。






