---
layout: page
permalink: /program-language/swift/funcation
---

Funcation

### Function Type

    // 声明函数类型
    (Int, Int) -> Int 2个int参数，返回为Int的函数类型

    // 实现
    { (s1: Int, s2: Int) -> Int in return s1 + s2} 使用Closures实现
    
    var mathFunction: (Int, Int) -> Int = addTwoInts
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
