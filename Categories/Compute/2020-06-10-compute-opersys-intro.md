## 操作系统-介绍
source: `{{ page.path }}`

> 操作系统是一种管理软件, 软件管理, 资源管理. 对CPU, 内存, 磁盘进行抽象成进程, 地址
> 空间, 文件. 面积硬件有中断处理与设备IO.

### 组件

* CPU调度器
* 物理内存管理
* 虚拟内存管理
* 文件系统管理
* 中断处理与设备驱动

### 特征

* 并发
* 共享资源
* 虚拟
* 异步

### 最新研究现状

* SOSP
* USENIX

### 操作系统研究地方

#### 权衡

* 空间与时间
* 性能和可预测性
* 公平和性能

#### 硬件

* 良好的硬件管理
* 合理的资源分配
* 例如: 硬盘速度跟CPU, 内存相差很多, 操作系统需要协调处理

### 操作系统设计

* 单内核 : monolithic kernel 函数调用, 但驱动结构复杂, 驱动出错将影响系统稳定性
* 微内核 : micro kernel 进程调用, 驱动以进程方式存在, 方便移植, 性能不佳
* 超微内核 : nano kernel 
* 外核 : exo kernel

## Reference

[清华大学公开课-操作系统](https://www.bilibili.com/video/BV1uW411f72n?p=1)
[清华大学公开课-操作系统](http://open.163.com/newview/movie/free?pid=ME1NSA351&mid=ME1NUD4K4)
[ucore](https://github.com/kiukotsu/ucore)
