---
layout: post
title: "Dart 原理"
categories: flutter
tags: [intro]
date: 2020-03-16
excerpt: "Dart 原理"
---

## Dart 原理

### Dart 介绍
Dart是单线程模式，所以当前任务需要快速执行，不然会使后面的任务阻塞。虽然是单线程模式，但是Dart还是支持Futures、Streams、
Background Work等等异步方法。

一般其他的语言是使用多线程模式，可以很方便的共享内存、充分利用系统资源、使用高效的调度算法等等。但是这样会导致程序逻辑复杂，
容易出错，并且因为共享内存，一个线程出错是致命的，会导致程序结果错误或者进程崩溃。

Dart是单线程模式，事件从microtask queue和event queue中获取。事件之间使用Isolates分隔内存，同步或异步执行时出错使用Zone分隔。
所以当事件执行中抛出异常，不会导致Dart进程崩溃。事件开始执行后，不能中断直到执行结束。

### Event loop
![both-queue](../assets/flutter/both-queues.png)

Event loop用来管理Dart事件执行。当Dart应用执行后，会初始化两个队列：microtask queue和event queue。如上图，应用会先执行main()函数，
再执行Event loop, Event loop优先执行microtask queue, microtask队列为空后，再执行event queue第一项， 并且再判断microtask queue。

microtask是非常短的异步任务，是由dart内部代码产生或者使用Future.microtask或者使用scheduleMicrotask函数
, 使用isolates隔离并且排序放到microtask queue。

event是由外部产生的，如I/O, 鼠标，手势，绘图，计时器，消息等使用isolates隔离并且排序放到Event queue。可以使用Future来
添加一个event。

### Isolates
所有的dart代码都在Isolates中运行, Isolates包括自己的独立内存和Event Loop, 一个线程一个Isolates, 所以Dart中线程是隔离开的. Dart应用
程序一般在单个Isolates中运行所有代码, 如果有必要可以使用Isolate.spawn() or Flutter’s compute()来创建新的Isolates(一般有大量的耗时任务时创建).
两个Isolates间通信使用messages.

### Async
Dart单线程模式是怎么实现异步的呢?

Dart是分析Future, Stream, async, await来拆解事件, 然后使用isolates隔离并且排序依次放到对应的队列中. 如:

    RaisedButton( // (1)
        child: Text('Click me'),
        onPressed: () { // (2)
            final myFuture = http.get('https://example.com');
            myFuture.then((response) { // (3)
            if (response.statusCode == 200) {
                print('Success!');
            }
            });
        },
        )

(1): 绘制一个按钮A, 并等待触发                                  初始化构建
(2): 用户点击A, 按钮A消耗这个点击, 生成onPressed()调用           点击事件
    1. 调用http.get(), 得到一个Futurn                          网络请求调用
    2. 设置future.then, 结果完成时触发                          设置网络请求响应回调
(3): http.get完成, 触发then                                    网络请求响应回调

You should now understand Dart’s event loops and how to schedule tasks. Here are some of the major concepts of event loops in Dart:

* A Dart app’s event loop executes tasks from two queues: the event queue and the microtask queue.
* The event queue has entries from both Dart (futures, timers, isolate messages, and so on) and the system (user actions, I/O, and so on).
* Currently, the microtask queue has entries only from Dart, but we expect it to be merged with the browser microtask queue.
* The event loop empties the microtask queue before dequeuing and handling the next item on the event queue.
* Once both queues are empty, the app has completed its work and (depending on its embedder) can exit.
* The main() function and all items from the microtask and event queues run on the Dart app’s main isolate.
* When you schedule a task, follow these rules:

If possible, put it on the event queue (using new Future() or new Future.delayed()).
* Use Future’s then() or whenComplete() method to specify task order.
* To avoid starving the event loop, keep the microtask queue as short as possible.
* To keep your app responsive, avoid compute-intensive tasks on either event loop.
* To perform compute-intensive tasks, create additional isolates or workers.


### Reference
[Zone](https://dart.dev/articles/archive/zones)
[Isolates](https://medium.com/dartlang/dart-asynchronous-programming-isolates-and-event-loops-bffc3e296a6a)
[Event Loop, Microtask & Event Queue](https://www.woolha.com/articles/dart-event-loop-microtask-event-queue)
[The Event Loop and Dart](https://web.archive.org/web/20170704074724/https://webdev.dartlang.org/articles/performance/event-loop)
[Dart - Event Loop, Microtask & Event Queue](https://www.woolha.com/articles/dart-event-loop-microtask-event-queue)