---
layout: page
permalink: /program-language/java/grammar
---

Grammar

### Variable And Constant

    //变量
    int i;

    //常量
    final int i;

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

#### FOREACH Statement
Like C# foreach ，循环Iterator

Interator:
    * 实现Iterator接口

    for (item: <Iterator>){}

### Funciton And Lambda
#### Function

    public void myFunction(int a, int b){
    }

#### Lambda jdk 8
只支持functional interfaces（SAM(单一抽象方法/Single Abstract Method)），相当与匿名函数

    // 1. 不需要参数,返回值为 5
    () -> 5

    // 2. 接收一个参数(数字类型),返回其2倍的值
    x -> 2 * x

    // 3. 接受2个参数(数字),并返回他们的差值
    (x, y) -> x – y

    // 4. 接收2个int型整数,返回他们的和
    (int x, int y) -> x + y

    // 5. 接受一个 string 对象,并在控制台打印,不返回任何值(看起来像是返回void)
    (String s) -> System.out.print(s)

#### Inline
使用关键字`final`修饰的函数为内联函数

