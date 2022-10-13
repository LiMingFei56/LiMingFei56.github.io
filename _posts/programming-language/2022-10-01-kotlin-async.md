---
layout: post
title: kotlin async
categories: lang
tags: [lang]
date: 2022-10-01
---

## kotlin async

    * Threading

    * Callbacks

    * Futures, promises, and others

    * Reactive Extensions

    * Coroutines

### threading

* 线程需要上下文切换, 消耗大
* 线程根据操作系统定义最大数量
* 有些语言不支持线程
* 线程编程容易出错, 并且不容易调试

### callbacks

* titled christmas tree. 嵌套函数不容易理解
* 嵌套函数使错误处理很复杂.
* javascript 中很常见, 目前已改用`promises`和`reactive extensions`

### Futures, promises, and others

* 不同的编程模型. 从自顶向下的命令式改成链式调用的组合模型.
* 不同的API. 需要根据平台学习api.
* 具体的返回类型. 必须返回`Promise`
* 错误处理很复杂, 错误传播和链接并不总是直接

### Reactive extensions

> Reactive Extensions(RX), Rxjava
> 把数据当成`observable streams`, 背后就是观察者模式, 做了很多扩展.
> 跟Futures很像, 但是是返回stream
> 很多平台支持, 更好的错误处理

### Coroutines

> kotlin 使用Coroutines, 思想是`suspendable computations`, 一个函数可以挂起, 
> 等条件满足时再继承执行.

> 好处是编程模型没有改变, 与阻塞代码本质上一样. kotlin协程大多数功能都委托给库, 只引入
> `suspend`关键字, 不像c#提供`async`和`await`

## Reference
