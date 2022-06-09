---
layout: post
title: "iOS 自定义View"
categories: ios
tags: [ios]
date: 2022-03-02
---

## iOS 自定义View

### 通过Xib创建View

#### 1. NSBundle

	[[NSBundle mainBundle] loadNibNamed:@"TestView" owner:self options:nil] 

> loadNibNamed后需要把contentView添加到当前View, View结构不会创建, 所以当前view是空的

	[[NSBundle mainBundle] loadNibNamed:@"XPDTaskOperatorItemV" owner:self options:nil];
	[self addSubview:_contentView];
	_contentView.frame = self.bounds;
	_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;


#### 2. UINib
	let view = UINib(nibName: "CustomView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! UIView
	view.frame = self.view.bounds
	self.view.addSubview(view)


### Reference
[iOS Custom UIView from .xib](https://medium.com/monstar-lab-bangladesh-engineering/ios-custom-uiview-from-xib-7b02cc05f75c)  
[Swift — Creating a Custom View From a XIB (Updated for Swift 5)](https://betterprogramming.pub/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960?gi=86623702a655)  
[Custom UIView subclass from a xib file](https://theswiftdev.com/custom-uiview-subclass-from-a-xib-file/)  
