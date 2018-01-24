---
layout: page
permalink: /program-language/objective-c/environment
---

Environment

### Introduct

Objective-C是面向对象的语言，是把Smalltalk-style添加到C语言中实现的。

程序入口和C语言一样是`main`函数。

#### 语言类型
Objective-C是一个静态语言类型

#### Foundation Framework
Foundation Framework提供了大量的特性

* 包含扩展的数据类型，如NSArray，NSDictionary，NSSet等
* 它由一组丰富的操作文件，字符串等的函数组成
* 它提供了URL处理，日期格式化，数据处理，错误处理等功能

### Environment
可以使用GCC和Clang来编译Objective-C，推荐使用Clang编译

Xcode自带有Clang，Xcode5后去掉了GCC，GCC只是Clang别名

#### Linux

1. 安装gcc和gcc Objective-C包：

	[root@localhost ~]# yum install gcc
	[root@localhost ~]# yum install gcc-objc

2. 安装依赖包：

	[root@localhost ~]# yum install make libpng libpng-devel libtiff libtiff-devel libobjc libxml2 libxml2-devel \
	libX11-devel libXt-devel libjpeg libjpeg-devel

3. 为了支持完整的Objective-C特性, 需要安装GNUStep组件

	GNUstep: http://www.gnu.org/software/gnustep/information/aboutGNUstep.html

	[root@localhost ~]# cd ~
	[root@localhost ~]# tar xzvf gnustep-startup-0.32.0.tar.gz
	[root@localhost ~]# cd gnustep-startup-0.32.0/
	[root@localhost ~]# ./InstallGNUstep
	[root@localhost ~]# echo '. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh' >> /etc/profile
	[root@localhost ~]# source /etc/profile

	gcc `gnustep-config --objc-flags` -L/usr/GNUstep/Local/Library/Libraries -lgnustep-base helloWorld.m -o helloWorld
#### MacOS
在MacOS上安装Xcode就行

clang -fobjc-arc <source.m> -o <target>

#### Windows
需要安装MinGW和GUNStep2个应用

http://www.gnu.org/software/gnustep/windows/installer.html

	gcc `gnustep-config --objc-flags` -L/usr/GNUstep/Local/Library/Libraries -lgnustep-base helloWorld.m -o helloWorld

### Clang

    clang -fobjc-arc -framework Foundation literal.m
