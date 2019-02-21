---
layout: page
permalink: /technology-home/platform/flutter/user-interface/widget-lifecycle
---

## Widget Lifecycle

### 1. 程序入口
main()函数中调用runApp(Widget)

### 2. Widget构建过程
StatelessWidget - build()

StatefulWidget
- createState() 构建State对象
  State
  - initState() 当State对象构建时调用一次
  - dispose() 当State不再需要时调用一次

### 3. Widget Lifecycle
WidgetsBinding中使用`observer`监听Widget状态改变`didChangeAppLifecycleState()`

    1. 实现WidgetsBindingObserver的didChangeAppLifecycleState方法
    2. 添加监听WidgetsBinding.instance.addObserver(this);
    3. 删除监听WidgetsBinding.instance.removeObserver(this);

* inactive - 应用程序处于非活动状态，并且未接收用户输入。此事件仅适用于iOS
    ，因为在Android上没有可映射的等效事件
* paused - 该应用程序当前对用户不可见，不响应用户输入，并在后台运行
    。这相当于Android中的onPause（）
* resumed - 应用程序可见并响应用户输入。这相当于Android中的onPostResume（）
* suspending - 应用悬挂。这相当于Android中的onStop;它不会在iOS上触发
    ，因为在iOS上没有可映射的等效事件

### 3.1. inactive
以下情况会转换到inactive状态

在iOS上，主视图运行在前台无效状态。当电话进来、响应TouchID请求、进入应用切换或
控制中心、当FlutterAPP使用的UIViewController是用来过渡的。

在Android上，主视图运行在前台无效状态。其他Activity聚焦（如分屏），电话进来，画
中画应用，系统Dialog，或者其他Window。

处于这种状态的应用，假定可以在任何时间进入`paused`

### 3.2. paused
应用不显示给用户，不响应用户输入，在后台运行

当应用在这个状态时，engine不会回调`Window.onBeginFrame`和`Window.onDrawFrame`

Android应用在这个状态，假定可以在任何时间进入`suspending`

### 3.3. resumed
应用显示和响应用户

### 3.4. suspending
应用程序悬挂

当应用在这个状态时，engine不会回调`Window.onBeginFrame`和`Window.onDrawFrame`

在iOS上，这个状态当前不使用
