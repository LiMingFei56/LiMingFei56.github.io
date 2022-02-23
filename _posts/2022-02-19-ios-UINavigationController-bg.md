---
layout: post
title: "UINavigationController 背景设置"
categories: ios
tags: [ios]
date: 2022-02-19
---

## UINavigationController 背景设置

	# ios 13 前
	self.navigationBar.barTintColor = C_THEME_2;//#2266EF;
	self.navigationBar.backgroundColor = C_THEME_2;
	self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
	self.navigationBar.tintColor = [UIColor whiteColor];
	self.navigationBar.shadowImage = [[UIImage alloc] init];
	self.navigationBar.translucent = YES;

	# ios 13 后
	if (@available(iOS 13.0, *)) {
			UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
			[appearance configureWithOpaqueBackground];
			appearance.backgroundColor = C_THEME_2;
			appearance.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
			appearance.largeTitleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
			
			self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
			self.navigationController.navigationBar.standardAppearance = appearance;
			self.navigationController.navigationBar.compactAppearance = appearance;
	}

### Reference

