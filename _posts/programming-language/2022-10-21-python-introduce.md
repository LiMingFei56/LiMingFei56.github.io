---
layout: post
title: python introduce
categories: lang
tags: [lang]
date: 2022-10-21
---

## python introduce

### 解释器

* [CPython](https://github.com/python/cpython)  
> python泛指Cpython, 使用C实现, 可以很方便的集成C代码. Cpython中有 `Global Interpreter Lock(GIL)`, 
> 同一时间只允许一个线程获取解释器的控制权. 一般使用多进程实现并发需求.

* [PyPy](https://www.pypy.org/)  
> JIT Python实现, 比CPython快很多

* [Jython]
> 在JVM运行Python, 可以很容易与Java集成

* [IronPython]
> .net实现

* [PythonNet]
> .net实现

## Reference
[Python最佳实践指南！](https://pythonguidecn.readthedocs.io/zh/latest/)  
[教你阅读 Cpython 的源码（一）](https://zhuanlan.zhihu.com/p/88048361)  
[Multiprocessing vs Threading Python [duplicate]](https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-python)  
[Just-in-time compilation](https://en.wikipedia.org/wiki/Just-in-time_compilation)  
