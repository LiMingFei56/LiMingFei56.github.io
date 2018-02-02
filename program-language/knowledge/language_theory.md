---
layout: page
permalink: /program-language/knowledge/language_theory
---

## Language Theory

### 左值和右值
左值(L-value) - 一个指向存储位置的值，可能允许新值被赋值，或为一个变量提供可访问
    的内存地址，该变量可以被写入数据，它被称为位置值。L表式Location。

右值(R_value) - 一个独立于存储位置的值，存储在内存中的某个位置的变量的数据值。R表式Read

### 副作用和顺序点
副作用(side effect) - 计算表达式时对某些东西（如存储在变量中的值）进行了修改。
顺序点(sequence point) - 程序执行过程中的一个点，在这里，进入下一步之前将确保对
    所有的副作用都进行了评估。在C++中，语句中的分号就是一个顺序点。
