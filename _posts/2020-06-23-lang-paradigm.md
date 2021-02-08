---
layout: post
title: "Lang 编程范式"
categories: lang
tags: [lang]
date: 2020-06-23
---

## Lang 编程范式

### declarative vs imperative programming

* declarative - 声明式编程 what to do, not how to do it
* imperative - 命令式编程 how to do it, not what to do

> 不同抽象级别上使用的编程范式, declaretive 比 imperative 更高等一些, 只描述有哪些  
> 对象, 并且这些对象做什么. 背后会有一个解析器, 解析描述语句, 所以性能不太好.  
>
> imperative 更贴近底层, 关注一个算法或者一个问题, 一步步的解的步骤.  

### Procedural programming paradigm

> 过程式编程, 注重解题的步骤, 使用各种控制语句

### Object oriented programming

> 面向对象编程, 解题不是一个步骤, 而是交给一个符合这个问题解的对象, 对过发送消息,  
> 让这个对象来处理问题.

* Data Encapsulation: 数据封装, 对象运行中的状态, 都保存在对象的内部, 不能直接修改
* Abstract class: 提取类的通用行为和状态, 子类可以很方便继承, 子类继承是强耦合(Strong coupling)
* Interface: 类实现接口是松耦合(Loosely coupled), 如果不能把握抽象类中不变的行为,   
    那么最好使用接口.
* Inheritance: 子类继承父类, 继承行为, 构造函数, 状态. 可以重写父类的行为.
* Polymorphism: 一个类在不同形态下(继承自同一父类的不同子类)的行为不同.

### Parallel processing approach

> 使用多线程, 多进程编程的并行处理方式

### Logic programming paradigms

> 计算的抽象模型, 一般在人工智能中使用, 需要一个知识库和一个问题, 计算机根据模型  
> 和知识库来解问题.

### Functional programming paradigms

> 函数式编程关心数据的映射，命令式编程关心解决问题的步骤. 这种映射就是数学中的函数,  
> 将计算描述为一种表达式求值. 

特性: 
* Immutable: 变量的值是不变的
* Referential transparency: 函数返回值只依赖于输入值
* No Side Effect: 不改变运行状态, 函数不管运行多少遍, 输入值一样, 那么返回值一样.

* iterative: 在多次循环中计算结果
* recursive: 函数内部调用自身
* tail recursion: 对一般递归的优化
* Higher-order function: 参数和返回值可以是函数
* Lazy evaluation: 也叫call-by-need, 调用时才计算表达式的值
* Pattern Match: 
* Algebraic data type
* Partially Applied Functions
* Currying
* Closure
* Lambda: λ演算, 是一个匿名函数

Typed Racket



## Reference
[Visitor Pattern 与 Finally Tagless：解决表达式问题](https://zhuanlan.zhihu.com/p/53810286)

