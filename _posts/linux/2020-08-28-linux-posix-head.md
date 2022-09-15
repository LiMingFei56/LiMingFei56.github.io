---
layout: post
title: "Linux Posix Head"
categories: linux
tags: [linux]
date: 2020-08-28
---

## Linux Posix Head

    $ echo | g++ -v -x c++ -E -
    $ echo | gcc -v -x c++ -E -

* <aio.h> - 异步IO相关的函数
* <arpa/inet.h> - IP地址相关的函数
* <dirent.h> - 顾名思义directory entry
* <fcntl.h> - 文件操作
* <iconv.h> - 对于多语言的支持
* <malloc.h> - 堆内存的一些高级操作和统计
* <netdb.h> - 主机名服务名协议名等等操作
* <netinet/in.h> - IP地址结构的定义，已经网络主机字节序转换
* <sys/socket.h> - socket相关的一些定义
* <sys/stat.h> - 文件属性相关的定义
* <sys/un.h> - Unix socket相关的操作
* <time.h> - 时间相关的结构和操作
* <unistd.h> - 提供系统调用接口，基本都是要进入的内核态的操作。
* <wchar.h> - 标准C99已经把这个放在C标准库里。

### <pthread.h>

> 线程库, 如果是linux系统, 编译时需要添加链接选项, 不然会报找不到pthread函数

    -lpthread -pthread
    add_compile_options(-pthread)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

### Multiply defined

> 需要添加`-fcommon` 编译选项

  [Compile old C code (on Linux) that throws errors (Multiply defined) with modern gcc? [closed]](https://stackoverflow.com/questions/66512831/compile-old-c-code-on-linux-that-throws-errors-multiply-defined-with-modern)

### <time.h>

> 定时器, macintosh中没有定时器, 可以使用线程实现

    timer_create
    timer_getoverrun
    timer_gettime
    timer_settime
    timer_delete
    
### Reference

