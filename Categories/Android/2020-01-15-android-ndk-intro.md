---
layout: post
title: "NDK介绍"
categories: android
tags: [ndk]
date: 2020-01-15
excerpt: "NDK介绍"
---

## NDK介绍
Native Development Kit(NDK) 使用CMake或ndk-build构建出在Android设备上运行的C\C++库

* 使用POSIX可以实现代码跨平台(ios 和 android, flutter不支持posix)
* 重用已有的库
* 提高计算密集型应用性能, 如游戏

ndk-build: 使用Android.mk, Application.mk两个文件构建
cmake: 使用CMakeLists.txt文件


### 主要组件

* Native shared libraries
* Native static libraries
* Java Native Interface (JNI)
* Application Binary Interface (ABI): Support 32-bit ARM, AArch64, x86, and x86-64
* Manifest: 如果只有本地代码的Android Project, 那么需要定义一个
  `NativeActivity`在`AndroidMinifast.xml`

* Android.mk: 编译在jni目录下的代码
* Application.mk: 指定ABI, toolchain: clang, mode(debug/release), STL
* gradle: 链接Java与本地库
* NativeActivity: 实现完全的本地代码应用, 主要负责连接Android framework和本地代码
* NDK API: 可以使用JNI来调用Android Framework API, 传感器, 输入事件可以使用NDK API

### NativeActivity
[NativeActivity](https://developer.android.google.cn/ndk/reference/group/native-activity#group___native_activity_1ga8abd07923f37feb1ce724d139cc2609d)
使用`native_activity.h`, 他包含回调接口和数据结构, 运行在主线程里
使用`android_native_app_glue.h`, `native_activity.h`帮助程序库, 运行在单独线程里

配置AndroidMinifast.xml:

    <application android:label="@string/app_name" android:hasCode="false">
    <activity android:name="android.app.NativeActivity"
              android:label="@string/app_name">
      <meta-data android:name="android.app.lib_name"
            android:value="native-activity" />
      <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
      </intent-filter>
    </activity>

meta-data: 指定共享库的名称, 省略lib和.so

### 建议
* Java层与本地层传输数据量尽量小, 传输频率尽量小, 使用一个接口
* 减少Java层与本地层的异步通信, 可以Java启两个线程, 一个阻塞本地代码, 并与另一个
  通信
* 如果Java和本地层都必须有线程池, 请保持线程池所有者之间的通信
* 将接口代码放在代码量小的地方
