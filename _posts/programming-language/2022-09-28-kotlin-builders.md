---
layout: post
title: kotlin builder
categories: lang
tags: [lang]
date: 2022-09-28
---

## kotlin builder

> kotlin 使用命名良好的函数和 function literals with receiver, 可以实现type-safe builder
> Type-safe builders allow creating Kotlin-based domain-specific languages (DSLs)

* Generating markup with Kotlin code, such as [HTML](https://github.com/Kotlin/kotlinx.html) or XML
* Configuring routes for a web server: [Ktor](https://ktor.io/docs/routing.html?_gl=1*tvowin*_ga*MTQ5OTAzNDk0MC4xNjYzMjkzMDgx*_ga_9J976DJZ68*MTY2NDM1NjM5NS4yOC4xLjE2NjQzNTcxMjIuNTcuMC4w&_ga=2.49161894.1824152635.1664329274-1499034940.1663293081)

    fun html(init: HTML.() -> Unit): HTML {
        val html = HTML()
        html.init()
        return html
    }

    fun head(init: Head.() -> Unit): Head {
        val head = Head()
        head.init()
        children.add(head)
        return head
    }

    fun body(init: Body.() -> Unit): Body {
        val body = Body()
        body.init()
        children.add(body)
        return body
    }

    html {
        head { ... }
        body { ... }
    }

> DSLs需要范围控制, 使用`@DslMarker` 

### builder type inference

> kotlin支持`builder type inference`, 对泛型构建很有用

    fun addEntryToMap(baseMap: Map<String, Number>, additionalEntry: Pair<String, Int>?) {
       val myMap = buildMap {
           putAll(baseMap)
           if (additionalEntry != null) {
               put(additionalEntry.first, additionalEntry.second)
           }
       }
    }

> 这代码中buildMap 没有明确的类型, 编译器通过`putAll`和`put`推断出buildMap 类型.

#### 创建自己的builder

1. 1.7.0前需要开启builder类型推断`-Xenable-builder-inference`, 1.7.0后默认开启

2. 需要接收者的lambda, 目前还不支持泛型接收者 fun <V> buildList(builder: MutableList<V>.() -> Unit) { ... }

3. builder应该是类的成员函或者扩展函数.

Supported features:
* Inferring several type arguments
* Inferring type arguments of several builder lambdas within one call including interdependent ones
* Inferring type arguments whose type parameters are lambda's parameter or return types

> 构建推断是使用`Postponed type variables`工作的, 延迟类型变量是正在进行推断的类型参数的类型. 编译器
> 使用它来推断.

Contributing to builder inference results:
* Calling methods on a lambda's receiver that use the type parameter's type
* Specifying the expected type for calls that return the type parameter's type
* Passing postponed type variables' types into methods that expect concrete types
* Taking a callable reference to the lambda receiver's member
    





## Reference

