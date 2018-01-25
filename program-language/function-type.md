---
layout: page
permalink: /program-language/function-type 
---

Function Type

### C

C语言声明的优先级规则
A 声明从它的名字开始读取，然后按照优先级顺序依次读取
B 优先级从高到低依次是：
    B. 1 声明中被括号括起来的那部分
    B. 2 后缀操作符：
            括号()表示这是一个函数，而
            方括号[]表示这是一个数组
    B. 3 前缀操作符： 星号*表示 “指向...的指针”
C 如果const和(或)volatile关键字的后面紧跟类型说明符(如int,long等)，那么它
  作用于类型说明符。在其他情况下，const和(或)volatile关键字作用于它左边紧
  邻的指针星号。

    (*(void(*)())0))();
    1. 使用()来调用函数

    (*(void(*)())0))
    2. void (*f)(); 表示f是一个指向无参数，无返回值的函数指针
       (void(*)())  表示无参数，无返回值的函数类型

    (*0)(); 并不能生效，因为*操作符必须要有一个指针做为操作数，而且必须是函数指针才
    能调用


### Objective-c

Block

    // 声明类型
    (void (^_blockname_)(void)) 无参数，无返回值的block类型
    (double (^_blockname_)(double, double)) 2个double参数, 返回double的block类型

    // 实现
    ^{} 实现无参数，无返回值的block

    实现两个double参数，double返回值的block
    ^ (double firstValue, double secondValue) {
        return firstValue * secondValue;
    }


