---
layout: page
permalink: /program-language/c/funcation
---

Funcation

### Function Type

    // 声明函数类型
    (void(*)()), 为无参，无返回值的函数类型

    char * const * (*next)(); next为一个指向函数的指针，无参，返回类型为指向一个类型为char的常量指针

### 语言链接性 Language Linking
一个名称是对应一个函数，为了满足内部需求，编译器可能将spiff这样的函数名翻译为_spiff，这种方法
叫做C语言的语言链接性。

所以C语言没有函数重载
