---
layout: post
title: Android Event-Dispatching
categories: android
tags: [android]
date: 2022-09-13
---

## Android Event-Dispatching

Activity:
public boolean dispatchTouchEvent(MotionEvent ev)；
public boolean onTouchEvent(MotionEvent ev);
ViewGroup:
public boolean dispatchTouchEvent(MotionEvent ev)；
public boolean onInterceptTouchEvent(MotionEvent ev);
public boolean onTouchEvent(MotionEvent ev);
View:
public boolean dispatchTouchEvent(MotionEvent ev)；
public boolean onTouchEvent(MotionEvent ev);


从父到子: dispatchTouchEvent
从子到父: onTouchEvent
ViewGroup: 可以使用onInterceptTouchEvent来拦截事件, 在当前view 的dispatchTouchEvent后调用.

## Reference
[5 Steps for Beginners to Understand Event-Dispatching in Android](https://medium.com/@li.shuang.0425/5-steps-for-beginners-to-understand-event-dispatching-in-android-9b3b85024188)  
