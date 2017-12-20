---
layout: page
permalink: /ios/guide/detail/strategies-for-implementing-specific-app-features
---

Strategies for Implementing Specific App Features

不同的应用有不同的需求，但大多数行为是通用的。

### 隐私策略
保护用户隐私是设计应用的很重要的一点。系统提供了隐私控制，但应用应该保护本地的用户数据。

#### 使用磁盘加密保护数据
数据加密使用内建的设备使用加密文件保护到磁盘上，当使用时需要解密。如果用户的设备是锁住的，
那么保护文件就不能访问，只有等到用户解锁后才能访问。

数据保护在大多数设备上是有效的，使用时有下面的要求：
* 用户设备上的文件系统必须支持数据保护。大多数设备支持这个行为。
* 用户必须有一个有效的密码

保护文件，需要对文件添加一个属性，指定保护级别。可以使用NSData类或者NSFileManager类，来添加
属性。当写一个新文件，可以使用`writeToFile:options:error:`方法传入一个NSData对象；当这个文件存在，
可以使用NSFilemanager类的`setAttributes:ofItemAtPath:error:`方法去修改`NSFileProtectionKey`的值。

保护级别：
* No protextion - 文件会加密，但是不会基于用户密码并且在设备锁住时可用。
	NSData: NSDataWritingFileProtectionNone 
	NSFileManager: NSFileProtectionNone

* Complete - 文件加密，并且在设备锁住时不可用。
	NSData: NSDataWritingFileProtectionComplete
	NSFileManager: NSFileProtectionComplete

* Complete unless already open - 这个文件加密，如果文件在设备锁住前被打开，设备锁住后，这个文件可以继续使用。
	NSData: NSDataWritingFileProtectionCompleteUnlessOpen
	NSFileManager: NSFileProtectionCompleteUnlessOpen

* Complete until first login - 文件加密并且不可用，直到设备重启并且解锁一次。
	NSData: NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication
	NSFileManager: NSFileProtectionCompleteUntilFirstUserAuthentication

如果保护一个文件，应用必须准备推动访问这个文件。当完成文件可用，用户锁住设备后应用会失去文件的读和写。
可以使用下面的文件跟踪保护文件的状态变化：

* 实现`applicationProtectedDataWillBecomeUnavailable:`和`applicationProtectedDataDidBecomeAvailable: `方法
* 所有对象可以注册`UIApplicationProtectedDataWillBecomeUnavailable`和` UIApplicationProtectedDataDidBecomeAvailable`通知
* 可以检查UIApplication的`protectedDataAvailable `属性，决定是否可以访问保护文件。

#### 应用用户的身份唯一
给用户一个唯一的识别，可以提供给用户个性化的服务。iOS提供`identifiers`可以帮助做到这一点。

下面有一些识别用户的情况：
* 使用户链接到服务器账号。使用保护文件保存用户的数据。
* 区分在不同设备上运行的应用的实例。使用UIDevice的` identifierForVendor`属性获得id，区分不同设备。
* 识别用户为了推送广告。使用ASIdentifierManager的`advertisingIdentifier`属性获得id。

iOS不提供在多个设备上识别同一个用户。这个需要自己实现。

### 遵守限制
用户可以指定一个限制来设置显示媒体的范围。如果应用播放或修改媒体是基于限制的，那么应用需要遵守`setting`和响应`setting`的
改变。

得到当前的`setting`，使用`standarUserDefaults`对象和使用`objectforKey`方法，并使用下面的key:

com.apple.content-rating.ExplicitBooksAllowed	Boolean.如果为NO，表示不允许显示书籍
com.apple.content-rating.ExplicitMusicPodcastsAllowed	Boolean.如果为NO，表示不允许显示音乐、视频和播客。
com.apple.content-rating.AppRating	NSNumber.0到1000,不允许显示高于这个值的应用。
com.apple.content-rating.MovieRating	NSNumber.0到1000,不允许显示高于这个值的视频。
com.apple.content-rating.TVShowRating	NSNumber.0到1000,不通话显示高于这个值的TV。

如果`objectForKey`返回nil，表示关于这个限制不可用。这时应用可以使用自己的策略决定显示的范围。

要检测用户何时更改限制，请注册`NSUserDefaultsDidChangeNotification`通知。当`standardUserDefaults`对象检测到一个配置改变时，
通知应用。

### 支持多个版本的iOS
为了支持较早版本的iOS系统，需要使用运行时检测来检测当前iOS版本，用来判断是否调用新版本iOS的API。

* 决定一个类是否存在，可以看这个类的Class对象是否为空。如果一个类不存在，连接会使这个类的Class对象总是返回nil。

	if ([UIPrintInteractionController class]) {
	   // Create an instance of the class and use it.
	}
	else {
	   // The print interaction controller is not available so use an alternative technique.
	}

* 决定一个对象中是否有指定的方法，可以使用`instancesRespondToSelector:`类方法或者`respondsToSelector:`实例方法。
* 决定一个基于C语言的函数可用，使用这个函数名和NULL来进行判断。如果这个函数符号不为空，就可以调用这个函数。

	if (UIGraphicsBeginPDFPage != NULL) {
		UIGraphicsBeginPDFPage();
	}

### 保持应用的视觉效果
如果应用支持后台运行，但这不代表永远运行下去。系统可能会为了前台的应用使用，而终止后台应用释放内存。然而用户应该
不需要关心应用是运行的，还是终止的。对用户来说，退出一个应用相当于一个短暂的打断。当用户返回这个应用时，这个应用应该
总是显示用户最后操作的界面，并且可以继续执行。这种行为为用户提供了更好的体验，并且内置到UIKit中的状态恢复，使用这个
方法相对容易实现。

UIKit提供内建的基础设施，保存和恢复ViewController和View的状态。但需要应用编写代码告诉UIKit保存哪些状态。

有三个地方需要应用考虑的状态保存：

* 应用代理对象，管理应用顶级的状态
* ViewController对象，管理应用的用户界面的整体状态
* 自定义View，管理自定义数据的状态

#### 启动状态保存和恢复
状态保存和恢复默认是关闭的，应用需要指定开启动这个功能
* application:shouldSaveApplicationState: 返回YES开启状态保存
* application:shouldRestoreApplicationState: 返回YES开启状态恢复

有时候希望不关闭状态保存和恢复，如应用更新后，新的界面没有办法恢复旧界面的数据。这时可以
使`application:shouldRestoreApplicationState:`返回NO。

#### 保存与恢复的处理过程

##### 状态保存
UIKit会在合适的时候调用执行状态保存，如应用从前台进入到后台。当UIKit决定需要新的状态信息时，会
检查应用的View和ViewController，判断哪些对象需要保存。决定好保存数据后，UIKit会使用保护文件保护这些
数据到磁盘上。因为是使用保护文件保存的数据，所以只有到设备解锁后才能访问。

需要处理的事情：
* 告诉UIKit支持状态保存
* 告诉UIKit哪些ViewController和View应该保存
* 编码任何保存对象的相关数据

*状态保存流程*
![状态保存流程](/assets/ios/ios-guide-state-preservation.png)

应用启动时会使用保护文件中的数据来恢复界面。当应用启动完成会丢弃这个保护文件，如果恢复出错也会丢弃这个文件。

##### 状态恢复
状态恢复时，UIKit使用保存的数据填充界面，但是实际对象还是应用代码来创建，因为应用对象可能是通过StoryBoard创建的。
在对象创建后，UIKit使用保存的数据初始化对象。

需要处理的事情：
* 告诉UIKit支持状态恢复
* 提供（或创建）UIKit请示的对象
* 解码保存的对象数据，并用数据把对象返回到以前的状态

*状态恢复流程*
![状态恢复流程](/assets/ios/ios-guide-state-resotring.png)

状态恢复不会恢复2个ViewController之间的关系，应该是每个ViewController负责恢复自己的状态信息和子视图的状态信息。
不是所有的ViewController需要编码子ViewController的信息。

因为是应用负责重建ViewController，所以可以在状态恢复的流程中灵活的改变用户界面。但是不能使ViewController的层次结构
进行重大的改变，会导致恢复数据不可用。

##### 决定哪些对象需要保存
对于状态的保存与恢复，应用的最大的责任是决定哪些对象需要保存。UIKit只保存有恢复识别码的对象，这个恢复识别码是识别view或者
ViewController。在保存的时期时，UIKit会遍历ViewController层次结构，识别出所有据有恢复识别码的对象。如果一个ViewController没
有恢复识别码，那么这个ViewController和它的所有子对象都不会保存。

根据应用，保存所有的ViewController有可能有意义，有可能没有。因为应用当前如果是临时的界面，应用应该返回到一个稳定的界面。

对于每个被保存的ViewController，需要决定怎么样来恢复它们：
* 让应用代理重新创建它们
* 对恢复的ViewController提供一个恢复类来创建它们（使用`UIViewControllerRestoration`）

如果ViewController总是从MainStoryBoard中创建，那么不要使用恢复类。应该让应用代理找到对象，或利用UIKit的支持隐式找到恢复的对象。

如果ViewController不是从MainStoryBoard中创建，那么提供一个恢复类。最简单的是使每个视图控制器使用自己的恢复类。

当应用启动时，UIKit会加载MainStoryBoard或者nib文件，调用应用代理的`application:willFinishLaunchingWithOptions:`方法，并且
尝试恢复应用状态。第一件事就是告诉应用提供ViewController对象，用来匹配保存数据。如果一个ViewController有个恢复类，那么就要
ViewController提供，否则要应用代理提供。

#### 当排除一组ViewController时会发生什么
如果一个ViewController没有恢复识别码，那么这个ViewController和他的子View就不会自动保存状态。没有定义恢复识别码不代表这个View
Controller从视图的层次结构中消失了，只是代表重新启动后以默认的样式来显视。如果ViewController不能自动保存状态，也可以使用ViewController
的引用来手动保存状态。

##### 实现状态保存和恢复的检查表
* 必须实现`application:shouldSaveApplicationState:`和`application:shouldRestoreApplicationState:`方法
* 必须对ViewController提供一个恢复识别码，使用`restorationIdentifier`属性
* 必须使用`application:willFinishLaunchingWithOptions:`显示应用的界面
* 对ViewController提供一个恢复类
* 使用` encodeRestorableStateWithCoder:`和`decodeRestorableStateWithCoder:`方法编码和解码View和ViewController状态
* 使用`application:willEncodeRestorableStateWithCoder:`和`application:didDecodeRestorableStateWithCoder: `怎么不同版本的信息
	或者添加状态信息
* 充当View和ViewController数据源的对象需要实现`UIDataSourceModelAssociation`协议，该协议有助于保留这些类型的视图中选当的和可
	见的项目

##### ViewController保存状态
保存ViewController的状态应该是应用的主要目的。视图控制器定义您的用户界面的结构。他们管理呈现该界面所需的视图，
并协调获取和设置支持这些视图的数据。

* ViewController提供一个恢复识别码
* 提供在启动时创建或查找新ViewController对象的代码
* 实现`encodeRestorableStateWithCoder:`和`decodeRestorableStateWithCoder:`方法编解码状态信息，并且不要重复创建

##### 标记ViewController保存
选择合适的恢复识别码很重要，他决定哪个ViewController使用哪些数据恢复。恢复一个ViewController时，UIKit提供一个恢复地址，这个
恢复地址指向这个ViewController需要恢复的数据。恢复地址是根据恢复识别码和ViewController层次结构拼接得来的。这个恢复地址必须是
唯一的

##### 启动时恢复ViewController
在恢复状态时，UIKit会让应用创建(或查找)ViewController对象，包括保存状态的用户界面。UIKit会遵守下面的流程处理：

* 如果这个ViewController有一个恢复类，那么UIKit会找这个恢复类来提供ViewController。UIKit会调用
	`viewControllerWithRestorationIdentifierPath:coder:`，方法查找ViewController。如果这个方法返回nil，那么表示这个ViewController
	不需要恢复，UIKit将停止查找它。
* 如果这个ViewController没有恢复类，那么UIKit会找应用代理提供这个ViewController。UIKit会调用
	`application:viewControllerWithRestorationIdentifierPath:coder:`，方法查找ViewController。如果这个方法返回nil，UIKit会尝试
	隐式查找ViewController。
* 如果包含正确的恢复地址的ViewController已存在，UIKit会使用它。在启动时创建ViewController（代码或xml），并且设置的恢复码，那么
	UIKit会隐式的查找这个ViewController。
* 如果ViewController是从StoryBoard创建的，则UIKit使用保存的StoryBoard信息来定位和创建它。UIKit把StoryBoard的信息保存到恢复归档
	中。恢复时会查找同样的StoryBoard文件，如果ViewController不存在，则会实例化它。

指定的恢复类，UIKit就不会使用隐式方法查找ViewController。不指定恢复类，那么UIKit会尽力查找ViewController，必要时会使用StoryBoard
创建ViewController.

恢复类需要创建一个ViewController对象，执行一些最小化的初始化。在初始化时指定恢复识别码是一个好习惯，最简单的方法是使用
`identifierComponents`最后一个元素。

对于从MainStoryBoard中创建的ViewController，不需要创建新的ViewController对象，使用
`application:viewControllerWithRestorationIdentifierPath:coder:`让应用代理返回适合的对象，或者让UIKit隐式查找这个对象。

##### 编解码ViewController状态
保存每个对象，UIKit会调用对象的`encodeRestorableStateWithCoder:`方法；恢复时调用对象`decodeRestorableStateWithCoder:`方法。
可以使用这2个方法保存和恢复下面类型的数据：

* 对所显示的任何数据的引用（不是数据本身）
* 对于容器视图控制器，引用其子视图控制器
* 有关当前选择的信息
* 对于具有用户可配置视图的视图控制器，提供关于该视图当前配置的信息

编解码可以是任何值，包括其他的对象。除了View和ViewController外，其他的对象必须实现NSCoding协议来保存状态。对于View
和ViewController会保存恢复识别码，并添加到保存列表中，并调用对象的`encodeRestorableStateWithCoder:`方法

`encodeRestorableStateWithCoder:`和`decodeRestorableStateWithCoder:`方法的实现应该总是调用父类方法。

编码器在编解码处理中不共享，每个对象保存状态都是使用自己的编码器。表示在保存状态时不用关心多个对象状态关键字冲突。
然而需要避免使用UIKit提供的一些特殊键的名称。

* UIApplicationStateRestorationBundleVersionKey，打包版本信息
* UIApplicationStateRestorationUserInterfaceIdiomKey，用户界面使用习惯
* UIStateRestorationViewControllerStoryboardKey，ViewController相关的编码器，表示这个ViewController是从StoryBoard中创建的

#### 保存View的状态
通常View不用保存状态，因为View都是通过ViewController进行配置的，只有当View有自己的用户数据时才需要保存状态。

* 设置`restorationIdentifier`
* 使View的ViewController也包括可用的恢复识别码
* 对于TableView与CollectionView，数据源需要实现`UIDataSourceModelAssociation`协议

#### UIKit View关于保存状态
不管是自定义View，还是标准View，都需要设置恢复识别码。不然不会把View添加到保存列表中。UIKit View有一些状态信息可以保存。

##### 自定义VIew保存状态
`encodeRestorableStateWithCoder:`和`decodeRestorableStateWithCoder:	`方法去保存状态。这些方法只保存不能轻松配置的数据，而且不要
保存ViewController可以轻松设置的数据。

##### 实现友好的保存数据源
只有数据源实现了`UIDataSourceModelAssociation `协议，TableView和CollectionView才会保存当前选择和可见项的状态信息。这个协议可以使
TableView和CollectionView识别包含的内容，而不依赖于该内容的索引路径。因此不管下次启动时数据源是怎么放置项目位置的，视图仍然具有找到
该项目所需的所有信息。

#### 保存应用高等级状态
应用有除ViewController外的其他的数据，可以使用下面的方面来保存
* application:willEncodeRestorableStateWithCoder: 所有保存前调用
* application:didDecodeRestorableStateWithCoder: 所有恢复结束后调用

#### 保存和恢复状态信息的提示
* 总是保存一个状态信息的版本，可以在恢复时判断这个状态信息是否可用
* 不要保存数据模型的对象，用户数据应该保存到本地文件中，或者iCloud
* 使用正确方法来使用ViewController，不然保存系统找不到这个ViewController
* 不一定需要保存所有的ViewController
* 避免在恢复过程中交换ViewController
* 当用户强制退出时，系统会自动删除应用程序的保留状态


### 开发VoIP应用的提示
在iOS8及以后，可以使用Apple Push Notification service(APNs)和PushKit framework创建一个VoIP应用。基于推送实现的VoIP应用，不能保持
一个长连接，或者配置一个socket供VoIP使用。如果是早期版本，需要应用维护一个兼容的实现。

VoIP应用需要正确的配置音频session，因为他不总是使用Audio Session。

实现VoIP的要求：
* 为您的应用程序指定Voice over IP背景模式。 （因为VoIP应用程序涉及音频内容，建议您还启用音频和AirPlay后台模式
	。）在Xcode项目的功能选项卡中启用后台模式
* 使用PushKit API注册以接收VoIP推送通知并处理传入的通知
* 配置您的音频会话以处理转入和转出活动使用
* 为确保在iPhone上获得更好的用户体验，请使用核心电话框架来调整与基于蜂窝电话呼叫相关的行为
* 为了确保您的VoIP应用程序具有良好的性能，请使用系统配置框架来检测网络更改，并尽可能让您的应用程序进入睡眠状态
* 请求VoIP服务证书以允许您的通知服务器连接到VoIP服务

#### 使用可访问性界面改善用户体验
由于VoIP应用程序严重依赖网络，因此应使用系统配置框架的可访问性接口来跟踪网络可用性并相应地调整其行为。
可达性界面允许在网络条件发生变化时通知应用程序。一个VoIP应用可能会在网络不可用时关闭其网络连接，
并在再次变为可用时重新创建它们。该应用程序也可以使用这些类型的变化，以保持用户了解VoIP连接的状态.

要使用可访问性接口，您必须在框架中注册回调函数，并使用它来跟踪更改:

	1. 为目标远程主机创建一个SCNetworkReachabilityRef结构
	2. 为您的结构分配一个回调函数（使用SCNetworkReachabilitySetCallback函数）处理目标的可达性状态
	3. 使用SCNetworkReachabilityScheduleWithRunLoop函数将该目标添加到应用程序的活动运行循环（例如主运行循环)

根据网络的可用性调整应用程序的行为还可以帮助提高基础设备的电池寿命。让系统跟踪网络更改意味着您的应用可以让自己更频繁地进入睡眠状态。

