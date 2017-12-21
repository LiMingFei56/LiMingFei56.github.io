---
layout: page
permalink: /ios/guide/detail/inter-app-communication
---

Inter-app Comunication

应用只能间接的跟设备上的其他应用。

* 使用AirDrop共享文件和数据给其他应用
* URL scheme，让其他应用发送信息给你

### 支持AirDrop
AirDrop可以共享图片，文档，URLs，和其他类型的数据到附近的设备上。AirDrop的优点是点
对点的网络连接找到附近的设备并连接他们。

#### 发送文件和数据到其他应用
使用AirDrop发送文件和数据，需要使用UIActivityViewController对象在用户界面中显示一个活动片段。
当创建这个ViewController，需要指定一个想要分享的数据对象。ViewController只显示Activity支持的对象。
对于AirDrop，可以指定图片、Strings、URLs和几种其他的数据类型。也可以指定实现`UIActivityItemSource`协议的自定义类型。

ActivityViewController会根据显示的对象类型决定显示什么样的Activity sheet。不用显示的指定AirDrop Activity。
可以使用`excludedActivityTypes`属性来避免使用特定的类型，当在IPad上显示ActivityViewController，必须使用这个属性。

#### 接收文件和数据
接收从AirDrop发送来的数据：
* 在Xcode中，声明应用支持的文档类型，iOS会判断应用是否可以打开这个文件
* 应用代理中，实现`application:openURL:sourceApplication:annotation:`方法，使用这个方法接收数据。

如果应用在前台，那么上面的方法会被调用。如果应用在后台，保存这个文件的地址，在下次启动时打开。因为
AirDrop传输文件使用保护文件，除非设备当前处于解锁状态，否则无法打开文件。

应用有权限读取和删除共享文件，但是没有权限写文件。如果需要修改这个文件，则必须先将其移出当前位置。建议
移出后删除原始版本。

### 使用URL Scheme连接其他应用
URL Scheme会使其他的app调用自己的应该。必须定义一个支持的Scheme，并且处理URLs请示。

#### 发送一个URL给其他应用
使用`openURL`方法发送一个URL Scheme。

#### 注册自定义URL Schemes
在Info.plist中配置`CFBundleURLTypes`。这个项是一个把含字典的数据，每个元素是一个URLs。
每个字典包含下面2个key。

* CFBundleURLName - 配置自定义URL
* CFBundleURLSchemes - 配置Shceme名称数组:如http,mailto,tel,sms.

如果多个应用定义一样的URL scheme，那么还没有定义将打开哪个应用处理这个scheme

#### 处理URL Requests
URLs请求会发送到应用代理，接收请示需要实现下面的方法：

* `application:willFinishLaunchingWithOptions:` 和 `application:didFinishLaunchingWithOptions:`方法检索
	URL并且判断是否打开。如果返回NO，那么URL处理的代码不会调用
* `application:openURL:sourceApplication:annotation:` 打开这个文件`application:handleOpenURL:`处理URL。也要返回YES

如果URL请求时，应用没有运行，那么系统会启动应用并且把应用移动到前台。

*启动应用处理URL*
![启动应用处理URL](/assets/ios/ios-guide-url-launch.png)

如果URL请示时，应用是background或者suspended，系统会把应用移动到前台打开URL。系统会调用应用代理的
`application:openURL:sourceApplication:annotation:`方法检查和打开URL

注：应用声明不同自定义URLs时，可以设置不同的启动图像。

URLs是通过NSURL对象实现的，遵守RFC 1808协议

#### 显示一个自定义的启动图片在打开URL时
当系统使用URLs启动应用时，如果没有相应快照，就会使用自定义URLs启动图像显示。配置一个URLs启动图像，需要定义一个以下
面约定命名的图像：

	<basename>-<url_scheme><other_modifiers>.png

basename: 是Info.plist中`UILaunchImageFile`属性定义的，如果没有指定默认为`Default`
url_scheme: 是URLs方案名称
other_modifiers: 指定分辨率或其他

Default-myapp@2x.png
Default-myapp.png
