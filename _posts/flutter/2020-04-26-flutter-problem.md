---
layout: post
title: "Flutter error"
categories: flutter
tags: [flutter]
date: 2020-04-26
---

## Flutter error

> vscode 的flutter 插件大多是使用`bash shell`, 开发环境最好使用bash, 不能会有未知问题.
> 导致vscode中flutter命令一直执行, 不会结束, 或者执行错误.

### 1. Failed to register bundle identifier. The app identifier "com.example.\*" cannot be registered to your development team because it is not available. Change your bundle identifier to aunique string to try again. (in target 'Runner' from project 'Runner')

> 应用ID不合法, 需要换一个有意义的Bundle Identifier
### 2. error: module importing failed: invalid pathname dyld: Library not loaded: @rpath/Flutter.framework/Flutter
> 使用个人签名运行在iOS13.3.1真机时出现

    1. 运行在13.3.1以下的系统的真机
    2. 换开发者证书
    3. 使用模拟器

### 3. Error: Building for iOS Simulator, but the linked and embedded framework 'App.framework' was built for iOS(or iOS Simulator)

> XCode升级造成这个错误, 原因是App.framework适用与真机设备, 不适用与模拟器.
> 需要删除App.framework后, 编译重新生成.
> 不管是模拟器切换成真机运行, 还是真机切换成模拟器运行, 都需要删除后重新生成.

    rm -rf ios/Flutter/App.framework/
    flutter run

### 4. \* iPhone has denied the launch request. Internal launch error: process launch failed: failed to get the task for precess \*

> 不能跟踪Debug

    1. xcode 中配置启动Scheme
    2. 取消Debug executable

### 5. device crashes on startup: code signature invalid for "path/to/Flutter.framework/Flutter"

> 同问题2, 在ios 13.4 beta3 修复

### 6. error: module importing failed: invalid pathname

> Xcode 11.4.1 Swift 5.2.2 时报错, 不管编译Flutter 还是 iOS, 甚至直接运行Swift, 
> 都会出现这个错误, 不清楚什么原因, 不影响使用.

### 7. Exception: Could not instantiate image codec

> 图片解析失败, 一般为不支持图片格式, 或者下载文件不全. 我这里是因为解压ipa包后
> 获得App切图, 在Finder中可以查看, 而放到Flutter中和使用GIMP中就打不开.
>
> 这是因为Xcode打包图片资源会使用`pngcrush`工具对图片资源进行优化, 解压ipa图片资
> 源不能支持使用, 需要还原原来格式.

### 8. Flutter Engine crashes due to 'Failed to setup Skia Gr context

flutter 在 android 4.1 4.2 上运行报错`Failed to setup Skia Gr context`

[Engine crashes due to 'Failed to setup Skia Gr context' #51447](https://github.com/flutter/flutter/issues/51447)

flutter开发者说: 有可能是ARM skia运行在x86平台上导致的.

临时解决方案: futtler run `--enable-software-rendering`

### 9. error: Unexpected duplicate tasks: 1) Target 'flutter_dong_scan' (project 'Pods') has copy command from

[Build Fails](https://github.com/AmolGangadhare/flutter_barcode_scanner/issues/37)  

### 10. 无法访问maven.google.com

	flutter\packages\flutter_tools\lib\src\http_host_validator.dart
	将https://maven.google.com/ 修改为https://dl.google.com/dl/android/maven2/
	删除flutter/bin/cache目录

### 11. 无法访问google.bintray.com

    [compile error, bad gateway](https://github.com/flutter/flutter/issues/94400)  

    build.gradle中
    注释jcenter()
    添加mavenCentral()

    插件中也需要这么修改, 或者更新插件到最新版本.
    project/.dart-tool/package_config.json 

### 12. flutter import Error: Error when reading '../../../../development/flutter/

    project/.dart-tool/package_config.json中配置了插件的路径
    一般是丢失了插件路径, 重新配置插件
    flutter clean
    flutter pub cache clean
    flutter pub get

    

### Reference
