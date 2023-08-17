---
layout: post
title: android img 
categories: aosp
tags: [aosp]
date: 2022-09-30
---

## android img 

### How to Create Bitmap From View in Android?

    RelativeLayout relativeLayout = (RelativeLayout) LayoutInflater.from(mContext.get()).inflate(R.layout.widget_week_cal_item, null);
    int width = getItemWidth();
    int height = getPx(20);

    relativeLayout.layout(0, 0, width, height);

    int measuredWidth = View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY);
    int measuredHeight = View.MeasureSpec.makeMeasureSpec(height, View.MeasureSpec.EXACTLY);

    relativeLayout.measure(measuredWidth, measuredHeight);
    relativeLayout.layout(0, 0, relativeLayout.getMeasuredWidth(), relativeLayout.getMeasuredHeight());


    TextView tvDate = relativeLayout.findViewById(R.id.tv_date);
    tvDate.setText(formatDate(calendarDayData.getDate(), "d"));

    Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
    Canvas canvas = new Canvas(bitmap);
    relativeLayout.draw(canvas);

## Reference
[system.img,userdata.img,ramdisk.img,recovery.img,cache.img,boot.img关系解析](https://blog.csdn.net/u013372900/article/details/54862787)  
[Customized Android firmware](https://wiki.t-firefly.com/en/AIO-3399J/customize_android_firmware.html)  
[Introduction and use of Android ramdisk. IMG system. IMG userdata. img](https://topic.alibabacloud.com/a/introduction-and-use-of-android-font-classtopic-s-color00c1deramdiskfont-img-system-img-userdata-img_1_21_31782552.html)  
[[GUIDE][Linux/Win] How to unpack system_1.img+system_2.img+...+system_*.img | 2019](https://forum.xda-developers.com/t/guide-linux-win-how-to-unpack-system_1-img-system_2-img-system_-img-2019.3567741/)  
