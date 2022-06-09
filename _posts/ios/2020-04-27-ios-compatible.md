---
layout: post
title: "iOS 系统兼容"
categories: ios
tags: [ios]
date: 2020-04-27
---

## iOS 系统兼容

### 9.0

#### 1. Safe Area Layout Guide before ios 9.0

> 9.0 前使用`Top Layout Guide`和`Bottom Layout Guide`进行约束, 11中被弃用
> , 9.0 使用`Safe Area`. 
>
> 为了兼容8.0, 需要使用`Top Layout Guide` 和 `Bottom Layout Guide`

    1. storyboard中选择ViewController
    2. File inspector中`Builds for` 选择 `iOS 9.0 and Later`
    3. 去掉`Use Safe Area Layout Guides`

### 11.0

#### 1. WKWebView before iOS 11.0 (NSCoding support was broken in previous versions)

> Webkit framework是iOS 8, macOS 10.10中引入的, 用来取代UIWebView和WebView
> 但是8.0中在storyboard中使用WkWebView报错, 需要在代码中创建

### 13.0

#### 1. TextField [setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"]

	版本13不能使用`forKeyPath`访问修改对象内容实现

1. 使用runtime

	Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
	UILabel *placeholderLabel = object_getIvar(textField, ivar);
	placeholderLabel.textColor = [UIColor whiteColor];

2. 使用attributedPlaceholder

	let textField = UITextField()
	textField.frame = CGRect(x: 0, y: 100, width: 300, height: 50)
	let placeholderString = NSAttributedString.init(string: "UITextField Demo", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
	textField.attributedPlaceholder = placeholderString
	view.addSubview(textField)

#### 2. ASSETCATALOG_COMPILER_APPICON_NAME

> xcode 中AppIcons 和 LaunchImages 可以直接指定文件. 现在LaunchImages不能, 可以手动
> 指定.

		Project Targets -> Build Settings -> Asset Catalog Compiler - Options
		// 设置启动页
		ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME = LaunchImage
		// 设置图标
		ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon


