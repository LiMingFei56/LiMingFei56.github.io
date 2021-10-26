---
layout: post
title: "Math Array and String"
categories: math
tags: [math]
date: 2021-01-12
---

## Math Array and String

### 集体

> 集合一般被定义为：由一个或多个确定的元素所构成的整体。

1. 集合里的元素类型不一定相同
2. 集合里的元素没有顺序

### 列表

> 列表（又称线性列表）的定义为：是一种数据项构成的有限序列，即按照一定的线性顺序
> ，排列而成的数据项的集合。

> 在编程语言中，列表最常见的表现形式有数组和链表，而我们熟悉的栈和队列则是两种
> 特殊类型的列表。除此之外，向列表中添加、删除元素的具体实现方式会根据编程语言
> 的不同而有所区分。

### 栈
> Last In First Out, LIFO 后进先出
> 插入和删除操作的一端称为栈顶(Top), 栈底(Bottom)
> 栈的存储结构: 1. 顺序存储; 2. 栈的链式存储; 3. 栈的应用

操作:
	1. InitStack(S)
	2. isEmpty(S)
	3. Push(S,x)
	4. Pop(S)
	5. Top(S)

### 队列
> First In First Out, FIFO 先进先出
> 允许插入元素的一端称为队尾(Rear), 允许删除元素的一端称为队头(Front)
> 队列的存储结构: 
	1. 队列的顺序存储
		> 循环队列, 如果非循环队列, 那么不能简单的入队修改队尾指针, 出队修改队头指针(需要移动内存内容)
		> 循环队列, 入队Q.rear = (Q.rear+1)%MAXSIZE, 出队Q.front = (Q.front+1)%MAXSIZE
		> 判断空和满状态, 1: 加个标识; 2: 空个空间(队尾下一个位置是队头指针时是满)
		> 如果入导致Q.rear=Q.front, 那么就是满状态; 如果出队导致Q.rear=Q.front, 那么就是空状态
	2. 队列的链式存储
	3. 队列的应用

操作:
	1. InitQueue(Q)
	2. isEmpty(Q)
	3. EnQueue(Q,x)
	4. DelQueue(Q)
	5. FrontQue(Q)

### 串
操作:
	1. StrAssign(s,t)
	2. Concat(s,t)
	3. StrLength(s)
	4. StrCompare(s,t)
	5. SubString(s,start,len)

> 串的存储结构: 1. 顺序存储; 2. 链式存储
> 串的模式匹配(子串定位): 
	1. 朴素的模式匹配算法(布鲁斯-福斯算法)
	2. 改进的模式匹配算法(KMP算法)

## Reference
[数组和字符串](https://leetcode-cn.com/leetbook/detail/array-and-string/)  

