---
layout: post
title: "FLutter 发布配置"
categories: flutter
tags: [flutter]
date: 2020-04-27
---

## FLutter 发布配置

> 发布前需要修改应用的基本信息, `应用名`, `应用ID`, `应用Icon`, `应用启动页`, 
> `应用版本名`, `应用版本编号`

> 其中应用Icon和应用启动页需要单独配置(iOS在Xcode中, android在AndroidManifast中)
> 应用启动页也可以使用`flutter_launcher_icons`插件来生成

### iOS

#### 1. 应用名称 
    
> Xcode 中`Display Name` 为`Runner`, 这里不能修改, 会导致Flutter工具使用失常.
> 直接修改Info.plist中`CFBundleName`字段

#### 2. 应用ID

> Xcode Bundle Identifier字段修改

#### 3. 版本名称和版本号

> Xcdoe中可以修改, 但是不建议在这修改, 在Flutter中修改可以统一管理.
> Info.plist 中 保证如下配置, 然后在pubspec.yaml中设置.

    <key>CFBundleShortVersionString</key> <string>$(FLUTTER_BUILD_NAME)</string>
    <key>CFBundleVersion</key> <string>$(FLUTTER_BUILD_NUMBER)</string>

