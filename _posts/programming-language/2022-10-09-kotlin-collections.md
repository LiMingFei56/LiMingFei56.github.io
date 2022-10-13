---
layout: post
title: kotlin collections
categories: lang
tags: [lang]
date: 2022-10-09
---

## kotlin collections

* List, 一个有序集合, 通过下标访问元素, 元素可以重复
* Set, 一个数学抽象集合, 无序, 唯一. 一般Map的key就是set. 默认`LinkedHashSet`, `HashSet`
* Map(dictionary), key-value pairs. key是唯一的, 并且会关联一个value. value可以重复. 默认`LinkedHashMap`, `HashMap`

> kotlin有 read-only 和 mutable
> read-only 集合是`convariant`; mutable 不是`convariant`的

### Constructing collections

> Construct from elements

    listOf<T>()
    setOf<T>()
    mutableListOf<T>()
    mutableSetOf<T>()
    mapOf() // 接收Pair对象, 可以使用`to`中缀符创建
    mutableMapOf()

> Create with collection builder functions

    buildList()
    buildSet()
    buildMap()

    val map = buildMap { // this is MutableMap<String, Int>, types of key and value are inferred from the `put()` calls below
        put("a", 1)
        put("b", 0)
        put("c", 4)
    }

> Empty collections

    emptyList()
    emptySet()
    emptyMap()

    val empty = emptyList<String>() // 需要指定值类型

> Initializer functions for lists

    val doubled = List(3, { it * 2 })  // or MutableList if you want to change its content later
    println(doubled)

> Concrete type constructors

    val linkedList = LinkedList<String>(listOf("one", "two", "three"))
    val presizedSet = HashSet<Int>(32)

> Copy

    // 使用拷贝函数是浅拷贝, 修改原元素会影响新的集合, 删除和增加元素无影响
    toList()
    toMutableList()
    toSet()
    toMutableSet()
    toMap()
    toMutableMap()

> Invoke functions on other collections

    [filtering](https://kotlinlang.org/docs/collection-filtering.html)
    [Mapping](https://kotlinlang.org/docs/collection-transformations.html#map)
    [Association](https://kotlinlang.org/docs/collection-transformations.html#associate)

### Iterators

> `iterators`, 可以顺序访问元素并且不暴露地层实现. 实现`Interable<T>`接口, 实现`iterator()`函数, 返回`Iterator<T>`对象.
> `Iterator<T>`需要实现`hasNext()`和`next()`两个函数. 迭代器遍历到最后就不可用了, 不能重置到任何以前位置.

> for-in 会默认获取新的迭代器来遍历对象
> forEach 也支持遍历对象

> lists 有个特别的实现`ListIterator`, 支持向前和向后遍历.
> 向前实现`hasPrevious()`和`previous()`. 并且提供`nextIndex()`和`previousIndex()`索引.
> 双向迭代可以实现遍历到最后也可以使用.

> 可变集合提供`MutableIterator`, 支持迭代删除元素`remove`; `MutableListIterator`支持添加元素`add`.

### Ranges and progressions

> `kotlin.ranges`, 表示闭合区间
> 声明区间, 可以使用`rangeTo()`和`..`创建
> 反向区间, `downTo`和`..`创建
> 判断包含, 使用`in`和`!in`中缀操作
> 使用`step`定义步长
> 使用`until`不包括最后一个元素
> 使用`reversed`反转区间
> 当声明`..`和`rangeTo`时创建range, 如果是`.. step`和`downTo`时创建progression

> Range(IntRange, LongRange, CharRange), 支持`iterator`

> arithmetic progressions(IntProgression, LongProgression, CharProgression), progressions有三个属性, first, 
> last, 非0step. for (int i = first; i <= last; i += step)
> 最后一个元素: 正步长-(last-first)%step==0; 负步长-(last-first)%step==0

### Sequences

> `Sequence<T>`, 不包含元素, 当迭代的时候产生, 提供跟`Iterable`相同的功能, 但是提供 `multi-step collection processing`
> 每一个step执行完都会返回一个collection, 计算是lazily, 只有当step链执行完才会计算.
> 序列可以避免计算最终结果时产生中间结果, 但lazily计算也有开销, 对轻量计算不友好.
> 序列操作返回其它序列, 这叫中间操作; 不然就叫终端操作. 只有调用终端操作才会真正的计算.

Construct:
    From elements: sequenceOf()
    From an Iterable: Iterable.asSequence()
    From a function: generateSequence(), 当返回null时停止
    From chunks: sequence() yield() yieldAll()

Sequence operations:
    * Stateless operations require no state and process each element independently, for example, map() or filter(). Stateless operations can also require a small constant amount of state to process an element, for example, take() or drop().
    * Stateful operations require a significant amount of state, usually proportional to the number of elements in a sequence.
    



## Reference
[Collections overview](https://kotlinlang.org/docs/collections-overview.html)  
