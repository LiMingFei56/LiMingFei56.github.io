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

### 语言链接性
函数签名使用参数列表(参数个数和参数类型)
fun Line_0.abc(kotlin.Int): kotlin.Unit

### Function Override And Overland
override - 需要父类声明方法为open，子类使用override关键字重写
overland - 需要保证函数签名不一样，
