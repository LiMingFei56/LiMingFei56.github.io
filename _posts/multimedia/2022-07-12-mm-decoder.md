---
layout: post
title: 解码
categories: mm
tags: [mm]
date: 2022-07-12
---

## 解码

* 硬解码: 使用非CPU芯片解码, 低码率画质较差
* 软解码: 使用CPU解码, 高画质有些力不从心

|      | 画质 | 性能 | 内存消耗 | 支持格式 | 流畅度 | 总耗能 |
|------|------|------|----------|----------|--------|--------|
|硬解码|  高  | 优   |    低	  |     少   |  好    |   低   |
|软解码|  高  | 差   |    高    |   无限制 |  坏    |   高   |


### Android

> Android软解码器通常使用"OMX.google*"开头, 硬解码器通常使用"OMX*"开头,
> 部分软解码也会使用"OMX*"开头.

见: /system/etc/media_codecs.xml

Android硬解码使用`MediaCodec`

### iOS

iOS硬解码使用`VideoToolbox`



## Reference
[FFmpeg HWAccelIntro](https://trac.ffmpeg.org/wiki/HWAccelIntro)  
[FFmpeg 调用 Android MediaCodec 进行硬解码（附源码）](https://www.jianshu.com/p/e437354edfee)  
[FFmpeg添加MediaCodec硬编码](https://www.jianshu.com/p/c3916b2b8c64)  
[Comparison Between Hardware Decoding and Software Decoding](https://www.kiloview.com/en/comparison-between-hardware-decoding-and-software-decoding/)  
