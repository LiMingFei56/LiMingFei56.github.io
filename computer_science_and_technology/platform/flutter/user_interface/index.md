---
layout: page
permalink: ./technology-home/platform/flutter/user-interface/
---

## User Interface

### 1. Introduction
Dart入口main函数，flutter需要调用runApp(widget)函数来呈现界面。

#### 1.1. Declarative UI And Imperative UI
Android和IOS使用命令式的UI，构建一个View，然后对它set一些状态。如果用户点击了什么行为，那么会`findViewById`后处理这个行为。

    // Imperative style
    b.setColor(red)
    b.clearChildren()
    ViewC c3 = new ViewC(...)
    b.add(c3)

Flutter是声名式UI，视图配置是不变的，Widget只是描述界面的蓝图。如果用户点击了什么行为，那么会修改State的状态，最后调用setState()
使的视图重新构建。构建新的Widget实例，而不修改旧的。使用`RanderObjects`管理传统UI对象的许多职责（如维护布局状态）。build函数中返回新的Widget

### 2. Widget

#### 2.1. Widget结构
Widget是描述和配置界面是怎么渲染的，Widget最重要的是`build`函数，它使用其它Widget来描述自身。这样就构建成一个Widget Tree。
Framework会按顺序构建WidgetTree，直到最后遇到`RenderObject`Widget，它计算并描述了Widget的几何形状。

#### 2.2. Widget实现
Widget都是不可变的，都会重建每一帧，区分是是否管理状态。
StatelessWidget - build 无状态，不可改变，也就是不能改变显示的内容
StatefulWidget - createState - State（可以保存状态信息） - build 通过调用setState方法来改变状态，会重新调用build函数。

#### 2.3. Widget种类
Basic

Material Components: `MaterialApp` 
  - 需要`pubspec.yaml`中配置`uses-material-design: true`
  - import 'package:flutter/material.dart';

    name: my_app
    flutter:
    uses-material-design: true


Cupertino Components

#### 2.4. Widget生命周期
详情见[Widget Lifecycle](./widget-lifecycle)

#### 2.5. Widget Key
Widget重建时，framework通过`runtimeType`和widget在树中的顺序来对新和旧的Widget进行匹配，识别出从旧状
态到新状态所需的最小更改。

可以使用key来进行匹配，framework要求相同的Widget需要`key`和`runtimeType`相同。

当构建相同类型的Widget的许多实例时，key就非常有用。在List中，不管第一条当前是否显示，默认都会匹配。但是用了key就
可以有针对性的匹配。

Global Key
在全局唯一标识Widget，需要全局唯一标识符，而key只需要兄弟中唯一。

### 3. Layout
Layout Widget都具有下面一项:
* `child`属性，只有一个孩子，Center和Container
* `children`属性，有多个孩子，Row、Column、ListView、Stack

处理Widget约束[详细](./widget-box-constraints)

### 4. Navigation
详细见[Navigation](./widget-navigation)

### 5. Animations

#### 5.1. Animations分类
Tween Animation - 定义起点，终点，时间线，速度曲线。框架会计算中间值
Physics-based animation - 动画会建模为类似现实世界的物体。如重力， 球等

#### 5.2. 常用的动画模式
AnimatedList - 在List和grid中添加、删除元素的动画。[Example](https://flutter.io/docs/catalog/samples/animated-list)
Shared element transition - 一个元素(一般是Image), 从一个页面过渡到另一个页面。[Hero Animations](https://flutter.io/docs/development/ui/animations/hero-animations)
Staggered animation - 动画组合，延迟，顺序，重叠等。[Staggered Animations](https://flutter.io/docs/development/ui/animations/staggered-animations)




详细见[Animation](./widget-animation)

### 6. Widget Catalog
