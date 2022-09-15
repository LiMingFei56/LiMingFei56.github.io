---
layout: post
title: AndroidX
categories: android
tags: [android]
date: 2022-08-23
---

## AndroidX

> 如果要在新项目中使用命名空间为 androidx 的库，就需要将编译 SDK 设置为 Android 9.0（API 级别 28）
> 或更高版本，并在 gradle.properties 文件中将以下两个 Android Gradle 插件标志设置为 true。

* android.useAndroidX：该标志设置为 true 时，Android 插件会使用对应的 AndroidX 库，而非支持库。如果未指定，那么该标志默认为 false。
* android.enableJetifier：该标志设置为 true 时，Android 插件会通过重写其二进制文件来自动迁移现有的第三方库，以使用 AndroidX 依赖项。如果未指定，那么该标志默认为 false。


How are androidx and AndroidX related to Jetpack?

They are all the same thing! In a sentence, androidx is the packaging and AndroidX is the development workflow for all components in Jetpack. Jetpack is the external branding for libraries within androidx.

In more detail, Jetpack is the external branding for the set of components, tools, and guidance that improve the developer experience on Android. AndroidX is the open-source development project that defines the workflow, versioning, and release policies for ALL libraries included in Jetpack. All libraries within the androidx Java package follow a consistent set of API design guidelines, conform to SemVer and alpha/beta revision cycles, and use the Android issue tracker for bugs and feature requests.

## Reference
[AndroidX 概览](https://developer.android.google.cn/jetpack/androidx)  
