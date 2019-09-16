---
layout: page
permalink: ./program-language/basic/type_conversion
---

## Type conversion
不同类型的值, 不容易放在一起运算, 因此编译器会把不同类型值转换成同种类型来运算.

> 1. promotion, 表达式里有符号和无符号的char和short类型都将自动被转换为int(也可能
>    是unsigned int); float 转换成double.
>
> 2. 两种数据类型的任何运算里, 两个值都被转换成两种类型里较高的级别.
>
> 3. 类型级别从高到低的顺序是long double, double, float, unsigned long long,
>    long long, unsigned long, long, unsigned int, int.
>
> 4. 在赋值语句里, 计算结果会转换成接收变量的类型, 有可能promotion; 也可能demotion
>
> 5. 函数参数中, short和char转换成int, float转换成double.

## cast operator

    mice = (int) 1.6 + (int) 1.7;
