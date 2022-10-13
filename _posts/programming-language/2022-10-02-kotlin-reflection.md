---
layout: post
title: kotlin reflection
categories: lang
tags: [lang]
date: 2022-10-02
---

## kotlin reflection

    dependencies {
        implementation("org.jetbrains.kotlin:kotlin-reflect:1.7.20")
    }

    <dependencies>
      <dependency>
          <groupId>org.jetbrains.kotlin</groupId>
          <artifactId>kotlin-reflect</artifactId>
      </dependency>
    </dependencies>


### references

* class references

    KClass val c = MyClass::class
    JClass val c = MyClass::class.java
    KClass val c = o.javaClass.kotlin

* callable references

    KCallable<out R> // R是返回类型

* Function references 

    KFunction<out R>

    fun isOdd(x: Int) = x % 2 != 0
    fun isOdd(s: String) = s == "brillig" || s == "slithy" || s == "tove"

    val numbers = listOf(1, 2, 3)
    println(numbers.filter(::isOdd)) // refers to isOdd(x: Int)

* Propertye references

    val x = 1

    fun main() {
        println(::x.get())
        println(::x.name)
    }

* Constructor references

    class Foo
    function(::Foo)

### 兼容Java反射

> kotlin使用`kotlin.reflect.jvm`兼容java反射

    import kotlin.reflect.jvm.*

    class A(val p: Int)

    fun main() {
        println(A::p.javaGetter) // prints "public final int A.getP()"
        println(A::p.javaField)  // prints "private final int A.p"
    }



## Reference
