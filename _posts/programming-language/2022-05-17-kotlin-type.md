---
layout: post
title: Kotlin Type
categories: lang
tags: [lang]
date: 2022-05-17
---

## Kotlin

### Type

> 打印对象类型

    val obj: Double = 5.0

    println(obj.javaClass.name)                 // double
    println(obj.javaClass.kotlin)               // class kotlin.Double
    println(obj.javaClass.kotlin.qualifiedName) // kotlin.Double
    println(obj::clsss.simpleName)              // kotlin.String? = Double

> 反射class对比

    // kotlin class
    class Person {
        var name: String = ""
        var age: Int = 0
    }

    // Java class
    public class Cat {

    }

    println("person::class=${person::class}")//得到的是KClass<Person>和Person::class一样
    println("person::class.java=${person::class.java}")//得到的是Class<Person>对象
    println("person::javaClass=${person::javaClass}")//未知？
    println("person.javaClass.kotlin=${person.javaClass.kotlin}")//得到的是Class<Person>对象
    println("cat.javaClass.kotlin=${cat.javaClass.kotlin}")//拿到的是KClass
    println("Cat::class.java=${Cat::class.java}")//得到的Class<Cat>
    println("cat.javaClass == Cat::class.java=${cat.javaClass == Cat::class.java}")//Class<Cat>==Class<Cat>
    println("person.javaClass == Person::class.java=${person.javaClass == Person::class.java}")//Class<Person>==Class<Person>
    println("person.javaClass.kotlin == Person::class=${person.javaClass.kotlin == Person::class}")//KClass<Person>==KClass<Person>
    println("cat.javaClass.kotlin == Cat::class=${cat.javaClass.kotlin == Cat::class}")//KClass<Cat>==KClass<Cat>

> kotlin 传参, 赋值时没有隐式类型转换, 参数接收Double, 就不能传Int 和 Float
> kotlin 表达式中会有上下文类型推断, 所以不需要显示转换类型 `val l = 1L + 3 // Long + Int => Long`
> JVM 中如果是nullable, 那么用Integer, Double保存; 如果是nonnull, 那么用int, double保存
> Nullable的引用同样的number, 可能是不一样的对象. -128到127的数据是同一个对象, 因为JVM做的优化. 这不适用于10000 

> 类型检查

> is 和 !is // !is是is的否定, 支持智能转换(Smart casts is-checks), 支持`&&`和`||`操作, 
> Smart casts支持`when`表达式和`while`循环
    
    fun demo(x: Any) {
        if (x !is String || x.length == 0) return

        if (x is String) {
            print(x.length) // x is automatically cast to String
        }
    }

Smart casts使用条件:
* val local variables - always, with the exception of local delegated properties.
* val properties - if the property is private or internal or if the check is performed in the same module where the property is declared. Smart casts cannot be used on open properties or properties that have custom getters.
* var local variables - if the variable is not modified between the check and the usage, is not captured in a lambda that modifies it, and is not a local delegated property.
* var properties - never, because the variable can be modified at any time by other code.

> "Unsafe" cast operator, 不安全转换, 转换失败会抛异常

    val x: String = y as String // y == null, 会抛异常
    val x: String? = y as String? // y == null, 不会抛异常

> "Safe" (nullable) cast operator, 转换失败返回null

    val x: String? = y as? String


> Nothing Type 标记为永远不会到达的对象, 遇到这个值后代码不会继续执行


#### Number

* Integer types
    Byte
    Short
    Int default
    Long

* Floating-point types (IEEE 754 standard)
    Float
    Double default

* Literal constants for numbers(不支持8进制)
    * Decimals: 123
        *Longs are tagged by a capital L: 123L
    * Hexadecimals: 0x0F
    * Binaries: 0b00001011
    * Doubles by default: 123.5, 123.5e10
    * Floats are tagged by f or F: 123.5f
    * 支持下划线: 

    1_000_000 0xFF_EC_DE_5E 0b11010010_01101001_10010100_10010010

> 显示转换类型

    val b: Byte = 1
    val i1: Int = b.toInt()

> All number types support conversions to other types

* toByte(): Byte
* toShort(): Short
* toInt(): Int
* toLong(): Long
* toFloat(): Float
* toDouble(): Double

#### Boolean
    Boolean Boolean?
    true false null

    || && !

#### Char

    '1'
    \t – tab
    \b – backspace
    \n – new line (LF)
    \r – carriage return (CR)
    \' – single quotation mark
    \" – double quotation mark
    \\ – backslash
    \$ – dollar sign
    '\uFF00' // 支持Unicode
     digitToInt() // 如果char是一个数字, 那么可以把char转换成Int

#### String

    val str: String = "abcd 123"

> String 是不变的
> String 支持下标访问字符str[1], 支持for-in迭代
> String 联接使用`+`

> String literals - Escaped strings: 使用`\`转义
> String literals - Raw strings: 使用`"""`, 不用`\`转义 

> 支持字符串模板

    val s = "abc"
    println("$s.length is ${s.length}") // Prints "abc.length is 3"

#### Array

    class Array<T> private constructor() {
        val size: Int
        operator fun get(index: Int): T
        operator fun set(index: Int, value: T): Unit

        operator fun iterator(): Iterator<T>
        // ...
    }

> Array提供`get`, `set`方法, 实现下标操作arr[1]
> arrayOf() 创建Array
> arrayOfNulls() 创建空Array
> Array(5) { i -> (i * i).toString() } 用函数创建Array
> Array泛型是不变的, invariant

> Primitive type arrays﻿, 没有开箱开销, ByteArray, ShortArray, IntArray, intArrayOf

#### Unsigned integer types

    UByte: an unsigned 8-bit integer, ranges from 0 to 255
    UShort: an unsigned 16-bit integer, ranges from 0 to 65535
    UInt: an unsigned 32-bit integer, ranges from 0 to 2^32 - 1
    ULong: an unsigned 64-bit integer, ranges from 0 to 2^64 - 1
> 无符号类型是使用`inline classes`在对应kotlin类型中实现, 将类型从无符号类型更改为有符号对应类型(反之亦然)是二进制不兼容的更改.

    UByteArray: an array of unsigned bytes
    UShortArray: an array of unsigned shorts
    UIntArray: an array of unsigned ints
    ULongArray: an array of unsigned longs

> kotlin1.7, 无符号类型数组是beta版, `@ExperimentalUnsignedTypes`去掉非正式版API警告

    UIntRange
    UIntProgression
    ULongRange
    ULongProgression

#### literals

    1f 1F // float
    1l 1L // Long
    1u 1U // UInt
    1ul 1UL // ULong

### Reference
[Kotlin](https://kotlinlang.org/)  
[Android 的 Kotlin 优先方法](https://developer.android.google.cn/kotlin/first)  
