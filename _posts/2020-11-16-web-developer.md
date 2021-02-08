---
layout: post
title: "Javaweb Developer"
categories: javaweb
tags: [javaweb]
date: 2020-11-16
---

## Javaweb Developer

    Web开发原先主要在浏览器端，浏览器会从服务器端请求html、css、js三个文件来绘制  
用户界面并与用户交互。  

### Web主要技术

* Web APIs: 操作DOM和其他浏览器支持的API
* HTML: 描述用户界面的结构
* CSS: 描述HTML如何展示
* JavaScript: 让界面与用户交互
* SVG: 描述矢量图
* MathML: 显示复杂的方程式和语法
* WebAssembly: 让浏览器可以跑二进制文件

### Chromuim
    当易用，符合标准，运行快的Chromuim出来后，迅速占领了绝大部分的浏览器份额。  
渲染层使用`WebKit`，js运行层使用`V8`, 2D图形使用`Skia`。

    V8运行时因为快速，稳定，跨平台，单独封装出来作成了`Node`.
    
### Node
    Node是使用V8封装后，得到跨平台JS运行时，可以用来编写PC软件。Node使用module来  
管理模块，所以就提供npm包管理器。

* npm: 官方包管理器
* cnpm: 同npm，但使用中国源
* yarn: 解决npm一些问题
* pnpm: 解决npm和yarn运行的问题

    Node作者不满意Node的一些方面，比如安全，后来又开发了Deno.

    Node版本不一样，API也不一样，程序对Node版本的依赖很重，所以有`nvm`管理Node的
版本

### 前端技术的再封装
    就像CPU只认识0、1，浏览器只认识html、css、js。但随着PC性能和网速提高，前端  
可以做的东西越来越多，规模越来越大，渐渐这三种技术不易于开发与维护了。所以出现  
一些新的技术对这三种技术进行封装。

* jQuery: 是对DOM API的封装
* html: React Vue Angularjs 使用js声明html对象，可以使html组件化
* css: Sass less Stylus css预处理器，使用变量，逻辑来生成css
* js: TypeScript 对js添加类型

### 小程序
    微信出了小程序，可以在不安装APP时，获取接近APP的体验，各大公司分分跟进。
    在iOS上小程序逻辑层的 javascript 代码运行在 JavaScriptCore 中，视图层是由 WKWebView 来渲染的
    在Android 上，小程序逻辑层的 javascript 代码运行在 V8 中，视图层是由自研 XWeb 引擎基于 Mobile Chrome 内核来渲染的
    在开发工具上，小程序逻辑层的 javascript 代码是运行在 NW.js 中，视图层是由 Chromium Webview 来渲染的

    为了跨小程序平台，就有：
* taro
* wepy
* mpvue
* uni-app

### Reference
[Web technology for developers](https://developer.mozilla.org/en-US/docs/Web)  
[理解WebKit和Chromium: 浏览器综述](https://www.cnblogs.com/xiaowangba/archive/2013/05/09/6313856.html)  
[WebKit](https://webkit.org/)  
[V8](https://v8.dev/)  
[Skia](https://github.com/google/skia) 
[Node](https://nodejs.org/en/)  
[npm](https://www.npmjs.com/)  
[deno](https://github.com/denoland/deno)
[nvm](https://github.com/nvm-sh/nvm)
[taro](https://taro.aotu.io/)
[小程序多端框架全面测评](https://zhuanlan.zhihu.com/p/59764741)
