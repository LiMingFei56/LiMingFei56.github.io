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
