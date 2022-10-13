---
layout: post
title: kotlin this
categories: lang
tags: [lang]
date: 2022-10-01
---

## kotlin this

To denote the current receiver, you use this expressions:

    * In a member of a class, this refers to the current object of that class.

    * In an extension function or a function literal with receiver this denotes the receiver parameter that is passed on the left-hand side of a dot.

If this has no qualifiers, it refers to the innermost enclosing scope. To refer to this in other scopes, label qualifiers are used:

> Qualified this `this@label`

> 如果有一个顶级函数签名与成员函数一样, 那么需要使用`this`, 不然会调用到顶级函数.



## Reference
