---
layout: post
title: Android TextView
categories: android
tags: [android]
date: 2023-04-28
---

## Android TextView

### 画横线

    TextView tv = (TextView) findViewById(R.id. text_view ); 
    // 中间加横线 ， 添加Paint.ANTI_ALIAS_FLAG是线会变得清晰去掉锯齿
    tv.getPaint().setFlags(Paint.STRIKE_THRU_TEXT_FLAG | Paint.ANTI_ALIAS_FLAG ); 
    // 底部加横线 ， 添加Paint.ANTI_ALIAS_FLAG是线会变得清晰去掉锯齿
    tv .getPaint().setFlags(Paint. UNDERLINE_TEXT_FLAG | Paint.ANTI_ALIAS_FLAG );

    tv.setPaintFlags(tv.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);


## Reference
