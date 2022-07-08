---
layout: post
title: "iOS 通知"
categories: ios
tags: [ios]
date: 2022-06-28
---

## iOS 通知
> iOS有两套通知API, iOS10前使用UILocalNotification, 以后使用UNUserNotificationCenter.

UILocalNotification, iOS8以后应用需要`registerUserNotificationSettings:`函数注册通知.

    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
         UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
         UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
         [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }

UNUserNotificationCenter, iOS10使用`requestAuthorizationWithOptions:`函数注册通知.

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];

    接受UNUserNotificationCenterDelegate代理.

当iOS10以后, 当应用在前台, 通知默认是不显示的.  显示通知实现`UNUserNotificationCenterDelegate`代理
`userNotificationCenter`函数

      - (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
          completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound); 
      }

## Reference
[User Notifications](https://developer.apple.com/documentation/usernotifications)  
[iOS8 本地推送 UILocalNotification](https://www.jianshu.com/p/bf5ab8ecd06e)  
[iOS10 本地推送 UNUserNotificationCenter](https://www.jianshu.com/p/bed37cfe7386)  
