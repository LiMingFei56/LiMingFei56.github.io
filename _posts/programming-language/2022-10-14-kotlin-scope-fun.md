---
layout: post
title: Scope functions
categories: lang
tags: [lang]
date: 2022-10-14
---

## Scope functions

> 可以在对象的上下文中执行代码块, 调用形成一个临时作用域, 在些范围内可以不带对象名称访问对象.
> 这个就叫`scope functions`

> `let`, `run`, `with`, `apply`, `also`
> 上面都是在对象上执行代码块, 不同的是这个对象如果在块中可用.

    Person("Alice", 20, "Amsterdam").let {
        println(it)
        it.moveTo("London")
        it.incrementAge()
        println(it)
    }

    val alice = Person("Alice", 20, "Amsterdam")
    println(alice)
    alice.moveTo("London")
    alice.incrementAge()
    println(alice)

[Function selection](https://kotlinlang.org/docs/scope-functions.html#function-selection)  
简短指南:
* Executing a lambda on non-null objects: let
* Introducing an expression as a variable in local scope: let
* Object configuration: apply
* Object configuration and computing the result: run
* Running statements where an expression is required: non-extension run
* Additional effects: also
* Grouping function calls on an object: with

> 不要过渡使用, 不要嵌套使用, 链接它们时要小心, 很容易混淆当前上下文对象和this或it的值.

### Distinctions

> let run with apply also
> extension 和 non-extension

#### The way to refer to the context object.
> 都可以使用`this`和`it`, 有一样的兼容性
> lambda receiver 使用`this`关键字, run with apply
> 一般使用域函数调用对象成员时使用, `this`关键字可以忽略. 忽略后不容易区分成员对象, 外部对象和函数

> lambda argument 使用`it`关键字, let apply
> 将上下文对象当参数传入, 如果没有指定实参名称, 就可以使用`it`. 

#### The return value.

* apply and also return the context object.
* let, run, and with return the lambda result.

### define the common usage style

#### let

> The context object is available as an argument (it). The return value is the lambda result.
> `let` can be used to invoke one or more functions on results of call chains.

#### with

> non-extension function: the context object is passed as an argument, but inside the lambda, it's available as a receiver (this). The return value is the lambda result.
> We recommend with for calling functions on the context object without providing the lambda result. In the code, with can be read as "with this object, do the following."


#### run

> The context object is available as a receiver (this). The return value is the lambda result.
> `run` does the same as with but invokes as let - as an extension function of the context object.
> `run` is useful when your lambda contains both the object initialization and the computation of the return value.

#### apply

> The context object is available as a receiver (this). The return value is the object itself.
> Use `apply` for code blocks that don't return a value and mainly operate on the members of the receiver object. The common case for apply is the object configuration. Such calls can be read as "apply the following assignments to the object."

#### also

> The context object is available as an argument (it). The return value is the object itself.
> `also` is good for performing some actions that take the context object as an argument. Use also for actions that need a reference to the object rather than its properties and functions, or when you don't want to shadow the this reference from an outer scope.

### takeIf and takeUnless

> 可以在调用链中嵌入对对象状态的检查
> takeif(takeUnless 反义) 如果`predicate`匹配那么返回上下文对象本身, 如果不匹配返回Null, 所以返回的是Nullable对象.

## Reference
[Scope functions](https://kotlinlang.org/docs/scope-functions.html)  
