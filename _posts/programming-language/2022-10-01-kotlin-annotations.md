---
layout: post
title: kotlin annotations
categories: lang
tags: [lang]
date: 2022-10-01
---

## kotlin annotations

    // 声明注解
    annotation class Fancy

使用`meta-annotations`可以指定注解的属性:

* `@Target`可以指定哪种元素可以使用这个注解
* `@Retention`指定1: 是否存储在编译后的类中; 2: 指定是否运行时反射可见(默认两者都有)
* `@Repeatable`允许同一个元素使用注解多次
* `@MustBeDecumented`指定注解属于公共API, 在文档中显示

### Constructors

> 注解可以有构造函数

    annotation class Special(val why: String)

    @Special("example") class Foo {}

构造函数允许的参数类型:

* Types that correspond to Java primitive types (Int, Long etc.)

* Strings

* Classes (Foo::class)

* Enums

* Other annotations

* Arrays of the types listed above

> 构造函数参数不允许nullable类型. 因为JVM不支持存储null值到注解属性.
> 使用其它注解当参数时, 名称不需要使用`@`
> 使用类当参数时使用`KClass`, kotlin编译器会自动转换成Java code

### Instantiation

> 在Java中注解实现是接口, 所以可以实现注解并创建对象
> 在kotlin中, 为了和java一致, 所以允许调用注解的构造函数实例化注解对象.

### Lambdas

> 注解可以修饰lambdas, 编译后会放在lambdas的invoke()方法上. 运行时可反射. 
> 对类似与`Quasar`框架非常有用.

### annotation use-site targets

> 指定注解生成对应Java 字节码对应的位置. 

    class Example(@field:Ann val foo,    // annotate Java field
              @get:Ann val bar,      // annotate Java getter
              @param:Ann val quux)   // annotate Java constructor parameter

支持的use-site targets:

* file
* property (annotations with this target are not visible to Java)
* field
* get (property getter)
* set (property setter)
* receiver (receiver parameter of an extension function or property)
* param (constructor parameter)
* setparam (property setter parameter)
* delegate (the field storing the delegate instance for a delegated property)
* param
* property
* field

### Java annotations

> kotlin100%支持java注解
> 需要使用命名参数调用java注解, 因为没有定义调用顺序. 例外的是`value`

### Arrays as annotation parameters

> Java注解定义数组, kotlin中使用`vararg`
> kotlin中使用`array literal syntax` 和 `arrayOf(...)`

### Acessing properties of an annotation instance

    // Java
    public @interface Ann {
        int value();
    }

    // Kotlin
    fun foo(ann: Ann) {
        val i = ann.value
    }

### Repeatable annotations

> 与java一样, kotlin注解可以重复多次使用在同一个元素上
> Kotlin会生成@Tag.Container

    @Repeatable
    annotation class Tag(val name: String)

    // The compiler generates the @Tag.Container containing annotation

> 使用`JvmRepeatable`自定义包含注解的名称

    @JvmRepeatable(Tags::class)
    annotation class Tag(val name: String)

    annotation class Tags(val value: Array<Tag>)



## Reference
