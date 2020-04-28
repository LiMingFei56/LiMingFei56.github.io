---
layout: post
title: "Flutter 日志"
categories: flutter
tags: [log]
date: 2020-03-16
excerpt: "Flutter 日志"
---

## Flutter 日志
Flutter异常分为VM异常和Dart异常：
    Dart异常： 出错不会导致崩溃， 一般会导致代码不继承执行（没有任何反应），如果是界面错误会导致跳转ErrorWidget
    VM异常：会导致程序崩溃，跳出

Dart异常分为同步异常和异步异常：
    同步异常：可以使用try-catch捕获
    异步异常：使用try-catch捕获不到

Flutter日志输出，看print函数会发现，如果设置了Zone会调用`printToZone`， 如果没有会调用`printToConsole()`.
Flutter中Zone, 是一个封闭区域，为了让异步
调用之间保持稳定，代码总在当前区域的上下文中执行。主要用来处理print, timers, microtasks or how uncaught errors are handled.
runZone创建子Zone, Zone.current获取当前Zone, Zone.root获取根Zone.

收集VM异常：

    FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details); // 交给控制台处理
        // Zone.current.handleUncaughtError(details.exception, details.stack); 交给Zone的未捕获异常处理
    };

Zone：

    runZoned(() {
        // 运行任务
        runApp(MyApp());
    },
    // 获取打印信息
    zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, line);
    // 获取未捕获异常 等同于runZoned参数onError
    }, handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
             Object error, StackTrace stackTrace) {
    }));

### Reference
[Zone](https://api.flutter.dev/flutter/dart-async/Zone-class.html)
