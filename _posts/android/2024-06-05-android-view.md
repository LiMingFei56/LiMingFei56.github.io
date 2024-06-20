---
layout: post
title: Android View
categories: android
tags: [android]
date: 2024-06-05
---

## Android View

* 双缓存: 屏幕缓存和GPS渲染缓存分开, 防止屏幕显示不完整的帧 `Back Buffer`和`Frame Buffer`
* VSync: Vertical Synchronization, 利用Vertical Blanking Interval(VBI) 间隙的 vertical sync pulse（垂直同步脉冲）交换双缓存. 避免screen tearing.
* Choreographer: 保证绘制拥有完整的16.6ms，避免绘制的随机性
* SurfaceFlinger: 接受多个来源的图形显示数据，将他们合成，然后发送到显示设备进行渲染

### 重绘

1. requestLayout 或者 invalidate
2. performTraversals
3. performMeasure -> view.measure
4. performLayout -> view.layout
5. performDraw -> view.draw

### Activity

* Activity包含了一个PhoneWindow，
* PhoneWindow就是继承于Window
* Activity通过setContentView将View设置到了PhoneWindow上
* PhoneWindow里面包含了DecorView，最终布局被添加到Decorview上.


* onCreate ActivityThread attach Window(PhoneWindow)
* DecorView (FrameLayout)
* ViewRootImpl DecorView <-> Window


### 事件分发

dispatchTouchEvent()	这是 View 或 ViewGroup 中用于分发触摸事件的方法。	当一个触摸事件到达一个 View 或 ViewGroup 时，首先调用该方法。该方法会根据事件的类型和目标 View 的状态，决定是在当前 View 处理事件还是将事件传递给子 View。
onInterceptTouchEvent()	这是 ViewGroup 中的一个方法，用于拦截触摸事件，阻止它们继续传递给子 View。	当一个 ViewGroup 的父 View 在 dispatchTouchEvent 方法中决定是否传递事件给它时，会先调用该方法。如果该方法返回 true，则表示拦截事件，停止传递给子 View；如果返回 false，则事件会继续传递给子 View。
onTouchEvent()	这是 View 或 ViewGroup 中用于处理触摸事件的方法。	当一个触摸事件被分发给一个 View 或 ViewGroup 时，如果该 View 或 ViewGroup 没有拦截该事件，或者拦截后又决定放弃拦截，那么该方法会被调用。在该方法中，开发人员可以实现自定义的触摸事件处理逻辑。

                        
原文链接：https://blog.csdn.net/KangYouWei6/article/details/136814470


## Reference
+ [Android渲染系列之原理概述篇](https://zhuanlan.zhihu.com/p/661027517)
+ [从视图树到GPU：探索Android渲染机制](https://zhuanlan.zhihu.com/p/623556358)
+ [View的绘制机制和刷新机制](https://www.jianshu.com/p/02e5a52ff886)
+ [Android Window: Basic Concepts](https://medium.com/@MrAndroid/android-window-basic-concepts-a11d6fcaaf3f)
