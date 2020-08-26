---
layout: post
title: "Flutter 调用 C/C++"
categories: flutter
tags: [native]
date: 2020-08-26
excerpt: "Flutter 调用 C/C++"
---

## Flutter 调用 C/C++

### 1. C/C++注意事项

1. dart:ffi 只能绑定C语言的符号, 所以C++需要加上
    extern "C" __attribute__((visibility("default"))) __attribute__((used))

2. C/C++源码建议写在ios/Classes/native\_add.cpp目录, 因为`CocoaPods`不允许源码在  
    上层目录, 而`gradle`允许


### Reference
[Binding to native code using dart:ffi](https://flutter.dev/docs/development/platform-integration/c-interop)
[Dart/Flutter ffi (Foreig Function Interface) native callbacks eg: sqlite3_exec](https://stackoverflow.com/questions/61541354/dart-flutter-ffi-foreig-function-interface-native-callbacks-eg-sqlite3-exec)
