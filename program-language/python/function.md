---
layout: page
permalink: /program-language/python/funcation
---

Funcation

### 语言链接性 Language Linking

    def myFunc(a: int, b: int) -> int:
        a + b

    print(myFunc.__annotations__)

    {'a': <class 'int'>, 'b': <class 'int'>, 'return': <class 'int'>}

根据函数名生成的签名，所以不支持重载，后定义的覆盖先定义的

### Function Override And Overland
override - 保证函名签名一样
overland - 不支持
