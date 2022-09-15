---
layout: post
title: Linux 并发
categories: linux
tags: [linux]
date: 2022-07-28
---

## Linux 并发

### 线程

> linux中以结合模式分为joinable和detached两种, joinable可以由其他线程调用pthread_join函
> 数阻塞线程等待该线程处理结果. joinable线程退出后不会释放创建线程时使用的栈空间, 只有
> 调用pthread_join才会释放. detached线程退出后会自动释放.

#### detached

  1. 使用属性
    pthread_attr_t attr;
    pthread_attr_init (&attr);
    pthread_attr_setdetachstat(&attr, PTHREAD_CREATE_DETACHED);
    pthread_create (&thread, &attr, &thread_function, NULL);

  2. 使用pthread_detached()函数;
    pthread_detach(pthread_self()); // 线程中
    pthread_detach(pid); // 主线程

#### 线程退出

1. return 返回
2. pthread_exit, 当前线程调用, 退出当前线程, 并给pthread_join返回结果
3. pthread_cancel, 其他线程调用, 需要有取消点, 没有会报错; 线程需要设置取消处理方式

      pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
      pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);


    


## Reference
[Linux线程退出、资源回收、资源清理的方法](https://blog.csdn.net/weiyaonan/article/details/121472963)  
