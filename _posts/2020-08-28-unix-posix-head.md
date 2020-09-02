---
layout: post
title: "Posix Head"
categories: unix
tags: [posix]
date: 2020-08-28
excerpt: "Posix Head"
---

## Posix Head

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


### Reference

