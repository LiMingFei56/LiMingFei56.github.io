---
layout: post
title: "ios11.2系统flutter使用webview_flutter不能弹出日历"
categories: flutter
tags: [view]
date: 2019-02-25
excerpt: "Flutter中WebView不能拦截输入框点击事件"
---

## Flutter使用[webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)时,跳转不了about:blank
    寄递业务看板ios版,使用webview_flutter插件加载网页,其中有个日历控件弹不出来.
	日历是使用html-input-text实现, 用户点击输入框弹出日历, 但是webview_flutter上弹出了软键盘

    webview_flutter插件使用WKWebView, 然后在xcode原生使用WKWebView时可以弹出.
    对比发现是WKNavigationDelegate.decidePolicyForNavigationAction方法中调用
    decisionHandler(WKNavigationActionPolicyCancel)可以拦截请求.

    但是打印日志后发现并没有拦截, 调用的是decisionHandler(WKNavigationActionPolicyAllow)
    并且之后点击日历不会再触发about:blank跳转.
    以此推断, webview_flutter中decisionHandler是异步调用, 而ios的decidePolicyFornavigationAction方法
    没有等待异步返回, 并且丢失了decisionHandler引用(因为需要弹出软键盘)


## 修改
    不异步调用decisionHandler

    在系统12中没有上述问题, 在11.2中出现这个问题, 其他系统版本没有测试


