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



