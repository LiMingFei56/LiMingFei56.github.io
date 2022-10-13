---
layout: post
title: Java to Kotlin migration guides
categories: lang
tags: [lang]
date: 2022-10-06
---

##  Java to Kotlin migration guides

### String

* 连接字符串: 
    
    Java: "1" + "b"
    kotlin: "$a$b"

* 生成字符串:

    Java: StringBuilder
    kotlin: buildString() // 底层也是使用StringBuilder

* 通过集合创建字符串:

    Java: Stream API
    // Java
    List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);
    String invertedOddNumbers = numbers
            .stream()
            .filter(it -> it % 2 != 0)
            .map(it -> -it)
            .map(Object::toString)
            .collect(Collectors.joining(", "));
    System.out.println(invertedOddNumbers);

    kotlin: joinToString()
    // Kotlin
    val numbers = listOf(1, 2, 3, 4, 5, 6)
    val invertedOddNumbers = numbers
        .filter { it % 2 != 0 }
        .joinToString{ "${-it}" }
    println(invertedOddNumbers)

* 字符串设置默认值:

    Java: ternary operator
    kotlin: ifBlank()

    fun main() {
        val name = getName().ifBlank { "John Doe" }
        println(name)
    }

    fun getName(): String =
        if (Random.nextBoolean()) "" else "David"

* 替换字符:

    Java: replaceFirst() replaceAll()
    kotlin: removeSurrounding()

* 替换事件:

    Java: Patern, Matcher
    kotlin: Regex

* 分割字符串:

    Java: split()
    kotlin: split()

* 获取子字符串:
    
    Java: substring()
    kotlin: substringAfter()

* 多行字符串:

    Java: String.join
    Java15: text blocks """ """
    kotlin: """"""

### Collections

[Collections in Java and Kotlin](https://kotlinlang.org/docs/java-to-kotlin-collections-guide.html)  

### Nullability

## Reference
