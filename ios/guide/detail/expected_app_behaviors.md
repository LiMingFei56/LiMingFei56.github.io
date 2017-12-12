---
layout: page
permalink: /ios/guide/detail/expected-app-behaviors
---

Expected App Behaviors

应用程序提交到App Store前，需要提供一个自定义信息，确保给用户好的用户体验。自定义
信息从提供一个应用Icon到应用怎么呈现用户信息的系统级决策。本章描述了所有应用程序
预期要处理的行为，并且应该在规划过程中尽早考虑。

### 提供必要的资源

	* An information property-list file: Info.plist文件包含提供给系统的
		一些元数据。

	* A declaration of the app's required capabilities: 所有的App必需声明硬件的功能
		或者特性。App Store会根据这些信息确定哪些设置可以运行这个App。Info.plist文件
		中定义。

	* One or more icons: 系统设备在主页，设置中，搜索中显示App的Icon。
	
	* One or more launch image:	在打开App时显示的临时图片。

### App程序包
当build iOS应用时，Xcode会把项目捆绑成一个程序包。程序包是一个目录，会将执行文件
和资源（Icon,image等）集中在一起。

A typical app bundle

File     | Example   | Description
---------|-----------|--------------------------------
App executable | MyApp  | 可执行文件包含编译的代码。名字为应用名减去.app后缀，这个文件是必须的
The information property list file | Info.plist | 应用信息文件，这个文件必须叫Info.plist
App icons | Icon.png | 一般在设备主屏幕显示，其他的分辨率显示在合适的地方，@2x显示带有Retina显示器
Launch images | Default.png | 在启动应用时显示
Storyboard file(or nib files) | MainBoard.storyboard | 包括View和ViewController，用来显示内容，也可以使用Segues通过Identify实现2个Scene间的跳转。可以在Info.plist中修改主Storyboard，UIMainStoryboardFile(nib file使用NSMainNibFile)
Ad hoc distribution icon | iTunesArtwork | 当ad hoc distribution时应该提供一张512x512大小的app icon。文件时为iTunesArtwork。
Settings bundle | Settings.bundle | 如果想让用户可以配置应用的信息的话，App需要包含一下Setting bundle。这个包包含一个属性列表和其他的源文件。
Noniocalizend resource files | sun.png,mydata.plist | 非本地化资源，图片，声音等。所有这些文件需要放在应用包的顶层。
Subdirectories for localized resources | en.lproj,fr.lproj,es.lproj | 本地化文件必须放在指定的目录中，这个目录名包含ISO 639-1语言名和.lproj后缀。

### The Information Property List File
Info.plist文件包含很重要的应用配置信息，App Store使用这个文件来确定应用的功能和定位。
其中大多数属性项不常用，但是在定义新项时，应该考虑一些关键项：

	* 定义应用需要的功能，App Store使用这些信息来确定应用支持哪些设备。
	* 应用需要WIFI持续连接，UIRequiresPersistentWIFI设置为true。防止iOS处理长时间非
		活动状态时关闭WIFI连接。
	* Newsstand应用需要声明为UINewsstandAPP
	* 定义自定义的文档类型需要声明这些类型，使用这些文件类型，需要提供icons和UTI信息。
		告诉系统怎么显示和处理这些信息。
	* 定义自定义的URL schemes，URL schemes可以在应用间通信。
	* 应用需要提供访问用户数据或者功能的用法说明，告诉用户为什么会使用到这些。

### 定义设置功能
所有APP需要定义具体的设备功能，来保证运行。Info.plist文件中UIRequiredDeviceCapabilities属性来定义功能。
该属性的值是一个数组或者字典，用来标识应用程序需要的功能（或者特别禁止）。

	* 数组: 配置的功能为必需的，没有配置的功能为不是必需的。
	* 字典: 键为功能，值为boolean。true为这个功能必需，false为这个功能不能存在。没有配置的功能为不是必需的。

### 应用Icons
所有应用必需提供几种不同分辨率的ICONS，在不同情况下显示。项目里已经包含Asset appIcon项，
分配图片文件后，build时，Xcode会添加适合的keys到Info.plist中，并且把图片放置到包内。

### 应用Launch(Default)图片
当用户启动应用时，系统会临时显示一个静态图片。这个图片就是Launch Image，Asset defaultPhoto中设置。
Lanunch Images提供一个即时反馈给用户，告诉用户应用正在加载。当应用window配置和准备完成，可以显示了，
系统会把Lanunch Images替换成应用window。

当应用从前台到后台，系统会捕获一个应用快照。当应用最近的快照可用时，系统会倾向于使用快
照来当Lanunch Images。如果应用被杀死或者太长时候没用，那么快照将不可用，系统还是会使用
Lanunch Images来启动。

### 支持用户隐私
定义用户隐私很重要，大多数iOS设备包含个人数据，用户不像公开的。如果访问用户数据不适当，那么用户
可能会删除应用。

需要在用户根据适用法律获得知情同意的情况下访问用户或设备数据，并且应采取适当措施来
保护用户和设备数据，并对使用方式保持透明。以下是可以采取的一些最佳做法：

	* 政府和行业来源的指导方针，应该与法律顾问审核这些文件。
	* 请示访问敏感的用户和设备数据，应用需要提供使用说明（在Info.plist文件中声明）
		，说明为什么用到这些数据。受iOS系统授权设置保护的数据包括位置，联系人，日历事件
		，提醒，照片，媒体以及其他许多类型。在用户不授予访问请示的数据的情况下，应提供合理
		的回退行为。
	* 让用户了解他们的数据将如何使用。如在App Store中说明隐私政策。在APP中也应该详细说明。
	* 让用户控制他们的用户或设备数据。提供设备，以便用户可以根据需要禁止访问某些类型的敏感信息。
	* 请示并使用完成给定任务所需的最小数量的用户和设备数据。
	* 采取合理措施保护应用中收集的用户和设备数据。安全的存储和传输。
	* 如果应用使用ASIdentifierManagaer类，那么需要遵守advertisingTrackingEnable属性。如果这个
		属性设备为no,那么ASIdentifierManager类只能实现有限的广告用途。“有限广告用途”指广告支
		持API的文档中可能允许的频率上限，归因，转化事件，估计唯一用户数量，广告欺诈检测
		，仅用于广告目的的调试以及其他广告使用。
	* 不能使用UIDevice uniqueIdentifyer属性，而是使用UIDevice advertisingIdentifier属性和ASIdentifierManager。
	* 如果应用提供音频录制，请在需要的时候再打开录制会话。因为在打开录制会话时，系统会提供给用户选项，选择允许和拒绝。

当应用访问受保护的数据时，系统会展示应用在Info.plist中定义的使用说明来提示用户，是否授权。如果应用没有提供使用说明，那么
应用会退出。

iOS框架提供检查和请示授权API，每次执行需要授权的任务时，都要检查一个授权，因为用户可以手动配置权限。

受系统授权设置保护的数据和资源
![受系统授权设置保护的数据和资](/assets/ios/ios-guide-authorization.png)

### 国际化应用
iOS应用是分发到很多国家，用户会喜欢是用本地语言的应用，所以国际化会覆盖更多的用户。
国际化应用需要提取出特定的资源，把资源放到特别的语言目录下(.lproj)目录。

	* Storyboard(nib文件)，布局显示的label，或者根据不同的语言调整布局大小
	* String文件（.string文件），静态的字符串文件。
	* Image文件
	* 视频和音频文件

