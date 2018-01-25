---
layout: page
permalink: /program-language/kotlin/grammar
---

Grammar

### Variable And Constant

支持类型推导，可以根据初始化值类型来导推出类型，所以可以省略类型定义

    //变量
    var i: Int

    //常量
    val i: Int

### Control Flow
#### IF Expression
if是表达式，会返回一个值，括号最后一个表达式就是返回的值

    var a = if(a < b) a else b

    if () {
    } else if () {
    } else {
    }

#### WHEN Expression
when是表达式， 大括号中最后一个表达式就是返回值
when分支不是穿透的(Fallthrough)，不用使用break语句

        var a = when(d1){
            123.0 -> "小于"
            123.5 -> "大于"
            else -> "else"
        }

分支条件只能是常量或者Boolean值，多个条件使用','分隔，可以使用in is表达式

#### For Statement
C#类型的foreach，循环Iterator

Iterator:
    * 成员或扩展函数 iterator(), 返回type
    * 成员或扩展函数 next(), 返回boolean
    * 成员或扩展函数 hasNext(), 返回boolean
    * 这三个方法必须使用`operator`修饰

    for (item in collection) print(item)

    for (i in array.indices) {
        print(array[i])
    }

    for ((index, value) in array.withIndex()) {
        println("the element at $index is $value")
    }

#### While Statement

    while (x > 0) {
        x--
    }

#### Do..while Statement

    do {
        val y = retrieveData()
    } while (y != null) // y is visible here!

#### Jumpe

    break. 终止最近的封闭循环
    continue. 进入最近的封闭循环的下一步

Labels. 在循环前加上labelname@,可以控制指定的循环（内层终止外层）

    loop@ for (i in 1..100) {
        for (j in 1..100) {
            if (...) break@loop
        }
    }

### Founction And Lambda
#### Function

    fun read(b: Array<Byte>, off: Int = 0, len: Int = b.size): Int {
        ...
    }

    fun double(x: Int): Int = x * 2

infix Function:
* 成员函数或扩展函数
* 单个函数参数
* 使用`infix`修饰


    infix fun Int.shl(x: Int): Int {
    ...
    }

    // call extension function using infix notation

    1 shl 2

嵌套函数:

    fun dfs(graph: Graph) {
        fun dfs(current: Vertex, visited: Set<Vertex>) {
            if (!visited.add(current)) return
            for (v in current.neighbors)
                dfs(v, visited)
        }

        dfs(graph.vertices[0], HashSet())
    }

#### Lambda

    // 声明
    (T, T) -> Boolean

    // 定义
    { x: Int, y: Int -> x + y }

Anonymous Functions

    fun(x: Int, y: Int): Int = x + y

Function Literals with Receiver

    sum : Int.(other: Int) -> Int
    1.sum(2)

#### inline
内联函数 - 使用关键字`inline`修饰
非内联函数 - 使用关键字`noinline`修饰

    inline fun foo(inlined: () -> Unit, noinline notInlined: () -> Unit) {
        // ...
    }

#### Tail recursive functions

    tailrec fun findFixPoint(x: Double = 1.0): Double
        = if (x == Math.cos(x)) x else findFixPoint(Math.cos(x))


