---
layout: post
title: Flutter dart:ffi
categories: flutter
tags: [flutter]
date: 2022-07-19
---

## Flutter dart:ffi

### 动态与静态链接

> 本地库可以有动态链接与静态链接, 一个静态库会嵌入到APP执行映像中, 随应用一起启动
> 静态链接调用`DynamicLibrary.executable` 和 `DynamicLibrary.process`

> 动态链接库是单独文件放在应用中, 在需要时加载. 动态库是`.so(ELF)`分发, 每个架构一个
> 动态链接调用`DynamicLibrary.open`

### C/C++注意事项

1. dart:ffi 只能绑定C语言的符号, 所以C++需要加上
    extern "C" __attribute__((visibility("default"))) __attribute__((used))

2. C/C++源码建议写在ios/Classes/native\_add.cpp目录, 因为`CocoaPods`不允许源码在  
    `.podspec`上层目录, 而`gradle`允许

### ffigen 

> 通过c/c++头文件生成ffi绑定文件, ffigen.yaml为配置文件

    flutter pub run ffigen --config ffigen.yaml

> ffigen依赖llvm的`libclang.(dylib, so)`库, 需要在ffigen.yaml指定`llvm-path`字段

    * Install XCode 
    * Install brew install llvm

### Function 

dart to native:
    1. 定义native function type
    typedef DartCallbackType = Int32 Function(Int32 type, Pointer<Void> arg);

    2. 定义dart function
    int callback (int type, Pointer<Void> arg);

    3. 获取Pointer<NativeFunction>
    Pointer.fromFunction<DartCallbackType>(callback, 1);

> fromFunction函数第二个参数需要传个`exceptionalReturn`, 当callback调用异常时返回, 
> 需要传入常量.

### String 

dart to native: 
    1. import 'package:ffi/ffi.dart';
    2. "abc".toNativeUtf8().cast<Int8>();

### 异步调用

> 如果C语言函数很耗时, 可以创建新的`isolate`调用C语言
> 如果C语言使用线程, 那么不能直接调用Dart回调, 并且需要注意[内存溢出](https://stackoverflow.com/questions/65750426/flutter-async-call-of-native-c-code-from-dart-via-ffi-cause-memory-leak)



[[vm/ffi] Support asynchronous callbacks](https://github.com/dart-lang/sdk/issues/37022)  
[How to use async callback between C++ and Dart with FFI?](https://github.com/flutter/flutter/issues/63255)  

## Reference
[Supported platforms](https://docs.flutter.dev/development/tools/sdk/release-notes/supported-platforms)  
[C interop using dart:ffi](https://dart.dev/guides/libraries/c-interop)  
[Binding to native code using dart:ffi](https://flutter.dev/docs/development/platform-integration/c-interop)
[Dart/Flutter ffi (Foreig Function Interface) native callbacks eg: sqlite3_exec](https://stackoverflow.com/questions/61541354/dart-flutter-ffi-foreig-function-interface-native-callbacks-eg-sqlite3-exec)
[Dart FFI: managing natively allocated memory](https://groups.google.com/a/dartlang.org/g/misc/c/-w0zIbk8YhM)  
[Building a Flutter Computer Vision App Using Dart:ffi, OpenCV, and Tensorflow (Part 2)](https://levelup.gitconnected.com/building-a-flutter-computer-vision-app-using-dart-ffi-opencv-and-tensorflow-part-2-81472b4ac380)  
[Calling Native Libraries in Flutter with Dart FFI](https://www.raywenderlich.com/21512310-calling-native-libraries-in-flutter-with-dart-ffi)  
[Flutter FFI 内存管理](https://blog.csdn.net/eieihihi/article/details/119600283)
[How to build a Flutter app with C/C++ libraries via FFI on Android and iOS including OpenCV, Libsodium, Cmocka and Eigen](https://medium.com/@khaifunglim97/how-to-build-a-flutter-app-with-c-c-libraries-via-ffi-on-android-and-ios-including-opencv-1e2124e85019)  
[dart-lang/ffigen](https://github.com/dart-lang/ffigen)  
