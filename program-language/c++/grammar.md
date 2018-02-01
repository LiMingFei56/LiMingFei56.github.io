---
layout: page
permalink: /program-language/c++/grammar
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

### Initialization

#### list-inisialization

    int i = {};  //  初始化为0, 不会转换类型

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

    // 函数原型，声明在头文件中
    <return_type> function_name(parameter_list);

    // 定义需要跟函数原型的参数类型和返回类型一至,收用函数原型的头文件
    <return_type> function_name(parameter_list){
    }

#### inline
使用inline修饰的函数为内联函数

