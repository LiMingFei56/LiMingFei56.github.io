---
layout: post
title: Kotlin Packages and imports
categories: lang
tags: [lang]
date: 2022-09-22
---

## Kotlin Packages and imports

### Package

> kotlin包定义不用像JAVA那样匹配文件目录.

    package org.example

    fun printMessage() { /*...*/ }
    class Message { /*...*/ }

    // ...

> 定义package, 那么源码中的实体名为`org.example.printMessage`和`org.example.Message`
> 不定义package, 那么没有package 名

### Default imports

* kotlin.*
* kotlin.annotation.*
* kotlin.collections.*
* kotlin.comparisons.*
* kotlin.io.*
* kotlin.ranges.*
* kotlin.sequences.*
* kotlin.text.*
* JVM:
*     java.lang.*
*     kotlin.jvm.*
* JS:
*    kotlin.js.*

### Imports

    import org.example.Message // Message is now accessible without qualification
    import org.example.* // everything in 'org.example' becomes accessible

    // 处理包名冲突
    import org.example.Message // Message is accessible
    import org.test.Message as testMessage // testMessage stands for 'org.test.Message'

> `import` 可以不止导入类, 也可以导入:
* top-level functions and properties
* functions and properties declared in object declarations
* enum constants

> If a top-level declaration is marked private, it is private to the file it's declared in (see Visibility modifiers).

## Reference
[Packages and imports](https://kotlinlang.org/docs/control-flow.html)  
