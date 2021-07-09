---
layout: post
title: "Flutter Engine crashes due to 'Failed to setup Skia Gr context"
categories: flutter
tags: [flutter]
date: 2020-06-29
---

## Flutter Engine crashes due to 'Failed to setup Skia Gr context

flutter 在 android 4.1 4.2 上运行报错`Failed to setup Skia Gr context`

[Engine crashes due to 'Failed to setup Skia Gr context' #51447](https://github.com/flutter/flutter/issues/51447)

flutter开发者说: 有可能是ARM skia运行在x86平台上导致的.

临时解决方案: futtler run `--enable-software-rendering`

##     error: Unexpected duplicate tasks: 1) Target 'flutter_dong_scan' (project 'Pods') has copy command from

[Build Fails](https://github.com/AmolGangadhare/flutter_barcode_scanner/issues/37)  


### Reference
