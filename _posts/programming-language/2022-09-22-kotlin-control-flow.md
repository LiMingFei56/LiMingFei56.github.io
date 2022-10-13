---
layout: post
title: Kotlin Control Flow
categories: lang
tags: [lang]
date: 2022-09-21
---

## Kotlin Control Flow

> if 是表达式, 可以返回值

    val max = if (a > b) a else b

    val max = if (a > b) {
        print("Choose a")
        a
    } else {
        print("Choose b")
        b
    }


> when 是表达式, 可以返回值. 顺序匹配直到匹配值, 都不满足就用`else`分支
> 下面条件`else`分支是必须的

* when has a subject of an Boolean, enum, or sealed type, or their nullable counterparts.
* branches of when don't cover all possible cases for this subject.

> when 分支上可以有多个条件, 用`,`分隔, 条件是任何表达式. 支持in和!in操作, is和!is操作

    when (x) {
        in 1..10 -> print("x is in the range")
        in validNumbers -> print("x is valid")
        !in 10..20 -> print("x is outside the range")
        else -> print("none of the above")
    }


> For-in
> 实现`iterator next hasNext`三个操作, 就可以使用for-in
> for-in 支持`range`表达式
> for-in 支持 array, array.indices, array.withIndex


> while, do-while


> jump expression, 这些表达式可以做为其他表达式的一部分, 返回Nothing Type

* return
* break
* continue


> Break and continue labels

    loop@ for (i in 1..100) {
        for (j in 1..100) {
            if (...) break@loop
        }
    }

> Return to labels, 默认return返回外层的函数(lambda, 如果是匿名函数, 那么是返回匿名函数)
> lambda expression有`implicit labels`

    fun foo() {
        listOf(1, 2, 3, 4, 5).forEach lit@{
            if (it == 3) return@lit // local return to the caller of the lambda - the forEach loop
            if (it == 3) return@forEach // local return to the caller of the lambda - the forEach loop
            print(it)
        }
        print(" done with explicit label")
    }

    fun foo() {
        listOf(1, 2, 3, 4, 5).forEach(fun(value: Int) {
            if (value == 3) return  // local return to the caller of the anonymous function - the forEach loop
            print(value)
        })
        print(" done with anonymous function")
    }

    fun foo() {
        run loop@{
            listOf(1, 2, 3, 4, 5).forEach {
                if (it == 3) return@loop // non-local return from the lambda passed to run
                print(it)
            }
        }
        print(" done with nested loop")
    }

### Exception

> `Throwable` 异常的根类
> Kotlin没有检查异常, `@Throws`可以从别处调用kotlin时来提醒开发者.

    throw Exception("Hi There!") // 抛出异常, 是一个表达式, 返回Nothing Type

> try-catch 可以是表达式, 可以返回值, finally块不会影响返回值
> 如果代码正常, 那么返回try块最后的表达式
> 否则返回catch块最后的表达式

    try {
        // some code
    } catch (e: SomeException) {
        // handler
    } finally {
        // optional finally block
    }


## Reference
[Conditions and loops](https://kotlinlang.org/docs/control-flow.html)  
