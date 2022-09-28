---
layout: post
title: kotlin function
categories: lang
tags: [lang]
date: 2022-09-28
---

## kotlin function

* 使用`fun`声明函数
* 可以有默认值, 默认值如果在左边, 传参需要加参数名使用命名参数; 默认值都在右边, 传参可以不加参数名; 重写时总是
    使用基础函数的默认值, 重写时需要省略默认值.
* 支持命名参数, 不能使用命名参数调用Java代码
* `unit`表示无返回, 可以省略
* 单表达式函数, 当返回一个单表达式时, 可以省略大括号和返回值, fun double(x: Int): Int = x * 2
* `vararg` 可变数量参数, 最后封装成Array, 如果该参数不是最后一个, 就需要使用命名参数传递
* 支持spread operator (prefix the array with *): val a = arrayOf(1, 2, 3); val list = asList(-1, 0, *a, 4)
* 支持函数嵌套, 支持闭包(closure)
* 支持泛型函数 fun <T> singletonList(item: T): List<T> { /*...*/ }
* 支持tail recursion, 使用`tailrec`修饰函数, 如果符合尾递归, 编译器会优化成循环
* 使用`::`把一个对象的方法当函数传递, Int:times

### Infix notation

> 使用`infix`修饰的函数, 必须满足:

* They must be member functions or extension functions.
* They must have a single parameter.
* The parameter must not accept variable number of arguments and must have no default value.

    infix fun Int.shl(x: Int): Int { ... }
    1 shl 2

> infix操作优先级低于算术运算符, 类型转换, rangTo操作

### High-order functions and lambdas

> 高阶函数是以函数为参数或者返回值.
> 函数类型 (A, B) -> C
> 函数类型设置nullable, ((Int, Int) -> Int)?
> 函数类型可以联合 (Int) -> ((Int) -> Unit), 使用`right-associative` (Int) -> (Int) -> Unit == ((Int) -> (Int)) -> Unit

* All function types have a parenthesized list of parameter types and a return type: (A, B) -> C denotes a type that represents functions that take two arguments of types A and B and return a value of type C. The list of parameter types may be empty, as in () -> A. The Unit return type cannot be omitted.
* Function types can optionally have an additional receiver type, which is specified before the dot in the notation: the type A.(B) -> C represents functions that can be called on a receiver object A with a parameter B and return a value C. Function literals with receiver are often used along with these types.
* Suspending functions belong to a special kind of function type that have a suspend modifier in their notation, such as suspend () -> Unit or suspend A.(B) -> C.


实例化一个函数类型:
* Use a code block within a function literal, in one of the following forms:
*     a lambda expression: { a, b -> a + b },
*     an anonymous function: fun(s: String): Int { return s.toIntOrNull() ?: 0 }
* Function literals with receiver can be used as values of function types with receiver.
* Use a callable reference to an existing declaration:
*     a top-level, local, member, or extension function: ::isOdd, String::toInt,
*     a top-level, member, or extension property: List<Int>::size,
*     a constructor: ::Regex
* These include bound callable references that point to a member of a particular instance: foo::toString.
* Use instances of a custom class that implements a function type as an interface:

> A value of a function type can be invoked by using its invoke(...) operator: f.invoke(x) or just f(x)

### Lambda expressions

> function literals:  Lambda expressions 和 anonymous functions

    val sum: (Int, Int) -> Int = { x: Int, y: Int -> x + y }

* A lambda expression is always surrounded by curly braces.
* Parameter declarations in the full syntactic form go inside curly braces and have optional type annotations.
* The body goes after the ->.
* If the inferred return type of the lambda is not Unit, the last (or possibly single) expression inside the lambda body is treated as the return value.

> 如果函数最后一个参数是函数, 那么可以使用`Passing trailing lambdas`
> lambda表达式如果只有一个参数, 参数可以省略, 并且有隐匿`it`表示这个参数
> lambda表达式可以显示使用`return`返回, 也可以隐匿使用最后一个表达式返回
> LINQ-style strings.filter { it.length == 5 }.sortedBy { it }.map { it.uppercase() }
> lambda表达式中不使用的参数, 可以使用`_`占位

### Anonymous functions

> lambda表达式不能指定返回值类型, 使用匿名函数可以指定返回值.
> non-local returns. lambda返回是上层函数, 匿名函数返回是本身

    fun(x: Int, y: Int): Int = x + y

> 匿名函数参数和返回值类型如果可以上下文推断, 那么可以省略类型

    ints.filter(fun(item) = item > 0)

### Function literals with receiver

    A.(B) -> C

> kotlin提供函数字面值接收者类型, 可以使用接收者调用该函数.

    class HTML {
        fun body() { ... }
    }

    fun html(init: HTML.() -> Unit): HTML {
        val html = HTML()  // create the receiver object
        html.init()        // pass the receiver object to the lambda
        return html
    }

    html {       // lambda with receiver begins here
        body()   // calling a method on the receiver object
    }

### inline functions

> 高阶函数是一个对象, 并且捕获一个闭包. 内存分配和虚拟调用引入运行时开销.
> 大多上述情况可以使用内联lambda表达式解决

    inline fun <T> lock(lock: Lock, body: () -> T): T { ... }

    lock(l) { foo() }
    // 会转成
    l.lock()
    try {
        foo()
    } finally {
        l.unlock()
    }

> 内联有可能增长代码, 但在性能上获得回报

> 如果不想所有的lambda都内联, 可以使用`noinline`, 如果内联函数没有包含函数参数, 就会警告.
> 使用`@Suppress("NOTHING_TO_INLINE")`
> `break` 和 `continue` 不能在内联函数中使用.

    inline fun foo(inlined: () -> Unit, noinline notInlined: () -> Unit) { ... }

> 内联函数支持`reified type parameters`

    fun <T> TreeNode.findParentOfType(clazz: Class<T>): T? {
        var p = parent
        while (p != null && !clazz.isInstance(p)) {
            p = p.parent
        }
        @Suppress("UNCHECKED_CAST")
        return p as T?
    }
    treeNode.findParentOfType(MyTreeNode::class.java) // 不好看

    inline fun <reified T> TreeNode.findParentOfType(): T? {
        var p = parent
        while (p != null && p !is T) {
            p = p.parent
        }
        return p as T?
    }
    treeNode.findParentOfType<MyTreeNode>()

    inline fun <reified T> membersOf() = T::class.members

> Inline properties, 标注在accessors上就是getter或者setter内部, 标注在字段上就是getter和setter上都内联

> 如果内联函数是`public`或者`property`, 那么就是公共API内联函数. 如果内联函数修改, 但调用模块没有重新
> 编译, 会导致二进制不兼容

> `internal`内联函数, 使用`@PublishedApi`修饰成公共API内联函数.

### Operator overloading

> 使用`operator`关键字重写操作符, 如果是`override`函数, 那么operator可以省略

    +a a.unaryPlus()
    -a a.unaryMinus()
    !a a.not()

    a++ a.inc() + see below
    a-- a.dec() + see below

    a + b a.plus(b)
    a - b a.minus(b)
    a * b a.times(b)
    a / b a.div(b)
    a % b a.rem(b)
    a..b a.rangeTo(b)

    a in b b.contains(a)
    a !in b !b.contains(a)

    a() a.invoke()
    a(i) a.invoke(i)
    a(i, j) a.invoke(i, j)
    a(i_1, ..., i_n) a.invoke(i_1, ..., i_n)

    a += b a.plusAssign(b)
    a -= b a.minusAssign(b)
    a *= b a.timesAssign(b)
    a /= b a.divAssign(b)
    a %= b a.remAssign(b)

    a == b a?.equals(b) ?: (b === null)
    a != b !(a?.equals(b) ?: (b === null))

    a > b a.compareTo(b) > 0
    a < b a.compareTo(b) < 0
    a >= b a.compareTo(b) >= 0
    a <= b a.compareTo(b) <= 0

## Reference

