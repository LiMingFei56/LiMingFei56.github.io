---
layout: post
title: "C语言指针"
categories: program
tags: [c]
date: 2020-07-08
excerpt: "C语言指针"
---

## C语言指针

### pointer and array

#### 不同点

##### int[][] vs int**

> C语言中多维数组也是使用顺序地址存储, 地址从低到高排列

```
    int a[2][2] = \{\{1, 2\}, \{3, 4\}\};
    // 内存地址 低地址位 1, 2, 3, 4 高地址位
```

a是一个指针, 保存值为'1'的地址; a[0]是一个指针, 也是保存值为'1'的地址.  
因此a = a[0]  

int** 是一个指针x, 指向另一个指针y, y指向int类型.   
如果`int** p = (int**) a;` 这样作的话, \*p 等于 1, 而\*\*p会把1当作地址作取值操作,   
因此会报错. `int** 不等价于 a[][] `.

需要创建指向多维数组的指针:

    1. 
    int a[2][2] = \{\{1, 2\}, \{3, 4\}\};
    int* p[2]; // '[]'比'*'优先级高, 因此这是创建数组p, 类型是指向int类型的指针 
    for (int i = 0; i < 2; i++) 
    {
        p[i] = a[i];
    }
    int** q = (int**) p;

    2. 
    int** p = (int**) malloc(sizeof(int*) * 4);
    for (int i = 0; i < 4; i++) 
    {
        p[i] = (int*) malloc(size(int) * 4); 
    }

### Reference

