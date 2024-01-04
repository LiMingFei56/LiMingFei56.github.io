---
layout: post
title: 网站收藏
categories: common
tags: [common]
date: 2023-07-17
---

## 网站收藏

### kids
+ [The 25 Best Educational YouTube Channels for Kids in 2023](https://www.familyeducation.com/school-learning/study-skills/the-25-best-educational-youtube-channels-for-kids)

### 工作
+ [圆领](http://www.yuanling.com/home)
+ [甜薪工厂]()
+ [电鸭]
+ [好快活]
+ [猪八戒]

widgetbook: ^3.3.0
A Flutter package that helps developers catalog their widgets, test them quickly on multiple devices and themes and share them easily with designers and clients. Inspired by Storybook.js.

configurations.all {
    resolutionStrategy {
        eachDependency {
            if ((requested.group == "org.jetbrains.kotlin") && (requested.name.startsWith("kotlin-stdlib"))) {
                useVersion("1.8.0")
        }
    }
}

file_selector: ^1.0.1
flutter pub add file_selector fixed

// org.jetbrains.kotlin:kotlin-bom artifact purpose is to align kotlin stdlib and related code versions.
// See: https://youtrack.jetbrains.com/issue/KT-55297/kotlin-stdlib-should-declare-constraints-on-kotlin-stdlib-jdk8-and-kotlin-stdlib-jdk7
implementation(platform("org.jetbrains.kotlin:kotlin-bom:1.8.10"))

## Reference
