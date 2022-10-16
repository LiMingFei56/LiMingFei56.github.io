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
    
### Collection operations overview

> kotlin使用`member functions`和`extension functions`提供集合操作函数.

标准库提供基础类方便实现自己的集合:
    AbstractCollection
    AbstractList
    AbstractSet
    AbstractMap
    包括相对应的可变的类

Common operations: (这些操作不影响原集合)
* Transformations
* Filtering
* plus and minus operators
* Grouping
* Retrieving collection parts
* Retrieving single elements
* Ordering
* Aggregate operations
* Write operations

> `destination`操作, 操作可变集合的可选项, 可以把改变目标放到原集合(而不是生成新集合), 操作后缀加`To`(fileter, fileterTo)

> 某些操作有成对的两个函数, 一个就地修改集合, 一个返回新集合. 如sort()就地排序, sorted()返回新集合.

#### transformations

> 从一个集合转换成新集合

> map() mapIndexed() mapNotNull() mapIndexedNotNull() 
> 对于Map集合, mapKeys() mapKeys()
> 接收一个函数, 遍历所有元素作为于该函数,  结果成一个list返回

    val numbers = setOf(1, 2, 3)
    println(numbers.map { it * 3 })
    println(numbers.mapIndexed { idx, value -> value * idx })

    val numbersMap = mapOf("key1" to 1, "key2" to 2, "key3" to 3, "key11" to 11)
    println(numbersMap.mapKeys { it.key.uppercase() })
    println(numbersMap.mapValues { it.value + it.key.length })

> zip() unzip()
> 两个集合(或数组)按顺序组合成Pair, 返回以Pair为元素的List, 两个集合长度不一样时取小
> zip 也可以传入函数, 结果List元素为函数返回类型.
> unzip 解构元素为Pair的List, 返回一个Pair包含两个List

    val colors = listOf("red", "brown", "grey")
    val animals = listOf("fox", "bear", "wolf")
    println(colors zip animals)

    val twoAnimals = listOf("fox", "bear")
    println(colors.zip(twoAnimals))

    println(colors.zip(animals) { color, animal -> "The ${animal.replaceFirstChar { it.uppercase() }} is $color"})

> associateWith() associateBy() associate()
> 集合调用联系操作会生成Map对象, key为原集合(需要唯一), value为函数参数生成

    val numbers = listOf("one", "two", "three", "four")

    println(numbers.associateBy { it.first().uppercaseChar() })
    println(numbers.associateBy(keySelector = { it.first().uppercaseChar() }, valueTransform = { it.length }))

    val names = listOf("Alice Adams", "Brian Brown", "Clara Campbell")
    println(names.associate { name -> parseFullName(name).let { it.lastName to it.firstName } })

> flatten() flatMap()
> 该函数操作嵌套集合, 使之只有一层

    val numberSets = listOf(setOf(1, 2, 3), setOf(4, 5, 6), setOf(1, 2))
    println(numberSets.flatten())

    data class StringContainer(values: List<String>)

    val containers = listOf(
        StringContainer(listOf("one", "two", "three")),
        StringContainer(listOf("four", "five", "six")),
        StringContainer(listOf("seven", "eight"))
    )
    println(containers)
    println(containers.flatMap { it.values })

> joinToString() joinTo()
> 集合连接到string, joinTo是连接到Appendable对象

    val numbers = listOf("one", "two", "three", "four")    
    println(numbers.joinToString(separator = " | ", prefix = "start: ", postfix = ": end"))

    val listString = StringBuffer("The list of numbers: ")
    numbers.joinTo(listString)
    println(listString)

#### Filtering

> filter() filterIndexed() filterNot()
> 使用`preficate`过滤元素, 传入函数返回boolean来决策
> filterIsInstance<T>() filterNotNull()

> partition()
> 决策元素, 分为匹配和不匹配两个集合

> any() 如果有一个匹配就返回true
> none() 如果所有元素不匹配返回true
> all() 如果所有元素都匹配就返回true. 支持`vacuous truth`. 空集合也会返回true

#### Plus and minus operators

> plus(+) minus(-) plusAssign(+=) minusAssign(-=)
> 添加一个元素或者一个集合, 减一个元素或者一个集合
> 如果是minus操作, 第二操作数为元素, 那么会删除第一个遇到的元素; 第二操作数为集合, 那么会删除所有包含对应的元素.

#### Grouping

> groupBy()
> 对集合分组, 返回Map对象, key为组特征, value为符合特征的集合

> groupingBy()
> 对集合分组并且应用函数到所有组
> eachCount() fold() reduce() aggregate()

#### Retrieve collection parts

> slice() 
> 传入一个区间, 返回包含区间元素的集合

> take() takeLast() drop() dropLast()
> 从头或者尾拿或丢掉指定数量的元素

> takeWhile() takeLastWhile() dropWhile() dropLastWhile()
> 加入`preficate`, 拿或者丢指到不匹配的元素

> chunked() 
> 将集合拆分成指定大小的块, 返回包含块集合的集合.
> 传入transform函数, 还可以立即对块集合作操作.

> windowed()
> 滑动窗口, 返回指定区间大小所有可能的集合
> step 两个子集合第一个元素的距离, partialWindows 是否包含最后多出来的元素(如1-10, 区间大小为3, 那么10就不会包含)
> 支持transform函数, 同上

> zipWithNext()
> 双元素滑动窗口(Pair)

#### Retrieve single elements

> elementAt() elementAtOrNull() elementAtOrElse() 
> 以下标取元素, set中不可预测, list中等同get和[]
> first() last() firstOrNull()  lastOrNull()  支持`predicate`
> find() findLast()  替代 firstOrNull() 和 lastOrNull()

> firstNotNullOf() firstNotNullOfOrNull()
> 先映射集合后查找第一个元素

> random() randomOrNull()
> 随机元素

> contains()等于in containsAll() isEmpty() isNotEmpty()

#### Ordering

> natural order, 没有定义其它顺序就使用这个排序, 使用`Comparable.compareTo`实现.
> Custom order, 使用`Comparator.compare`实现, compareBy() 快捷方式 

> sorted() sortedDescending()
> 自然排序, 升序或降序

> sortedBy() sortedByDescending() sortedWith()
> 自定义排序, 升序或降序

> reversed() asReversed()
> 反转集合, asReversed()反转原集合后的视图.

> shuffled()
> 随机排序

#### Aggregate operations

> minOrNull() maxOrNull()  返回最小或最大元素, 否则Null
> average() 平均值
> sum() 总数
> count() 元素个数

依赖`selector function`或者`Comparator`
> maxByOrNull() minByOrNull()
> maxWithOrNull()  minWithOrNull()
> maxOfOrNull() minOfOrNull() 
> maxOfWithOrNull() minOfWithOrNull()
> sumOf() 

> reduce() fold() 
> 使用函数应用到每个元素并且返回值, reduce以第一个元素和第二个元素做初始值, fold有初始值.
> reduceRight() foldRight() 相反顺序应用元素
> reduceIndexed() foldIndexed() 有下标 reduceRightIndexed() foldRightIndexed().
> *OrNull 

> runningFold()等于scan() runningReduce()
> runningFoldIndexed() runningReduceIndexed()
> 可以保留中间值

#### Collection write operations

> add() addAll() plus plusAssign
> 添加元素

> remove() removeAll() retainAll() clear() minus minusAssign

#### List-specific operations

> [index] getOrElse() getOrNull()

> subList()

> indexOf() lastIndexOf() indexOfFirst() indexOfLast()
> Linear search

> binarySearch() 
> Binary search in sorted lists, 速度快, 但要求是有顺序的.

> add() add()

> set()

> fill()

> removeAt() 

> sort* sorted* 

#### Set-specific operations

> union() a union b 并集

> intersect() a intersect b 交集

> subtract() a subtract b 非

> 上面3个操作也支持List, 但是结果会是Set

#### Map-specific operations

> get() getValue() [key]  getOrElse() getOrDefault()

> filter() 参数是Pair
> filterKeys() filterValues()

> plus minus plusAssign 操作数为pair或者Map

> put() putAll() [] 

> remove()





## Reference
[Collections overview](https://kotlinlang.org/docs/collections-overview.html)  
