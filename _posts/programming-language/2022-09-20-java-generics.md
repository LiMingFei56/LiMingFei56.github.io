---
layout: post
title: Java Generics
categories: lang
tags: [lang]
date: 2022-09-20
---

## Java Generics

> 约定使用单字符当类型参数的名称:
E — Element (used extensively by the Java Collections Framework)
K — Key
N — Number
T — Type
V — Value
S,U,V etc. — 2nd, 3rd, 4th types

T (Type) 具体的Java类
E (Element)在集合中使用，因为集合中存放的是元素
K V (key value) 分别代表java键值中的Key Value
N （Number）数值类型
? 表示不确定的 Java 类型

### 为什么使用泛型

* Stronger type checks at compile time.
* Enables programmers to implement generic algorithms.
* Elimination of casts.
* Generics are implemented using Type Erasure.

### 注意事项

* Generics are implemented using Type Erasure
* Generics does not support sub-typing
* You can’t create Generic Arrays
* Use of wildcards with extends or super to increase API flexibility
* Use of Multiple Bounds

### Multiple Bounds

    // 是Number子类 并且实现Comparable接口
    public static <T extends Number & Comparable<? super T>> int compareNumbers(T t1, T t2){return t1.compareTo(t2);}

### Wildcards

* 协变 上界通配符 生产者 Covariance < ? extends E> 可以传E和E的子类
* 逆变 下界通配符 消费者 Contravariance < ? super E> 可以传E和E的父类

### PESC

> PECS原则:生产者(Producer)使用extends,消费者(Consumer)使用super。

* 如果想要获取，而不需要写值则使用" ? extends T "作为数据结构泛型。
* 如果想要写值，而不需要取值则使用" ? super T "作为数据结构泛型。

    public class PESC {
        ArrayList<? extends Animal> exdentAnimal;
        ArrayList<? super Animal> superAnimal;
        Dog dog = new Dog("小黑", "黑色");

        private void test() {
            //正确 
            Animal a1 = exdentAnimal.get(0);
            //错误 
            Animal a2 = superAnimal.get(0);

            //错误 
            exdentAnimal.add(dog);
            //正确 
            superAnimal.add(dog);
        }
    }


## Reference
[Java Generics](https://medium.com/rico-ramos/java-generics-5da1455d5a31)  
[Java Generics Explained](https://medium.com/@darrenwedgwood/java-generics-explained-c18a929fcd68)  
[Restrictions on Generics](https://docs.oracle.com/javase/tutorial/java/generics/restrictions.html#instantiate)  
[Java: Producer Extends, Consumer Super](https://medium.com/@isuru89/java-producer-extends-consumer-super-9fbb0e7dd268)  
[Bounded Types with Generics in Java](https://www.geeksforgeeks.org/bounded-types-generics-java/)  
[Java 泛型中的通配符 ](https://www.cnblogs.com/qdhxhz/p/16396102.html)  
