---
layout: post
title: "iOS 反编译"
categories: ios
tags: [ios]
date: 2020-06-03
---

## iOS 反编译

    unzip *.ipa

### 使用iOS App内的素材

> ipa解压后, 可以在./Payload/*.app/ 中看到图片素材. 这些图片不能直接使用, 因为编译时  
> xcode对资源文件做了处理, 需要使用`pngcrush`工具转换回来.

    /Applications/Xcode.app/Contents/Developer/usr/bin/pngcrush \
        -revert-iphone-optimizations ${pngfile} ${target_pngfile}

> 如果是使用Image Assets管理的图片, 都会保存到Assets.car中, 可以使用`cartool`, 解压  
> Assets.car. [cartool github](https://link.jianshu.com/?t=https://github.com/steventroughtonsmith/cartool)
