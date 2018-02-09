---
layout: page
permalink: /program-language/java/funcation
---

Funcation

### Lambda

### Funciton And Lambda
#### Function

    public void myFunction(int a, int b){
    }

#### Lambda jdk 8
JAVA中没有代理和闭包的特性，所以为了支持Lambda就使用匿名对象来实现，因此
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

### 语言链接性 Language Linking
跟C++很想，也是使用参数列表来生成独特的函数签名
public void com.test.A.function(int,int)
public void com.test.A.function(double)
public void com.test.A.function(int)

### Funcation override And overland
override时，要跟父类的方法签名相同，并且使用@Override注解

overland时，需要确保方法签名不同，并且使用@Overland注解

