---
layout: post
title: I/O Multiplexing(多路复用)
categories: linux
tags: [linux]
date: 2022-07-18
---

## I/O Multiplexing(多路复用)

> 当服务器在一个端口上创建监听, 该监听会阻塞当前线程, 当有一个请求时, 会激活当前
> 线程来处理请求, 处理完成继续阻塞等待下一个请求. 单线程模式, 一次只能处理一个请求.

> 当有一个请求时, 创建一个新的线程来处理这个请求, 服务器可以继续监听下一个请求.
> 多线程模式, 可以处理多个请求.
> 创建线程, 销毁线程和切换线程会有开销, 一般创建线程占用8M栈内存`ulimit -a`, 3G空余内存可以创建
> 300左右线程. 
> 变种就是线程池模式, 解决了创建线程和销毁线程问题, 但是如果是需要多次交互的, 线程会
> 处于闲置状态, 等待可读或可写, 多个这种业务会占用线程数量, 后面的任务只能等待.

> 把I/O句柄(包括服务器端口监听)放入todolist, 并给它们标记状态, 当可写, 可读, 出错状态出现
> 时改变它们的状态. 循环todolist, 当状态改变时处理. 多路复用单线程模式, 适合ios密集型
> 任务.
> 当状态改变时使用线程池中线程处理, 多路复用 + 线程池, 如果任务有上下文关联, 那么会导致
> 多线程处理复杂.

> select 和 poll 就是循环todolist, select循环长度不能大于1024, poll使用链表保存句柄, 没有
> 这个问题.

> select 和 poll循环, 时间复杂度是O(N). epoll是当状态改变就通知处理, 复杂度是O(1)

select
poll
epoll(linux)
kqueue(macOS)

## Reference
[Multiplexing](https://en.wikipedia.org/wiki/Multiplexing)  
[I/O Multiplexing (select vs. poll vs. epoll/kqueue)](https://nima101.github.io/io_multiplexing)  
