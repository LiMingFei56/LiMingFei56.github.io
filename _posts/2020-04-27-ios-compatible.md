---
layout: post
title: "iOS 系统兼容"
categories: ios
tags: [ios]
date: 2020-04-27
---

## iOS 系统兼容

### 1. Safe Area Layout Guide before ios 9.0

> 9.0 前使用`Top Layout Guide`和`Bottom Layout Guide`进行约束, 11中被弃用
> , 9.0 使用`Safe Area`. 
>
> 为了兼容8.0, 需要使用`Top Layout Guide` 和 `Bottom Layout Guide`

    1. storyboard中选择ViewController
    2. File inspector中`Builds for` 选择 `iOS 9.0 and Later`
    3. 去掉`Use Safe Area Layout Guides`

### 2. WKWebView before iOS 11.0 (NSCoding support was broken in previous versions)

> Webkit framework是iOS 8, macOS 10.10中引入的, 用来取代UIWebView和WebView
> 但是8.0中在storyboard中使用WkWebView报错, 需要在代码中创建
