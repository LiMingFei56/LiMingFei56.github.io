---
layout: page
permalink: ./technology-home/platform/flutter/user-interface/widget-gestures
---

## Gestures
`Gestures`系统有两层：
1. 原始指针事件，描述在屏幕上的位置和移动。
2. 第二层就是手势，描述多个原始指针组合成的动作。

### 1. Pointers
pointer4种事件：
* PointerDownEvent - pointer在特定位置与屏幕接触
* PointerMoveEvent - pointer在屏幕上从一个位置移动到另一个位置
* PointerUpEvent - pointer不再与屏幕接触
* PointerCancelEvent - pointer不再聚焦当前应用
  
pointer工作步骤：
1. pointer down
2. hit test - 找到触发的Widget
3. 发当前pointer和之后的一起发给widget
4. 从找到的widget冒泡传递事件到最上层

如果点击时间短，测试后不会传递，点击持续一段时间会传递。子widget往父widget传递

pointer监听：
1. listener - widget层监听
2. gesture() - 传递(GestureDetector)

### 2. Gestures
Gestures表示一个行为，如向下滑动，缩放；还表示手势的生命周期

使用`GestureDetector`类，如果使用Material Components，那么就实现了taps or gestures。
`GestureDetector`类通过判断回调方式是否实现（是否为空）来决定识别哪些手势，如果一个位置有多少手势
识别，那么所有的手势识别都会通过pointer事件流尝试识别自己的手挚。

多手势识别竞争：
    * `GestureDetector`任何时间都可以放弃竞争，剩下的最后一个就胜利
    * `GestureDetector`任何时间都可以宣布胜利，剩下的都失败

