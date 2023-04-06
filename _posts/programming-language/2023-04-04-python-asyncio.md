---
layout: post
title: Python asyncio
categories: python
tags: [python]
date: 2023-04-04
---

## Python asyncio

### high-level APIs

#### Coroutines and Tasks

    async/await

    asyncio.run() 运行coroutines顶级入口点
    asyncio.create_task() 创建并发coroutines任务
    asyncio.TaskGroup() 3.11 替代asyncio.create_task

> 一个对象如果可以使用await, 那么就说这个对象是awaitables
> asyncio库的对象, 大多数是awaitables

> coroutine function: an `async def` function;
> coroutine object:   an object returned by calling a `coroutine function`.

> coroutine object 对象没有调用await表达式时, 什么都不执行

> Tasks are used to schedule coroutines concurrently.
> The task is executed in the loop returned by get_running_loop(), RuntimeError is raised if there is no running loop in current thread.

### low-level APIs

#### Futures

> A Future is a special low-level awaitable object that represents an eventual result of an asynchronous operation.
> A good example of a low-level function that returns a Future object is loop.run_in_executor().


## Reference
+ [asyncio — Asynchronous I/O](https://docs.python.org/3/library/asyncio.html)
