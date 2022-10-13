---
layout: post
title: kotlin null safety
categories: lang
tags: [lang]
date: 2022-10-01
---

## kotlin null safety

kotlin中产生NPE的原因:
    * 显示调用`throw NullPointerException()`
    * 使用`!!`调用null引用
    * 使用未正确初始化的引用
        - a leaking this
        - 超类构造函数中使用在子类初始化的`open member` 
    * Java集成
        - 访问null引用
        - java把null添加到kotlin MutableList<String>
        - 由外部java 代码

避免使用null:
    1. 显示使用if检查null, 变量需要是不可变的(保证使用时变量值不是null), 编译器会跟踪检查信息. 
    2. Safe calls `?.`, 支持调用链, 调用链可以用于左值, 也可以用于右值
    3. `let`操作, 可以忽略null
    4. 使用`if b is not null`, 或者Elvis操作`?:`
    5. not-null assertion operator `!!`
    6. 集合可以使用`filterNotNull()`过滤空对象
    
    

## Reference
