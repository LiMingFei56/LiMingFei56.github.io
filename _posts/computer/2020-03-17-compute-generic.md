---
layout: post
title: "Lang 泛型编程"
categories: lang
tags: [lang]
date: 2020-03-17
---

## Lang 泛型编程

Generic编程就是不面对特定类型编程, 使得类, 接口, 方法可以处理广泛的类型. 最有代表性的是集合.

那么为什么需要使用泛型呢? 为什么不使用根类型如Java的Object, Kotlin的Any?

本质上JAVA VM类语言就是使用Object来实现泛型, 这个叫类型擦除(syntactic sugar). Java在编译阶段会
检查泛型类型是否匹配, 然后会把泛型类型都替换成Object, 不保留泛型类型信息, 当使用时自动类型转换把Object转换
成泛型类型.

1. 使用泛型比使用Object更安全, 编译阶段会检查所有插入类型是否匹配, 而且不用强制类型转换, 避免出错
2. 使得泛型使得代码更清晰, 代码里清楚的显示了处理类型
3. 因为是类型擦除, 所以有些泛型功能不能实现, 如Map<String, String>[] map, createClass<T>()
4. Java数组是协变的(Variance);

> 协变和逆变是研究泛型继承的关系:
> 如ClassB 是ClassA 的子类
    
    // 可以写成
    ClassA a = new ClassB();
    // 那么ClassB[] 是 ClassA[] 的子类吗
    ClassA[] aarr = new ClassB[10]; // 可以, 数组是协变的
    // 那么ArrayList<ClassB> 是 ArrayList<ClassA>的子类吗

### Variance
1. 当A≤B时有f(A)≤f(B)成立，则f(⋅)是协变（covariant）的, 是生产者
2. 当A≤B时有f(B)≤f(A)成立，则f(⋅)是逆变（contravariant）的, 是消费者
3. 当A≤B时上述两个式子均不成立，即f(A)与f(B)相互之间没有继承关系，f(⋅)是不变（invariant）的

Generic 创建<T>, 这个T是`不变`的, 那么T只接收本类型和其子类型.

Java 使用 use-site variance
Kotlin 使用 declaration-site variance
Dart 使用 declaration-site variance

### covariant

    B: A() // B继承A
    var a = A()
    var b = B()

    var listA = ArrayList<A>()
    var listB = ArrayList<B>()

    listA = listB // 编译报错

根据`Liskov替换原则`, B是A的子类, 那么listB应该也是listA的子类, listA = listB应该是正确的.
查看ArrayList中的addAll()方法定义, 可以看到`<? extends E>` 定义
协变(covariant), 用<? extends E>表示, 定义上界, 一般用于生产者, 使得上面listA = listB 成立.

### contravariant

    A a = new A();
    B b = new B();
    ArrayList<? super B> listB = new ArrayList<>();
    listB.add(b);
    listB.add(a); // 报错
        
    B a2 = listB.get(0); // 报错

    listB = new ArrayList<A>(); // 正确

逆变(contravariant), 用<? super E>表示, 定义下界, 一般用于消费者. 
add时因不知道E的上界, 所以只能添加E及E的子类型,
get时因不知道E的上界, 所以唯一确定的是Object, 那么读取一定需要强制转换


### 说明

    ClassA[] aarr = new ClassA[10];
    ClassB[] barr = new ClassB[10];
    aarr = barr; // OK

    // 协变
    ArrayList<ClassA> alist1 = new ArrayList<>();
    ArrayList<? extends ClassA> alist2 = new ArrayList<>();
    ArrayList<ClassB> blist = new ArrayList<>();
    alist1 = blist; // Error 不变
    alist2 = blist; // OK 设置协变就行
    alist1.addAll(blist); // OK  因为public boolean addAll(Collection<? extends E> c)

    ClassA a1 = alist1.get(0); // OK
    ClassA a2 = alist2.get(0); // OK
    ClassB b1 = alist2.get(0); // Error 因为不知道子类到底是哪个

    alist1.add(new ClassB()); // OK 当成ClassA
    alist1.add(new ClassA()); // Ok
    alist2.add(new ClassA()); // Error 不知道子类到底是哪个, 所以不能add 和 set
    alist2.add(new ClassB()); // Error 不知道子类到底是哪个, 所以不能add 和 set

    // 逆变
    ArrayList<ClassB> blist1 = new ArrayList<ClassA>(); // Error, 因为不变
    ArrayList<? super ClassB> blist3 = new ArrayList<ClassA>(); // OK, 逆变
    ArrayList<? super ClassB> blist4 = new ArrayList<ClassB>(); // OK

    a1 = blist3.get(0); // error, 因为不确定是哪个父亲类
    b1 = blist3.get(0); // error, 因为不确定是哪个父亲类

    a1 = blist4.get(0); // error, 因为不确定是哪个父亲类
    b1 = blist4.get(0); // error, 因为不确定是哪个父亲类

    blist3.add(a1);// error, 因为不确定是哪个父亲类
    blist4.add(a1);

    blist3.add(b1); // ok
    blist4.add(b1); // ok
    blist4.add(new ClassC()); // ok

> 不变可以传E和E的子类, 当E处理

> 协变使ArrayList<? extends ClassA> alist = new ArrayList<ClassB>(), 因为不知道最终的对象ArrayList<ClassB>, 
> 还是ArrayList<ClassC>, 所以不能添加对象(禁止get set函数), 可以get, 获取ClassA安全.
> 因为只能当ArrayList<ClassA>使用, 因此叫生产者, ClassA a = alist.get(0);

> 逆变使ArrayList<? super ClassC> blist = new ArrayList<ClassA>(), 因为不知道最终的对象是ArrayList<ClassA>,
> 还是ArrayList<ClassB>, 所以不能get对象, 添加对象可以添加ClassC和CLassC的子类(全当ClassC处理).
> 因为只能当ArrayList<ClassC>add 和 set, 所以叫消费者



### Reference
[What are the differences between “generic” types in C++ and Java?](https://stackoverflow.com/questions/36347/what-are-the-differences-between-generic-types-in-c-and-java)
[Liskov替换原则](https://en.wikipedia.org/wiki/Liskov_substitution_principle)
