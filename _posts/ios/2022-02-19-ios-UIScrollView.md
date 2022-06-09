---
layout: post
title: "UIScrollView"
categories: ios
tags: [ios]
date: 2022-02-19
---

## UIScrollView

1. 先设置约束
2. 在Xcode 11, ScrollView 提供了Content Layout Guide 和 Frame Layout Guide, 默认打开
	, 可以在Size Inspector中关闭Content Layout Guides

### Content Layout Guide 和 Frame Layout Guide

	Frame Layout guide: 需要设置与父视图的约束  position (x, y) and size (width, height) 
	Content Layout guide: 需要设置内容的大小约束

	1. 拖个UIView到UIScrollView中, View到Content Layout guide设置 leading / top / trailing / bottom 约束为0
	2. View到Frame Layout guide, 设置Equal Widths, 比例为1:1
	3. 现在只剩下高度设置了

### Reference
[How to use scroll view in Interface Builder / Storyboard (Xcode 11)](https://fluffy.es/scrollview-storyboard-xcode-11/)  
