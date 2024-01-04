---
layout: post
title: Flutter Plugins
categories: flutter
tags: [flutter]
date: 2022-07-19
---

## Flutter Plugins

### 插件类别

* Dart packages - dart包, dart通用实现, 主要还是flutter平台上dart编写的库
* Plugin packages(Federated plugins) - dart调用本地平台代码, 包含特定平台的实现, 每个平台放一个包里
* FFI Plugin packages - dart调用本地库代码, c/c++

### Dart Packages

    flutter create --template=package hello

### Plugin Packages 

    flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows hello

### FFI Plugin Packages

    flutter create --org com.example --template=plugin_ffi --platforms=android,ios,linux,macos,windows hello



### Collect

+ [menu_button](https://pub.dev/packages/menu_button)

## Reference
[Developing packages & plugins](https://docs.flutter.dev/development/packages-and-plugins/developing-packages)  
[Writing a good Flutter plugin](https://medium.com/flutter/writing-a-good-flutter-plugin-1a561b986c9c)  
[Writing custom platform-specific code](https://docs.flutter.dev/development/platform-integration/platform-channels?tab=type-mappings-java-tab)  
