---
layout: page
permalink: /ios/guide/detail/performance-tips
---

Performance Tips

应用开发设计中需要总体考虑应用的性能，电池的使用和内存的占用是最重要的部分，当然还有其他方面的考虑。

### 减少应用电池的消耗
电池消耗在移动设备上总是问题。电源管理系统会通过关闭一些当前不用的硬件来节省电池。

* The CPU
* Wi-Fi, Bluetooth, and baseband (EDGE, 3G) radios
* The Core Location framework
* The accelerometers
* The disk

可以通过优化来处长电池的寿命，优化的目标应该是尽可能以最有效的方法尽最大努力。应该总是使用`Instruments`优化
应用的算法，并且遵守下面的原则：

* 避免使用轮询。轮询会防止CPU进入睡眠，应该使用NSRunLoop或者NSTimer类完成定时任务。
* 尽可能的把UIApplication对象的`idleTimerDisabled`属性设置为NO。idle Timer会在空闲时关闭屏幕。
* 尽可能合并任务一些执行。一次执行一大块任务，比长时间中每次执行小块任务消耗的电池少。不会频繁的启动CPU。
* 避免经常访问磁盘。把多个小的更改合并成一个大的更改。
* 不要比所需的更快的速度绘制屏幕。绘图对于电源方面来说是昂贵的，不要依靠硬件来节制帧速率。应该自己控制。
* 如果使用`UIAccelerometer`类接收加速度事件，在不需要时关闭他。

访问网络越频繁，数据量越大，那么消耗的电量就越多，网络方面使用下面的原则：

* 仅在需要时连接到外部网络服务器，而不要轮询这些服务器
* 当您必须连接到网络时，传输执行该任务所需的最小数量的数据。使用紧凑型数据格式，不要包含被忽略的多余内容
* 以连发的方式一次性处理网络请示，不要过段时间发送一个数据包。使用NSURLSession时，不能设置等待上一个完成。最好
	使用系统自动处理，这样会最有效率
* 尽可能使用Wi-Fi无线电连接到网络。 Wi-Fi使用更少的功率，并优于蜂窝无线电
* 如果您使用Core Location框架收集位置数据，请尽快禁用位置更新，并将距离过滤器和准确性级别设置为适当的值。
	核心位置使用可用的GPS，小区和Wi-Fi网络来确定用户的位置。尽管核心位置尽量减少这些无线电的使用，
	但设置精确度和滤波器的值使核心位置可以在不需要的情况下完全关闭硬件

可以使用`Instruments`应用分析应用的电量消耗。

### 有效的使用内存
应用应该尽可能的少使用内存，确保不会因为内存不足请求新内存时让系统遇到麻烦。在系统需要应用释放内存时，应用
应该即时的响应。

#### 观察低内存的警告
当系统发送一个低内存警告到应用时，应用需要立即响应。低内存警告是应用释放不需要对象的机会。如果不即时响应这个警告，系统
有可能会终止应用，系统会使用下面的APIs通知应用：

* 应用代理`applicationDidReceiveMemoryWarning:`方法
* UIViewController的` didReceiveMemoryWarning`方法
* UIApplicationDidReceiveMemoryWarningNotification通知
* 调度资源`DISPATCH_SOURCE_TYPE_MEMORYPRESSURE`。这个是唯一可能判断低内存的严重层度

接收上面的任何一种警告，应用应该立即响应并释放不需要的内存。如缓存和图片。如果有大型的数据结构，则需要把数据
存储到磁盘上，并释放内存中的副本。

如果数据模型知道需要清楚的资源，应用可以管理相应的对象注册`UIApplicationDidReceiveMemoryWarningNotification`通知，并
删除强引用。这样处理可以避免应用代理中的低内存警告的路由。

注：您可以使用iOS模拟器中的“模拟内存警告”命令在低内存条件下测试应用程序的行为。

#### 减少应用内存占用
尽可能减少内存占用

![](/assets/ios/ios-guide-memory-reduce.png)

#### 明智的分配内存
提高内存使用效率

![](/assets/ios/ios-guide-memory-allocate.png)

### 调配网络请求代码
iOS中的网络堆栈包括多个用于通过iOS设备的无线电通信的接口。主程序接口是CFNetwork framework，基于BSD socket和
Core Foundation framework网络连接。

* Core Foundation framework提供NSStream类通信
* BSD 提供Socket通信

#### 有效的网络技巧
网络通信是设备上最耗电的操作，减少网络通信的次数，大小，延长两次通信的间隔时间有助于添加电池寿命。

* 对于您控制的协议，定义您的数据格式尽可能紧凑
* 避免使用聊天协议
* 只要可能，就以突发形式传输数据包

#### 使用WIFI
在Info.plist中配置`UIRequiresPersistentWiFi`属性，告诉系统如果检测到任何活动的WIFI热点，就显示选择对话框。还让系统知道
应用运行时不应该关闭WIFI设备。

默认时iOS有个内建的计时器，30分钟后会关闭WIFI设备。如果应用包含上面的属性，那么系统会在这个应用关闭后才开始计时。当设备空闲时
（屏幕锁定），上面的属性没有效果，因为这个应用不是活动的，而且他没有WIFI连接。

#### 这个飞行模式的警告
当满足下面条件时，系统处于飞行模式中时启动应用，会显示警告并且通知用户这个事实。

* Info.plist配置`UIRequiresPersistentWIFI`
* 应用启动时设备处于飞行模式
* 切换到飞行模式后，设备上的Wi-Fi尚未被手动重新启用

### 改善文件管理
最大化的减少写入磁盘的数据量。文件操作是对闪存设备的读和写，闪存设备存在使用寿命。使用下面的指导来减少文件的操作：

* 只写入修改的部分，并且合并修改操作。避免写入整个文件，只修改几个字节。
* 定义文件格式时，将经常修改的内容分组在一起，以尽量减少每次需要写入磁盘的块的总数
* 如果您的数据由随机访问的结构化内容组成，请将其存储在Core Data持久性存储或SQLite数据库中
	，特别是如果您操作的数据量可能增长到超过几兆字节

### 使应用程序备份更有效
当连接iCloud或者连接iTunes时，备件就会发生。本地文件的保存位置决定了是否会被备份，如果应用把临时的大数据文件放在可备份的
目录，那么会消耗额外的资源和时间。

#### 应用备份最佳实现
应用不用准备任何的备份和恢复的操作，设备有一个活动的iCloud账号时会在合适的时间备份指定位置的应用数据。对于插入设备,iTunes是
进行增量备份。iCloud和iTunes不会备份下面目录的内容：

* <Application_Home>/AppName.app
* <Application_Data>/Library/Caches
* <Application_Data>/tmp

防止同步花太多时间，选择应用的主目录来存放文件。大文件应该最后备份到iCloud和iTunes。而且为了有效使用iCloud空间，通过下面
指导来选择需要备份的数据。

* 关键数据应该存储在<Application_Data> / Documents目录中。关键数据是您的应用无法重新创建的任何数据
	，例如用户文档和其他用户生成的内容
* 支持文件包括应用程序下载或生成的文件，并且您的应用程序可以根据需要重新创建。存储应用程序支持文件的位置取决于当前的iOS版本
	- In iOS 5.1 and later, store support files in the <Application_Data>/Library/Application Support directory and add
		the NSURLIsExcludedFromBackupKey attribute to the corresponding NSURL object using the setResourceValue:forKey:error:
		method. (If you are using Core Foundation, add the kCFURLIsExcludedFromBackupKey key to your CFURLRef object using the
		CFURLSetResourcePropertyForKey function.) Applying this attribute prevents the files from being backed up to iTunes 
		or iCloud. If you have a large number of support files, you may store them in a custom subdirectory and apply the 
		extended attribute to just the directory
	- In iOS 5.0 and earlier, store support files in the <Application_Data>/Library/Caches directory to prevent them from 
		being backed up. If you are targeting iOS 5.0.1, see How do I prevent files from being backed up to iCloud and 
		iTunes? for information about how to exclude files from backups.
* 缓存存放在<Application_Data>/Library/Caches目录
* 临时文件存放在<Application_Data>/tmp目录。使用完成后应该删除

虽然iTunes自己备份应用程序包，但在每次同步操作期间都不这样做。当设备下一次与iTunes同步时，直接从设备购买的应用将得到备份
。但是，在后续的同步操作中不会备份应用程序，除非应用程序包本身已更改（例如，因为应用程序已更新）

#### 在应用更新期间保存文件
当应用下载并安装新的应用时，iTunes会安装新的应用到新的目录。然后把旧应用中的数据文件移动到新应用的目录中，然后删除旧应用目录。
更新时保留下面应用文件目录：
* <Application_Data>/Documents
* <Application_Data>/Library

尽管其他用户目录中的文件也可能被移动，但更新后不应该依赖它们

### 把工作移出主线程
请务必限制您在应用程序主线程上所做的工作类型。主线程是您的应用程序处理触摸事件和其他用户输入的地方。为确保您的应用程序
始终对用户做出响应，您绝不应使用主线程执行长时间运行或潜在无限的任务，例如访问网络的任务.相反，你应该总是将这些任务移
动到后台线程上。这样做的首选方法是使用Grand Central Dispatch（GCD）或NSOperation对象异步执行任务

将任务移动到背景中会使主线程自由地继续处理用户输入,这在您的应用程序启动或退出时尤为重要。在这些时候，您的应用程序有望
及时响应事件。如果您的应用程序的主线程在启动时被阻止，系统甚至可以在启动之前终止应用程序。如果主线程在退出时被阻塞，
系统可能会在应用程序有机会写出关键的用户数据之前杀死该应用程序
