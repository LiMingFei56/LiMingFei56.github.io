---
layout: page
permalink: /program-language/objective-c/grammar
---

Grammar

### Variable And Constant

定义是特殊的声明，会分配内存并初始化；

    // 变量
    int i;
    extern int i;
    static int i;

    // 常量
    const int i;
    extern const int i;
    static const int i;

    #define i 123;

### Control Flow

#### IF Statement

    if () {
    } else if() {
    } else {
    }

#### SWITCH Statement
switch的分支是可以穿透的(Fallthrough)，需要使用`break`语句来打断穿透

    switch(){
        case :
            break;
        default:
            break;
    }

#### FOR Statement

    for( ; ;){}

#### WHILE Statement

    while(){}

#### DO-WHILE Statement

    do{}while();

#### Jumps

    break 打断穿透；跳出当前循环
    continue 路过当前循环，并开始下一次

### Function And Lambda
#### Function

    // 函数声明
    -(return_type)function_name:(one_parameter_type)one_parameter_name two_argument_label:(two_parageter_type)two_parageter_name;

    // 函数定义
    -(return_type)function_name:(one_parameter_type)one_parameter_name two_argument_label:(two_parageter_type)two_parageter_name{
    }

#### Block

    // Block 声明
    double (^multiplyTwoValues)(double, double);

    // Block 定义
    ^ (double firstValue, double secondValue) {
        return firstValue * secondValue;
    }

    使用__block修饰closure中变量的值，不然是只读的

#### Inline
使用inline修饰的函数为内联函数

