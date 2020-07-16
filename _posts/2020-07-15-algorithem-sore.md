---
layout: post
title: "排序"
categories: algorithm
tags: [sore]
date: 2020-07-15
excerpt: "排序"
---

## 排序

### 内排序
冒泡排序 O(n^2)
选择排序 O(n^2)
插入排序 O(n^2)
希尔排序 O(n^1.5)
快速排序 O(N*logN)
归并排序 O(N*logN)
堆排序 O(N*logN)
基数排序 O(d(n+r))

#### 冒泡排序(BubbleSort)

基本思想：两个数比较大小，较大的数下沉，较小的数冒起来。
过程：
    1. 比较相邻的两个数据，如果第二个数小，就交换位置。
    2. 从后向前两两比较，一直到比较最前两个数据。最终最小数被交换到起始的位置，  
        这样第一个最小数的位置就排好了。
    3. 添加flag标志位, 当前有无交换, 如果无交换, 证明已经排好.
    4. 继续重复上述过程，依次将第2.3...n-1个最小数排好位置。

#### 选择排序(SelectionSort)

基本思想：两个数比较大小，较大的数下沉，较小的数冒起来。


#### 

### 外排序
双层桶
Bitmap
多路归并排序
两两归并排序

### Reference
[排序算法总结](https://www.runoob.com/w3cnote/sort-algorithm-summary.html)
