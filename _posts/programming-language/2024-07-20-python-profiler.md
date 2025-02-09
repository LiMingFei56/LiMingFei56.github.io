---
layout: post
title: Python profiler
categories: python
tags: [python]
date: 2024-07-20
---

## Python profiler

性能分析和代码优化
1. cProfile

cProfile 是 Python 内置的性能分析器，适用于对整个程序进行性能分析。

python

import cProfile

def my_function():
    # Your function code here
    for i in range(10000):
        pass

cProfile.run('my_function()')

2. line_profiler

line_profiler 是一个用于逐行分析 Python 代码性能的工具。需要先安装：

sh

pip install line_profiler

使用方法：

python

from line_profiler import LineProfiler

def my_function():
    # Your function code here
    for i in range(10000):
        pass

profiler = LineProfiler()
profiler.add_function(my_function)
profiler.enable_by_count()

my_function()

profiler.print_stats()

3. memory_profiler

memory_profiler 用于监控 Python 程序的内存使用情况。需要先安装：

sh

pip install memory_profiler

使用方法：

python

from memory_profiler import profile

@profile
def my_function():
    # Your function code here
    a = [i for i in range(10000)]

my_function()

资源使用监控
1. psutil

psutil 是一个跨平台库，用于获取系统运行时的各种信息，如 CPU、内存、磁盘、网络等。

sh

pip install psutil

使用方法：

python

import psutil

# CPU 信息
print(psutil.cpu_percent(interval=1))
print(psutil.cpu_times())

# 内存信息
print(psutil.virtual_memory())

# 磁盘信息
print(psutil.disk_usage('/'))

# 网络信息
print(psutil.net_io_counters())

日志记录
1. logging

logging 是 Python 内置的日志记录模块，可以用于记录程序运行中的各种信息。

python

import logging

logging.basicConfig(level=logging.INFO)

def my_function():
    logging.info("Function started")
    for i in range(10000):
        pass
    logging.info("Function ended")

my_function()

2. loguru

loguru 是一个简单且功能强大的日志库，可以替代 Python 内置的 logging 模块。需要先安装：

sh

pip install loguru

使用方法：

python

from loguru import logger

def my_function():
    logger.info("Function started")
    for i in range(10000):
        pass
    logger.info("Function ended")

my_function()

代码质量和复杂度分析
1. pylint

pylint 是一个静态代码分析工具，用于检查 Python 代码的质量。

sh

pip install pylint

使用方法：

sh

pylint your_script.py

2. radon

radon 是一个代码复杂度分析工具，可以计算代码的圈复杂度、维护指数等。需要先安装：

sh

pip install radon

使用方法：

sh

radon cc your_script.py  # 计算圈复杂度
radon mi your_script.py  # 计算维护指数

实时监控
1. py-spy

py-spy 是一个采样分析器，可以在不修改代码的情况下实时监控 Python 程序的性能。需要先安装：

sh

pip install py-spy

使用方法：

sh

py-spy top --pid <pid>

这些库和工具可以帮助你全面监控和统计 Python 程序的运行情况，从而优化性能和提高代码质量。

## Reference
