---
layout: page
permalink: /program-language/swift/funcation
---

Funcation

### Function Type
    // Closures
    { (parameters) -> return type in
        statements
    }

    // 声明函数类型
    (Int, Int) -> Int 2个int参数，返回为Int的函数类型

    // 实现
    { (s1: Int, s2: Int) -> Int in return s1 + s2} 使用Closures实现
    
    var mathFunction: (Int, Int) -> Int = addTwoInts
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

### Selector

    在swift2.2前使用Selector("method")方法，但是这个方法容易造成输入错误。
    在swift2.2后使用#selector对应objc@selector。

    class Thing {
    ...
    func doStuff(stuff: Int) {
        print("do Stuff \(stuff)")
    }

    func doStuff(stuff: Double, fluffy: String) {
        print("do Stuff \(stuff) - \(fluffy)")
    }

    #selector(Thing.doStuff(_:fluffy:)))

### 语言链接性 Language Linking
根据参数列表生成函数签名，跟参数描述、个数有关，跟参数类型无关

### Function Override And Overland
override - 需要使用关键字override
overland - 保证函数签名不同
