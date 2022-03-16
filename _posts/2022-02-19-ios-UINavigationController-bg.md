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


		UIColor *bgcolor = isWhite ? [UIColor whiteColor] : C_THEME_2;
    UIColor *fontcolor = isWhite ? [UIColor blackColor] : [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setTintColor:fontcolor];
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        [appearance setBackgroundColor:bgcolor];
        [appearance setBackgroundEffect:nil];
        appearance.titleTextAttributes = [NSDictionary dictionaryWithObject:fontcolor forKey:NSForegroundColorAttributeName];
        appearance.largeTitleTextAttributes = [NSDictionary dictionaryWithObject:fontcolor forKey:NSForegroundColorAttributeName];
        
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = [appearance copy];
        self.navigationController.navigationBar.compactAppearance = [appearance copy];
        
        if (@available(iOS 15.0, *)) {
            self.navigationController.navigationBar.compactScrollEdgeAppearance = [appearance copy];
        }
    } else {
        self.navigationController.navigationBar.barTintColor = bgcolor;//#2266EF;
        self.navigationController.navigationBar.backgroundColor = bgcolor;
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:fontcolor forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.tintColor = fontcolor;
    }


### 

	- (void)hiddenNavigationBarUnderImageView:(BOOL)isHidden {
    if (!self.navigationController || !self.navigationController.navigationBar) {
        return;
    }
    
    UIImageView *underImageview = [self findNavigationBarUnderImageView:self.navigationController.navigationBar];
    if (underImageview)
        underImageview.hidden = isHidden;
		}

		- (UIImageView *)findNavigationBarUnderImageView:(UIView *)view {
				if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
						return (UIImageView *)view;
				}
				
				for (UIView *subview in view.subviews) {
						UIImageView *imageView = [self findNavigationBarUnderImageView:subview];
						if (imageView) {
								return imageView;
						}
				}
				return nil;
		}

### Reference

