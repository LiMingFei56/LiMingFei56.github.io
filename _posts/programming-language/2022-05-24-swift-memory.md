---
layout: post
title: "Swift Memory"
categories: lg
tags: [lg]
date: 2022-05-24
---

## Swift Memory

> Automatic Reference Counting (ARC), Swift使用ARC管理对象.

### Strong Reference Cycles for Closures

#### Resolving Strong Reference Cycles for Closures

* weak reference
* unowned reference

> 都不会ARC计算
区别:
	* weak 修改可选类型, 当对象被释放会设置nil
	* unowned 一直需要有值, 当对象被释放后再访问, 会有异常

#### Strong Reference Cycles for Closures

> 闭包中的强引用循环, 当对象得到一个闭包, 闭包中引用这个对象.
> 打破闭包中的强引用循环, 使用`Capture List`, 捕获列表是一系列`weak`和`unowned`

		lazy var someClosure = {
				[unowned self, weak delegate = self.delegate]
				(index: Int, stringToProcess: String) -> String in
				// closure body goes here
		}

### Memory Safety

默认Swift会阻止不安全的内在访问:
1. 初始化前不能使用
2. 销毁后不能使用
3. 数组下标检查
4. Swift会自动管理内存, 大多数时间不用想内存多重访问冲突问题

#### Characteristics of Memory Access

符合下面两条就会产成内存冲突:
* At least one is a write access or a nonatomic access.
* They access the same location in memory.
* Their durations overlap.

> `instantaneous accesses` 瞬时访问, 访问中不会有任何代码. 本质上, 两个瞬时访问不会
> 同时发生. 大多数内存访问是瞬时的.

> `long-term accesses` 长期访问, 访问有可能会与其他的long-term accesses或者instantaneout 
> accesses 重叠`overlap`. 长期访问, 主要出现在fund输入输出参数, 或者mutating fund中.

#### atomic operations

> An operation is atomic if it uses only C atomic operations; otherwise it’s
> nonatomic. For a list of those functions, see the stdatomic(3) man page.



### Reference
[Automatic Reference Counting](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html)  
[Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html)  
[Transitioning to ARC Release Notes](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)  
[What Is the Difference Between Weak and Unowned References in Swift](https://cocoacasts.com/what-is-the-difference-between-weak-and-unowned-references-in-swift)  
