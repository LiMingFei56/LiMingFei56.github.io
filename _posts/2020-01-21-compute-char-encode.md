---
layout: post
title: "字符编码"
categories: compute
tags: [encode]
date: 2020-01-21
excerpt: "字符编码"
---

## Unicode
如果是UTF-8, UTF-16, UTF-32, 那么需要使用零宽度非换行空格(ZERO WIDTH NO-BREAK SPACE)
来表示字节顺序. `FEFF`表示大端, `FFFE`表示小端

### UTF-8
可变长度的编译, 英文一个字节, 常用中文3字节, 不常用中文4字节.

### UTF-16
分为大头端UTF-16BE, 小头端UTF-16LE

最少2个字节, 中字4字节
