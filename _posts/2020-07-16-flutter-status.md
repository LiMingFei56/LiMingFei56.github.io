---
layout: post
title: "Flutter 状态"
categories: flutter
tags: [flutter]
date: 2020-07-16
---

## Flutter 状态

### Flutter 生命周期

#### 1. 本地平台生命周期
    
    // 注册监听
    WidgetsBinding.instance.addObserver(WidgetsBindingObserver);

//监听本地应用生命周期
WidgetsBindingObserver.didChangeAppLifecycleState(AppLifecycleState state)

WidgetsBindingObserver中还包含其他与本地平台状态有关的回调

#### 2. Widget State 生命周期

initState()
didChangeDependencies()
build()
render tree
didUpdateWidget()
build()

deactivate()
dispose()

#### 3. 页面帧回调

SchedulerBinding 实现

// 单次Frame绘制回调, 回调后该回调方法会删除
WidgetsBinding.instance.addPostFrameCallback

// 实时Frame绘制回调
WidgetsBinding.instance.addPersistentFrameCallback

#### 4. 页面监听

// 当前页面弹出
WidgetsBindingObserver.didPopRoute 

// 有新的页面出来
WidgetsBindingObserver.didPushRoute

    // 监听当前页面 换入 换出
    RouteObserver
    RouteAware  

    final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
    MaterialApp.navigatorObservers: [routeObserver]

    Page whit RouteAware
    routeObserver.subscribe(this, ModalRoute.of(context));
    routeObserver.unsubscribe(this);


### Reference
[WidgetsBinding mixin](https://api.flutter.dev/flutter/widgets/WidgetsBinding-mixin.html)
[SchedulerBinding mixin](https://api.flutter.dev/flutter/scheduler/SchedulerBinding-mixin.html)
[WidgetsBindingObserver class](https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html)

[RouteObserver<R extends Route> class](https://api.flutter.dev/flutter/widgets/RouteObserver-class.html)
[RouteAware class](https://api.flutter.dev/flutter/widgets/RouteAware-class.html)

[State<T extends StatefulWidget> class](https://api.flutter.dev/flutter/widgets/State-class.html)
