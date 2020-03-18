---
layout: post
title: "Flutter async"
categories: flutter
tags: [flutter]
date: 2020-03-17
excerpt: "Flutter async"
---

## Flutter async

### Future
Future有三种关闭, uncompleted, completed with data, completed with error. 
Future简化了Event Loop, 使得代码不用涉及到事件循环. Event Loop会自动解析Future, 然后分为多个事件加入队列.
只用负责得到一个Future并且设置将来Future成功后或者失败后处理的代码.

Future() - 接收一个函数, 该函数异步执行, 返回一个与函数返回类型一样的Future
Future.value() - 已经有正确结果了
Future.error() - 已经有错误结果了
Future.delayed() - 运行函数前, 需要等待一定时间

Futurn.then() - 正确结果调用
Future.catchError() - 错误结果调用
Future.whenComplete() - 不管什么结果都会调用

FutureBuilder根据未来数据来更新Widget, 其中的future指定一个未来, build指定有结果时怎么构建Widget. build中snapshot参数
用来判断是有正确结果, 还是错误结果

### Stream
Stream是reactive programming. Future是未来返回一个值, 而Stream是未来有一组值, 一般用来处理I/O. Stream会结合时钟和网络事件, Dart
会把数据块回到对应的Stream中, 并且通过listen()函数调用客户代码.

Stream会保持自己的值, 直到有一个listen()来订阅处理, 有且只有一个listen(). 可以使用`asBroadcastStream()`函数把单订阅stream制作成
广播式的流, 这时允许多个订阅, 但是Stream值产生后如果没订阅接收, 将被丢弃.

listen()函数有多个参数:
    1. onData - 数据产生时调用, 必填参数
    2. onError - 生成数据产生错误时调用, 可以用来捕获异常
    3. cancelOnError - 生成数据产生错误时是否终止, 默认true
    4. onDone - Stream读完时调用

listen()函数会返回一个StreamSubscription对象, 可以用来控制Stream:
    1. subscription.pause(); 暂停
    2. subscription.resume(); 重新开始
    3. subscription.cancel(); 关闭

使用和操作流:

    1. map() 映射成新的值, 一对一
    NumberCreator().stream
    .map((i) => 'String $i')
    .listen(print);

    2. where() 过滤数据流
    NumberCreator().stream
    .where((i) => i % 2 == 0)
    .map((i) => 'String $i')
    .listen(print);

    3. distinct() 过滤相同的数据
    myReduxStore.onChange
    .map((s) => MyViewModel(s))
    .distinct()
    .listen( /* update UI */ );

async包有一些其他的Stream功能, 比如合并两个流
stream_transform包对基础功能的扩展

使用StreamController来创建一个Stream
StreamBuilder 跟FutureBuilder一样, 但是是周期性的构建Widget

### Timer
Timer.periodic - 周期性的调用

    Timer.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(_count);
      _count++;
    });

### Zone
runZone()

1. 处理异步执行代码中引发的错误
2. 存储本地变量
3. 覆盖基本功能

基本功能:
* Forking child zones
* Registering and running callbacks in the zone
* Scheduling microtasks and timers
* Handling uncaught asynchronous errors (onError is a shortcut for this)
* Printing

### Reference
[Dart asynchronous programming: Futures](https://medium.com/dartlang/dart-asynchronous-programming-futures-96937f831137)
[async](https://pub.flutter-io.cn/packages/async)
[stream_transform](https://pub.flutter-io.cn/packages/stream_transform)
[Zone](https://dart.dev/articles/archive/zones#example-overriding-print)
