---
layout: post
title: Android Dialog自定义大小
categories: [android]
tags: [imm]
date: 2019-02-25
---

## Android Dialog自定义大小
Dialog计算View的内容来决定大小

### 改变Dialog大小 
需要在show()后调用

    alertDialog.show(); // 需要在show()后调用

    WindowManager.LayoutParams params = alertDialog.getWindow().getAttributes();
    params.width = DensityUtil.dip2px(300);
    params.height =  DensityUtil.dip2px(800);
    alertDialog.getWindow().setAttributes(params);