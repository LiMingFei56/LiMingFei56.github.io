---
layout: post
title: Android Binder
categories: android
tags: [android]
date: 2024-06-05
---

## Android Binder

### Linux 进程间通信

匿名管道(PIPE)
命名管道(FIFO)
信号量
共享内存映射
共享内存
消息队列
信号量
UNIX域套接字(Unix Domain Socket)
socketpair

匿名管道（PIPE）：
    优点：简单方便，基于操作系统内核提供的缓冲区实现进程间通信。
    缺点：
        局限于单向通信。
        只能用于具有亲缘关系的进程间通信，即父子进程。
        缓冲区大小有限。

命名管道（FIFO）：
    优点：
        实现了任意关系进程间的通信，克服了匿名管道的亲缘关系限制。
        存在于文件系统中，可以像操作普通文件一样操作命名管道。
    缺点：
        长期存在于系统中，如果使用不当可能导致错误。
        缓冲区大小有限。
        通常也是半双工通信方式。

信号（Signal）：
    优点：
        异步通信方式，发送信号后接收者何时处理是异步的。
        简单性，易于实现和使用。
    缺点：信号传递的信息量有限，只能传递简单的整数值作为信号编号。

共享内存映射与共享内存：
    优点：
        提供对大块内存区域的有效访问，访问速度快，因为直接访问内存而无需通过操作系统。
        允许多个进程访问同一块内存区域。
    缺点：
        本身不支持阻塞等待操作，需要其他同步机制（如信号量）配合使用。
        如果没有适当的同步机制，可能会导致数据不一致的问题。

消息队列（Message Queue）：
    优点：
        支持进程间的异步通信和同步通信。
        可以传输大量数据，支持多对多的进程通信。
    缺点：
        需要手动管理消息队列，避免阻塞等问题。
        如果队列中消息过多，可能会导致内存占用过高。

信号量（Semaphore）：
    优点：
        是一种有效的进程同步和互斥机制，可以防止多个进程同时访问共享资源。
    缺点：
        复杂性相对较高，需要仔细设计和使用以避免死锁等问题。

UNIX域套接字（Unix Domain Socket）：
    优点：
        提供了类似于网络套接字（TCP/UDP）的通信接口，但用于同一台机器上的进程间通信。
        通信效率高，因为不涉及网络协议栈的处理。
    缺点：
        相对于其他IPC方式，其编程接口可能较为复杂。

socketpair：
    优点：
        创建了一对相互连接的套接字，可用于两个进程之间的双向通信。
        提供了与网络套接字相似的编程接口，易于理解和使用。
    缺点：
        相对于其他IPC方式，可能涉及更多的系统调用和资源开销。

> 共享内存是0拷贝, 但实现同步难, 还要依赖其他实现方式
> 管道, 信号, socker都是使用`copy_from_user`和`copy_to_user` 两次拷贝. 一次用户空间拷贝到内核空间 一次内核空间拷贝到用户空间.

#### Binder

> Binder是由开源项目[OpenBinder](https://github.com/seyko2/openbinder)来的, 后面作者加入Android后引入Android. 

> 内存映射：Binder IPC 机制中涉及到的内存映射通过mmap() 来实现，mmap() 是操作系统中一种内存映射的方法。内存映射简单的讲就是将用户空间的一块内存区域映射到内核区域
> 所以只需要一次拷贝.

> Binder 启动的是 misc 设备, 会创建一个虚拟设备. 


## Reference
+ [如何应对Android面试官->玩转Binder机制，手写MMKV核心实现 ](https://juejin.cn/post/7344682689453424649)