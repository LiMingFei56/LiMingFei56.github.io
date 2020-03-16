---
layout: post
title: "C/C++跨平台编程"
categories: c
tags: [c]
date: 2020-03-11
excerpt: "C/C++跨平台编程"
---

## C/C++跨平台编程
使用POSIX 函数


### windows
需要使用Cygwin, Cygwin中脚本文件需要使用dos2unix程序 转换一下

### 1. 找不到ntohll和htonll函数

需要自己实现

    u_int64_t my_htonll(u_int64_t val) {
        return (((u_int64_t) htonl(val)) << 32) + htonl(val >> 32);
    }

    u_int64_t my_ntohll(u_int64_t val) {
        return (((u_int64_t) ntohl(val)) << 32) + ntohl(val >> 32);
    }