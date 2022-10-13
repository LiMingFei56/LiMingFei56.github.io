---
layout: post
title: kotlin jvm
categories: lang
tags: [lang]
date: 2022-10-04
---

## kotlin jvm

> kotlin多平台开发支持:
* Android and iOS (在Alpha阶段)
* JVM
* JavaScript
* Native
* Scripting

### Comparison to java

Some Java issues addressed in Kotlin:
* Null references are controlled by the type system.

* No raw types

* Arrays in Kotlin are invariant

* Kotlin has proper function types, as opposed to Java's SAM-conversions

* Use-site variance without wildcards

* Kotlin does not have checked exceptions

What Java has that Kotlin does not:
* Checked exceptions

* Primitive types that are not classes. The byte-code uses primitives where possible, but they are not explicitly available.

* Static members are replaced with companion objects, top-level functions, extension functions, or @JvmStatic.

* Wildcard-types are replaced with declaration-site variance and type projections.

* Ternary-operator a ? b : c is replaced with if expression.

What Kotlin has that Java does not:
* Lambda expressions + Inline functions = performant custom control structures

* Extension functions

* Null-safety

* Smart casts

* String templates

* Properties

* Primary constructors

* First-class delegation

* Type inference for variable and property types

* Singletons

* Declaration-site variance & Type projections

* Range expressions

* Operator overloading

* Companion objects

* Data classes

* Separate interfaces for read-only and mutable collections

* Coroutines

### Calling Java from Kotlin

> Java几乎所有的代码都可以在kotlin中使用.

#### Getters and setters

> Java getters and setters 会转换成kotlin get 和 set 方法.
> Java对象属性如果只有set方法, 那么kotlin不支持.

#### Methods returning void

> void -> unit

#### Escaping for Java identifiers that are keywords in Kotlin

> 调用java标识符是kotlin关键字, 使用"`". foo.`is`(bar)

#### Null-safety and platform types

> kotlin会对Java平台声明的类型做特殊处理, 称为平台类型.
> kotlin对平台类型不会有编译时非空检查, 但是会有运行时空指针异常或kotlin为防止空值的
    断言
> 平台类型是不可表示的, 当kotlin非空引用一个Java对象, kotlin会产生一具非空断言, 保证
    对象不为空

平台类型助记符:
* T! means "T or T?",
* (Mutable)Collection<T>! means "Java collection of T may be mutable or not, may be nullable or not",
* Array<(out) T>! means "Java array of T (or a subtype of T), nullable or not"

为空性注释:
* JetBrains (@Nullable and @NotNull from the org.jetbrains.annotations package)
* JSpecify (org.jspecify.nullness)
* Android (com.android.annotations and android.support.annotations)
* JSR-305 (javax.annotation, more details below)
* FindBugs (edu.umd.cs.findbugs.annotations)
* Eclipse (org.eclipse.jdt.annotation)
* Lombok (lombok.NonNull)
* RxJava 3 (io.reactivex.rxjava3.annotations)


> `-Xnullability-annotations=@<package-name>:<report-level>` 可以检查
> report-level
* ignore to ignore nullability mismatches
* warn to report warnings
* strict to report errors.

#### Mapped types
[Mapped types](https://kotlinlang.org/docs/java-interop.html#mapped-types)  

#### Java generics in Kotlin

Java's wildcards are converted into type projections:

    Foo<? extends Bar> becomes Foo<out Bar!>!

    Foo<? super Bar> becomes Foo<in Bar!>!

Java's raw types are converted into star projections:

    List becomes List<*>! that is List<out Any?>!

#### Java arrays

> kotlin数组是不变的, 不像Java是协变的. kotlin可以使用Array<(out) String>!
> kotlin数组使用java数组实现, 并提供`IntArray`, `DoubleArray`, `CharArray`

#### Java varargs

> kotlin调用java传递可变长度参数时, 数组需要使用`*`解构

#### Operators

> kotlin允许操作符重载, 不允许使用中缀操作符调用Java方法.

#### checked exceptions

> kotlin中没有检查异常, 调用Java方法中如果有检查异常, 也不需要处理.

#### Object methods

> 当Java类型进入到kotlin时, `java.lang.Object`会转换成`Any`
> Any中只有`toString, hashCode, equals`

    调用wait()/notify()
    (foo as java.lang.Object).wait()

    getClass()
    val fooClass = foo::class.java
    val fooClass = foo.javaClass

    clone() // kotlin需要扩展`kotlin.Cloneable`
    class Example : Cloneable {
        override fun clone(): Any { ... }
    }

    finalize() // 不使用`override`关键字重写`finalize`方法, 不能为`private`
    class C {
        protected fun finalize() {
            // finalization logic
        }
    }

#### Inheritance from Java classes

> 可以实现一个Java类, 多个Java接口

#### Accessing static members

> Java中静态成员转换成了`companion objects`, 不能当值传递, 可以显示访问.
> 访问映射到Kotlin类型的Java类型的静态成员, 需要Java完整签名`java.lang.Integer.bitCount(foo)`

#### Java reflection

引用Java类
    instance::class.java
    instance.javaClass

引用伴生类
    ClassName::class.java 相当于下面
    ClassName.Companion::class.java

#### SAM conversions

> kotlin支持 SAM 在Java和kotlin间转换. 只支持接口, 不支持抽象类
> 如果需要调用Java重载方法, 可以将lambada转换成特定的SAM类型, 适配调用方法.

    executor.execute(Runnable { println("This runs in a thread pool") })

#### Using JNI with Kotlin

> 使用`external`声明调用本地方法的函数, 其它的与Java中相同
> 还可以修改getter和setter方法, 

    var myProperty: String
        external get
        external set

> 映射到`getMyPropery`和`setMyProperty`

#### Using Lombok-generated declarations in Kotlin

[Lombok compiler plugin](https://kotlinlang.org/docs/lombok.html#using-jni-with-kotlin)  

### Calling Kotlin from Java

#### Properties

* a getter method, with the name calculated by prepending the get prefix
* a setter method, with the name calculated by prepending the set prefix (only for var properties)
* a private field, with the same name as the property name (only for properties with backing fields)

    var firstName: String

    private String firstName;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

> 如果属性是`is`开头如isOpen, getter为isOpen(), setter使用set替换is成setOpen

#### Package-level function

> 使用Kotlin文件名包名 + 文件名引用

    // app.kt
    package org.example

    class Util

    fun getTime() { /*...*/ }

    // Java
    new org.example.Util();
    org.example.AppKt.getTime();

> 使用`@JvmName`自定义生成Java类的名称

    @file:JvmName("DemoUtils")

    package org.example

    class Util

    fun getTime() { /*...*/ }

    // Java
    new org.example.Util();
    org.example.DemoUtils.getTime();

> 顶级签名需要唯一, 但可以使用`@file:JvmMultifileClass`生成facade, facade包含相同签名的顶级文件.

#### Instance fields

> `@JvmField`可以将Kotlin属性作为Java中字段公开. 必须满足:
* has a backing field
* is not private
* does not have open, override or const modifiers
* is not a delegated property

> Late-initialized 属性也是公开字段, 可见性与setter相同.
> Late-initialized 会有static backing field

#### Static fields

> 在`named object`和`Companion object`中声明的属性是私有的, 可以使用下列方式公开:
    
* @JvmField annotation, 支持属性和属性的getter, setter方法
* lateinit modifier
* const modifier // 在Java中会转换成静态字段

    class Key(val value: Int) {
        companion object {
            @JvmField
            val COMPARATOR: Comparator<Key> = compareBy<Key> { it.value }
        }
    }

    // Java
    Key.COMPARATOR.compare(key1, key2);

    object Singleton {
        lateinit var provider: Provider
    }

    // Java
    Singleton.provider = new Provider();
    // public static non-final field in Singleton class

#### Static methods

> kotlin会把顶级函数编译成静态对象, 使用`@JvmStatic`修饰, 可以使
> `named objects` 和 `companion objects` 方法成静态方法.
> 编译器会生成静态方法和实例方法.

    class C {
        companion object {
            @JvmStatic fun callStatic() {}
            fun callNonStatic() {}
        }
    }

> callStatic 是静态的, callNonStatic不是的

    C.callStatic(); // works fine
    C.callNonStatic(); // error: not a static method
    C.Companion.callStatic(); // instance method remains
    C.Companion.callNonStatic(); // the only way it works

> 1.3支持接口伴生对象方法声明@JvmStatic, 1.8支持接口方法声明@JvmStatic


#### Default methods in interfaces

> JDK1.8支持接口默认方法, `-Xjvm-default=all`把kotlin接口中所有非抽象方法编译成
> Java默认方法.

> kotlin1.4前使用`@JvmDefault`注释默认方法, 1.4后使用`-Xjvm-default=all`, 这二种生
> 成的二进制代码不兼容.  可以使用`@JvmDefaultWithCompatibility`注解在接口上实现兼容.

> kotlin 1.6.20 支持-Xjvm-default=disable(默认), -Xjvm-default=all, -Xjvm-default=all-compatibility
* disable: 默认行为, 不生成默认方法, @JvmDefault不可用
* all: 所有接口非抽象方法都生成默认方法. 但是不生成`DefaultImpls`
* all-compatibility: 同all, 生成兼容的`DefaultImpls`

#### Visibility

* private members are compiled to private members
* private top-level declarations are compiled to package-local declarations
* protected remains protected (note that Java allows accessing protected members from other classes in the same package and Kotlin doesn't, so Java classes will have broader access to the code)
* internal declarations become public in Java. Members of internal classes go through name mangling, to make it harder to accidentally use them from Java and to allow overloading for members with the same signature that don't see each other according to Kotlin rules
* public remains public

#### KClass

> 手动Java类转kotlin类

    kotlin.jvm.JvmClassMappingKt.getKotlinClass(MainView.class)

#### Handling signature clashes with @JvmName

> kotlin指定生成JVM函数签名, 使用`@JvmName`

    fun List<String>.filterValid(): List<String>

    @JvmName("filterValidInt")
    fun List<Int>.filterValid(): List<Int>

    @get:JvmName("x")
    @set:JvmName("changeX")
    var x: Int = 23

#### Overloads generation

> Java函数重载, kotlin中使用参数默认值. 在Java中调用kotlin参数默认值, 所有参数都
> 需要传递.

> Kotlin参数默认值, 如果想生成Java函数重载, 使用`@JvmOverloads`

    class Circle @JvmOverloads constructor(centerX: Int, centerY: Int, radius: Double = 1.0) {
        @JvmOverloads fun draw(label: String, lineWidth: Int = 1, color: String = "red") { /*...*/ }
    }

#### Checked exceptions

> kotlin中没有检查异常, 如果需要Java调用kotlin时显示检查异常, 使用`@Throws`

    @Throws(IOException::class)
    fun writeToFile() {
        /*...*/
        throw IOException()
    }

#### Null-safety

> kotlin会对所有公式函数显示的运行时检查非空参数. java调用kotlin, 如果传null, 
> 会得到NPE.

#### Variant generics

> kotlin编译器会判断代码, 在需要通配符的地方, 生成对应的Java函数.
> 如果需要在没有生成通配符的地址生成, 使用`@JvmWildcard`.
> 生成的地方不需要, 使用`@JvmSuppressWildcards`.

#### Translation of type Nothing

> Noting在Java中没有表示, 包括java.lang.Void

### Using Java records in Kotlin

> JDK14 支持 record class. 一组不变值的类, 可以不生成样板代码.

    // Java
    public record Person (String name, int age) {}

    // kotlin
    val newPerson = Person("Kotlin", 10)
    val firstName = newPerson.name

> kotlin中使用`record`, 使用`@JvmRecord`

    @JvmRecord
    data class Person(val name: String, val age: Int)

> 将现有的类声明为`record`, 不是二进制兼容的. 需要JDK 16


## Reference
[Kotlin/JVM](https://kotlinlang.org/docs/jvm-get-started.html)  
