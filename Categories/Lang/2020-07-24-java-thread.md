## Java 多线程
source: `{{ page.path }}`


### 线程池

Executors

newCachedThreadPool: 创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回  
    收空闲线程，若无可回收，则新建线程。线程池的规模不存在限制。（数量不固定的线程池）
newFixedThreadPool: 创建一个固定长度线程池，可控制线程最大并发数，超出的线程会  
    在队列中等待。（固定数量的线程池）
newScheduledThreadPool: 创建一个固定长度线程池，支持定时及周期性任务执行。（定时线程池）
newSingleThreadExecutor: 创建一个单线程化的线程池，它只会用唯一的工作线程来执行  
    任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。（单线程的线程池）


### Reference

[Java四种线程池使用方法](https://blog.csdn.net/fox_bert/article/details/99702932)
