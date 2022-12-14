---
layout: post
title: 计算两个坐标的距离
categories: math
tags: [math]
date: 2022-12-06 
---

## 计算两个坐标的距离

### 1. 地球是圆的, 取弧线的长度

    # dart
    import 'dart:math' show cos, sqrt, asin;
    double calculateDistance(lat1, lon1, lat2, lon2){
       var p = 0.017453292519943295;
       var c = cos;
       var a = 0.5 - c((lat2 - lat1) * p)/2 + 
             c(lat1 * p) * c(lat2 * p) * 
             (1 - c((lon2 - lon1) * p))/2;
       return 12742 * asin(sqrt(a));
    }

### 2. 使用geolocator

    

## Reference
+ [Total distance calculation from LatLng List](https://stackoverflow.com/questions/54138750/total-distance-calculation-from-latlng-list)
+ [Flutter Geolocator Plugin](https://pub.dev/documentation/geolocator/latest/)
+ [latlong lib](https://pub.dev/packages/latlong)
