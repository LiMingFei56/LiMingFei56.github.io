---
layout: post
title: "Android Studio下载jar包"
categories: android
tags: [make]
date: 2020-03-11
excerpt: "Android Studio下载jar包"
---

## Android Studio下载jar包
Android Studio下载kotlin-compiler-embeddable 非常慢， 时间长了还会报read time out

所以需要自行下载后， 把jar放到正确的位置.

https://jcenter.bintray.com/org/jetbrains/kotlin/kotlin-compiler-embeddable/1.2.31/kotlin-compiler-embeddable-1.2.31.jar

Mac系统默认下载到：/Users/(用户名)/.gradle/caches/modules-2/files-2.1

Windows系统默认下载到：C:\Users\(用户名)\.gradle\caches\modules-2\files-2.1

classpath "org.jetbrains.kotlin:kotlin-gradle-plugin