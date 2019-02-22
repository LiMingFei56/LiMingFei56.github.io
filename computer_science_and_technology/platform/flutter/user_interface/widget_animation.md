---
layout: page
permalink: ./technology-home/platform/flutter/user-interface/widget-animation
---

## Animation
动画系统主要基于`Animation`对象。`Animation`对象会在特定时间上产生对应的值并调用setState()使Widget重建，Widget使用Animation
产生的值重新构建，这样就实现Tween Animation。

大多数Widget会有一个接收`Animation`对象的参数`animation`，会自动读取当前的值并监听值的变化。

### 1. Animation监听

#### 1.1. addListener()
addListener() - 当`Animation`对象的值改变时，会通知所有的listener。通常需要在listener回调中调用setState()，触发Widget重建。

这里面有两步是必须，并且重复的操作: 1. addListener() 2. 在listener回调中调用setState()
使用`AnimatedWidget`和`AnimatedBuilder`简化上面两步。

AnimatedWidget - 一般用于无状态的Widget
AnimatedBuilder - 用于复杂的Widget

#### 1.2. addStatusListener()
addStatusListener() - 当动画的状态`AnimationStatus`改变时，会通知所有的listener。

动画状态：
completed - 动画停在结尾
dismissed - 动画停在开始
forward - 动画运行在开始到结尾
reverse - 动画运行在结尾到开始

### 2. AnimationController
用来控制动画：
* `forward` or `reverse`开启动画, `stop`停止动画
* 设置动画的值
* 定义`upperBound` and `lowerBound`
* `fling` physics simulation

使用`Ticker`来控制时间，每个`Tick`会获取一个时间并传递给`Simulations`获取一个值，如果`Simulations.isDone`，那么AnimationController会停止。

AnimationController(duration: const Duration(seconds: 2), vsync: this)
- duration 持续时间
- vsync 是否不渲染屏外动画

### 3. Interpolates
* Tween<T> - 定义`begin`和`end`间的插值, 子类`ColorTween`、`RectTween`，自定义需要实现`lerp`函数

`evaluate`函数，通过Animation状态来计算当前的值。
`animate`函数，根据插值创建新的`Animation`对象。

### 4. 动画的组成

#### 4.1. Scheduler
`SchedulerBinding`是flutter调度类，当屏幕需要新的帧时，flutter会触发`begin frame`。会在相同的时间上调用
`scheduleFrameCallback()`回调，使所以动画看起来是同步（虽然有几毫秒的误差）

以下项会进行调度：
* Transient callbacks（临时回调），由系统`Window.onBeginFrame`回调，用于将应用程序的行为和系统显示同步。Tickers和AnimationController会触发。
* Persistent callbacks（持续回调），由系统`Window.onDrawFrame`回调，用于在临时回调后更新系统系统显示。渲染层使用它来沉浸管道。
* Post-frame callbacks（后帧回调），在持续回调之后，在`Window.onDrawFrame`调用返回之前回调。
* 帧之间的非渲染任务，有优先权，根据调度策略和优先级顺序执行。

#### 4.2. Tickers
每个帧都会回调，时钟依赖于`scheduleFrameCallback()`。可以`start`和`stop`还有`muted`（时间在走，但不会回调）

#### 4.3. Simulations
相对时间上映射一个值，包含一个完成的概念（当映射的值接近给定的值，tolerance就是`Done`）。

有些Simulations是有状态的，调用后会不可逆的修改值。所以最好给出大于或等于的时间。

#### 4.4. 插值的计算
Animatables - 值的变化幅度恒定不变
Curves - 值的变化允许加速、减速

##### 4.4.1. Animatables
Tween的父类，映射一个到给定类型的值，无状态，不变。

chain()联接两个Animatables，先使用父的映射，再使用子的映射

##### 4.4.2. Curves
0.0-1.0映射到0.0-1.0，无状态，不变。

用于调整动画随时间变化的速率，允许它们加速或减速，而不是以恒定速率移动。