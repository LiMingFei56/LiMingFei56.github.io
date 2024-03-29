---
layout: post
title: Android View drawing process
categories: android
tags: [android]
date: 2022-09-13
---

## Android View drawing process

### Android's UI management system

1. Activity
2. PhoneWindow mWindow
3. DecorView mDecor
4. System Layout
5. ViewGroup mContentParent
6. Activity Layout

#### PhoneWindow

* 每一个Activity都包含一个Window对象，Window对象通常由PhoneWindow实现
* PhoneWindow：将Decoriew设置为整个应用窗口的根View。是Window的实现类。它是Android中的最基本的窗口系统，每个Activity 均会创建一个PhoneWindow对象，是Activity和整个View系统交互的接口。

#### DecorView

> 顶层视图，将要显示的具体内容呈现在PhoneWindow上. DecorView是当前Activity所有View的祖先
> ，它并不会向用户呈现任何东西，它主要有如下几个功能，可能不全：

* A. Dispatch ViewRoot分发来的key、touch、trackball等外部事件；
* B. DecorView有一个直接的子View，我们称之为System Layout,这个View是从系统的Layout.xml中解析出的，它包含当前UI的风格，如是否带title、是否带process bar等。可以称这些属性为Window decorations。
* C. 作为PhoneWindow与ViewRoot之间的桥梁，ViewRoot通过DecorView设置窗口属性。//可以这样获取 View view = getWindow().getDecorView();
* D. DecorView只有一个子元素为LinearLayout。代表整个Window界面，包含通知栏，标题栏，内容显示栏三块区域。DecorView里面TitleView：标题，可以设置requestWindowFeature(Window.FEATURE_NO_TITLE)取消掉ContentView：是一个id为content的FrameLayout。我们平常在Activity使用的setContentView就是设置在这里，也就是在FrameLayout上

## Reference
[How Android Draws Views](https://developer.android.com/guide/topics/ui/how-android-draws)  
[Drawing process of Android View](https://programmer.group/drawing-process-of-android-view.html)  
[Android view drawing process](https://developpaper.com/android-view-drawing-process/)  
[Android窗口机制（一）初识Android的窗口结构](https://www.jianshu.com/p/40a9c93b5a8d)  
