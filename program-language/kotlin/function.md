---
layout: page
permalink: /program-language/kotlin/funcation
---

Funcation

### Function type

    // 声明函数类型 
    (T, T) -> Boolean 为带2个T类型的参数，返回为Boolean的函数

    // 实现函数类型
    {x, y -> x + y} 使用lambda实现有2个类型的参数的函数

    // 使用函数来实现函数类型
    var func: (Int, Int) -> Int = ::myFunc

    fun myFunc(a: Int, b: Int): Int{
        return a + b
    }
