---
layout: post
title: "Xcode优化问题"
categories: ios
tags: [xcode]
date: 2020-07-13
excerpt: "Xcode优化问题"
---

## Xcode优化问题(XXX was compiled with optimization - stepping may behave oddly; variables may not be available.)

Xcode 11.5 使用Release 编译项目, 并且Debug, 一些参数都是`nil`, 并且Log里提示
`was compiled with optimization - stepping may behave oddly; variables may    
not be available`  

这是因为Xcode会优化代码, Debug时会看起来很奇怪. 最直接的办法是把编译模式改成`DEBUG`  
还有就是关掉各个地方的编译优化选项(不推荐, 选项太多, 漏一个就是麻烦, 不好定位问题).



### Reference
['Project Name' was compiled with optimization - stepping may behave oddly; variables may not be available](https://stackoverflow.com/questions/32772573/project-name-was-compiled-with-optimization-stepping-may-behave-oddly-varia)
