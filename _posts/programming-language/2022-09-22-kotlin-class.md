---
layout: post
title: Kotlin Class
categories: lang
tags: [lang]
date: 2022-09-22
---

## Kotlin Class

> class Person { /*...*/ }
> class Empty

### Constructors

    // primary constructor, only one 
    class Person constructor(firstName: String) { /*...*/ }

> 如果主构造函数没有什么注解和可见性修饰, 那么`constructor`可以忽略
> 主构造函数没有代码块, 可以写在`init`块中, `init`块可以有多个, 与在代码中的顺序一致, 与属性定义交错在一起
> 主构造函数定义的参数可以当属性使用, 可以有默认值

    class Person(val pets: MutableList<Pet> = mutableListOf())

    class Pet {
        constructor(owner: Person) {
            owner.pets.add(this) // adds this pet to the list of its owner's pets
        }
    }

> 定义Secondary constructors
> Secondary constructors, 如果主构造函数不为空, 那么最终需要调用主构造函数

    class Person(val name: String) {
        val children: MutableList<Person> = mutableListOf()
        constructor(name: String, parent: Person) : this(name) {
            parent.children.add(this)
        }
    }

> `init`块会在第二构造函数前调用
> 如果非抽象类没有定义构造函数, 那么会创建默认的公共的无参的主构造函数

>   On the JVM, if all of the primary constructor parameters have default values, the compiler will generate an additional parameterless constructor which will use the default values. This makes it easier to use Kotlin with libraries such as Jackson or JPA that create class instances through parameterless constructors

### Creating instances of classes

    // Kotlin does not have a new keyword.
    val invoice = Invoice()

### Class members

Classes can contain:

    Constructors and initializer blocks
    Functions
    Properties
    Nested and inner classes
    Object declarations
    
### Abstract classes

    使用`abstract`修饰类和方法

    abstract class Polygon {
        abstract fun draw()
    }

    class Rectangle : Polygon() {
        override fun draw() {
            // draw the rectangle
        }
    }

    抽象类可以使用`open`覆盖一个非抽象类

    open class Polygon {
        open fun draw() {
            // some default polygon drawing method
        }
    }

    abstract class WildShape : Polygon() {
        // Classes that inherit WildShape need to provide their own
        // draw method instead of using the default on Polygon
        abstract override fun draw()
    }

## Inheritance

> `Any`是默认超类, 有三个方法`equals()`, `hashCode()`, `toString()`
> kotlin class 默认是final的, 使用`open`修饰可以继承, `abstract`默认是open的

    open class Base(p: Int)
    class Derived(p: Int) : Base(p)

> 如果派生类有主构造函数, 那么在主构造函数中需要初始化基类; 如果没有主构造函数, 那么每个第二构造函数都需要初始化基类.
    
    class MyView : View {
        constructor(ctx: Context) : super(ctx)

        constructor(ctx: Context, attrs: AttributeSet) : super(ctx, attrs)
    }

    // override
    open class Shape { // 如果没有open, 类里的open不起作用
        open val vertexCount: Int = 0 // 属性重写跟方法一样
        open fun draw() { /*...*/ } 
        fun fill() { /*...*/ } // 没有open修饰, 不能重写
    }

    // 可以在主构造函数中使用`override`
    class Circle() : Shape() {
        override var vertexCount = 4 // 可以使用var重写val, 不能反过来; 本质上val属性只有get方法, 改成var就是加上set方法
        final override fun draw() { /*...*/ } // override 默认是打开, final可以关闭, 子类不能重写该方法.
    }

> 派生类初始化过程, 在基类中使用开放属性是不正确的, 因为基类初始化里派生类还没有初始化.

    open class Base(val name: String) {

        init { println("Initializing a base class") }

        open val size: Int = 
            name.length.also { println("Initializing size in the base class: $it") }
    }

    class Derived(
        name: String,
        val lastName: String,
    ) : Base(name.replaceFirstChar { it.uppercase() }.also { println("Argument for the base class: $it") }) {

        init { println("Initializing a derived class") }

        override val size: Int =
            (super.size + lastName.length).also { println("Initializing size in the derived class: $it") }
    }

> 使用`super`调用基类或者外部类的方法和属性, 指定外部类名称`super@OuterClassName`(super@FilledRectangle.draw()) 

> 如果派生类继承多个同样的(签名一样)成员, 那么派生类需要重写自己的成员(可以选择一个实现).

    open class Rectangle {
        open fun draw() { /* ... */ }
    }

    interface Polygon {
        fun draw() { /* ... */ } // interface members are 'open' by default
    }

    class Square() : Rectangle(), Polygon {
        // The compiler requires draw() to be overridden:
        override fun draw() {
            super<Rectangle>.draw() // call to Rectangle.draw()
            super<Polygon>.draw() // call to Polygon.draw()
        }
    }

## Properties

> var 声明可变属性, val 声明不可变属性(没有setter方法)

    var <propertyName>[: <PropertyType>] [= <property_initializer>]
        [<getter>]
        [<setter>]

    var setterVisibility: String = "abc"
        private set // the setter is private and has the default implementation

    var setterWithAnnotation: Any? = null
        @Inject set // annotate the setter with Inject

> `Backing fields`, `field`是作为属性的一部分使用(在内存中保存值), `field`只能在accessors(getter, setter)中使用
> `Backing fields`会自动生成`field`, 至少有一个默认的accessors, 或者有一个自定义accessors中使用`field`关键字

> 如果`Backing fields`不适合, 可以使用`Backing properties`

    private var _table: Map<String, Int>? = null
    public val table: Map<String, Int>
        get() {
            if (_table == null) {
                _table = HashMap() // Type parameters are inferred
            }
            return _table ?: throw AssertionError("Set to null by another thread")
        }

    On the JVM: Access to private properties with default getters and setters is optimized to avoid function call overhead.

> 编译时常量, 编译时就可以确定值并且不变的, 用`const`修饰. 编译器会内联这个常量, 并且这个常量不会删除, 可以用反射获取
> 编译时常量需要满足下面的条件:
    * It must be a top-level property, or a member of an object declaration or a companion object.
    * It must be initialized with a value of type String or a primitive type
    * It cannot be a custom getter

> 非空属性需要在构造函数和之前初始化, 使用`lateinit`可以延迟初始化. 
> 使用`isInitialized`检查`lateinit`变量是否初始化

## interface

> kotlin中的接口可以包含抽象的和实现的方法和属性, 与`abstract`的区别是不能存储状态. 可以有属性
> 但是属性必须是open的或有accessors, 接口属性中没有`Backing fields`
> 类可以实现多个接口, 接口可以继承接口, 类只用实现没有实现过的方法和属性
> 使用`override`解决方法和属性签名冲突问题

    interface MyInterface {
        val prop: Int // abstract

        val propertyWithImplementation: String
            get() = "foo"

        fun foo() {
            print(prop)
        }
    }

    class Child : MyInterface {
        override val prop: Int = 29
    }

## Functional (SAM) interfaces

> SAM Single Abstract Method, 一个接口只有一个抽象方法. 在kotlin中可以有几个非抽象方法.
> SAM conversions, 可以使用lambda表达式.

    fun interface IntPredicate {
       fun accept(i: Int): Boolean
    }

    // Creating an instance of a class
    val isEven = object : IntPredicate {
       override fun accept(i: Int): Boolean {
           return i % 2 == 0
       }
    }

    // Creating an instance using lambda
    val isEven = IntPredicate { it % 2 == 0 }

> 1.6.20, kotlin 实现`callable references`

    interface Printer {
        fun print()
    }

    fun Printer(block: () -> Unit): Printer = object : Printer { override fun print() = block() }

    documentsStorage.addPrinter(::Printer)

    // Preserve the binary compatibility by marking the legacy function Printer with the @Deprecated annotation with DeprecationLevel.HIDDEN:
    @Deprecated(message = "Your message about the deprecation", level = DeprecationLevel.HIDDEN)
    fun Printer(...) {...}

> Type aliases, 只有一个属性, 不够灵活, 当表示复杂的类型名称的时候可以使用.
    
    typealias IntPredicate = (i: Int) -> Boolean

## Visibility modifiers

> 类, 对象, 接口, 构造函数, 方法都可以有可见性修饰, 属性的getter使用属性的可见性, setter可以单独指定可见性.
> 可见性默认为`public`

> 在package中:
* If you don't use a visibility modifier, public is used by default, which means that your declarations will be visible everywhere.
* If you mark a declaration as private, it will only be visible inside the file that contains the declaration.
* If you mark it as internal, it will be visible everywhere in the same module.
* The protected modifier is not available for top-level declarations.

> 在class中:
* private means that the member is visible inside this class only (including all its members).
* protected means that the member has the same visibility as one marked as private, but that it is also visible in subclasses.
* internal means that any client inside this module who sees the declaring class sees its internal members.
* public means that any client who sees the declaring class sees its public members.
* In Kotlin, an outer class does not see private members of its inner classes.

> 在Constructor中:
* private 私有, 不可用
* internal 模块中使用

## Extensions

> 不用使用继承和`Decorator`来扩展类和接口

### Extension functions

> `MutableList`为接收类, `swap`为扩展函数, 函数中`this`表示MutableList当前对象. 

    fun <T> MutableList<T>.swap(index1: Int, index2: Int) {
        val tmp = this[index1] // 'this' corresponds to the list
        this[index1] = this[index2]
        this[index2] = tmp
    }

> 扩展函数是静态实现, 不修改类内部. 扩展函数与内部函数签名冲突, 默认使用内部函数.

> nullable supper

    fun Any?.toString(): String {
        if (this == null) return "null"
        // after the null check, 'this' is autocast to a non-null type, so the toString() below
        // resolves to the member function of the Any class
        return toString()
    }

### Extension properties

    val <T> List<T>.lastIndex: Int
        get() = size - 1

> 扩展属性不是真实的修改类的成员, 没有`backing field`. 不能初始化, 总是通过getter和setter访问.

### Companion object extensions

> 伴生对象支持扩展函数和属性, 使用类名访问

### Scope of extensions

> 通常在top-level中定义扩展, 使用时导入

    // file 1
    package org.example.declarations

    fun List<String>.getLongestString() { /*...*/}

    // file 2
    package org.example.usage

    import org.example.declarations.getLongestString

    fun main() {
        val list = listOf("red", "green", "blue")
        list.getLongestString()
    }

### Declaring extensions as members

> 在一个类中声明另一个类的扩展函数或属性, 这时会有多个隐式接收者, 可以不用`this`限定符访问另一个类的成员.
> 如果扩展与原类成员签名冲突, 那么扩展胜出.

    class Host(val hostname: String) {
        fun printHostname() { print(hostname) }
    }

    class Connection(val host: Host, val port: Int) {
        fun printPort() { print(port) }

        fun Host.printConnectionString() {
            printHostname()   // calls Host.printHostname()
            print(":")
            printPort()   // calls Connection.printPort()
        }

        fun connect() {
            /*...*/
            host.printConnectionString()   // calls the extension function
        }
    }

    fun main() {
        Connection(Host("kotl.in"), 443).connect()
        //Host("kotl.in").printConnectionString()  // error, the extension function is unavailable outside Connection
    }

> 扩展可以声明open与override, 这说明dispatch receiver type 是虚函数, extension receiver type是静态函数.

    open class Base { }

    class Derived : Base() { }

    // extension receiver type
    open class BaseCaller {
        open fun Base.printFunctionInfo() {
            println("Base extension function in BaseCaller")
        }

        open fun Derived.printFunctionInfo() {
            println("Derived extension function in BaseCaller")
        }

        fun call(b: Base) {
            b.printFunctionInfo()   // call the extension function
        }
    }

    // dispatch receiver type
    class DerivedCaller: BaseCaller() {
        override fun Base.printFunctionInfo() {
            println("Base extension function in DerivedCaller")
        }

        override fun Derived.printFunctionInfo() {
            println("Derived extension function in DerivedCaller")
        }
    }

    fun main() {
        BaseCaller().call(Base())   // "Base extension function in BaseCaller"
        DerivedCaller().call(Base())  // "Base extension function in DerivedCaller" - dispatch receiver is resolved virtually
        DerivedCaller().call(Derived())  // "Base extension function in DerivedCaller" - extension receiver is resolved statically
    }

// Derived.printFunctionInfo 一直没有被调用过, 都是调用的Base.printFunctionInfo, 因为是静态调用.

## Data classes

    data class User(val name: String, val age: Int)

> 数据类必须有主构造函数, 主构造函数最少有一个参数, 参数必须使用`val`或者`var`修饰, 不能是`abstract`, 
> `open`, `sealed`, `inner`.

> 数据类会根据主构造函数中参数自动生成下面函数:
* quals()/hashCode() pair
* toString() of the form "User(name=John, age=42)"
* componentN() functions corresponding to the properties in their order of declaration.
* copy() function (see below).

> 自动生成函数继承规则:
* If there are explicit implementations of equals(), hashCode(), or toString() in the data class body or final implementations in a superclass, then these functions are not generated, and the existing implementations are used.
* If a supertype has componentN() functions that are open and return compatible types, the corresponding functions are generated for the data class and override those of the supertype. If the functions of the supertype cannot be overridden due to incompatible signatures or due to their being final, an error is reported.
* Providing explicit implementations for the componentN() and copy() functions is not allowed.

> On the JVM, if the generated class needs to have a parameterless constructor, default values for the properties have to be specified (see Constructors).

    data class User(val name: String = "", val age: Int = 0)

> 数据类可以声明属性, 但是自动生成的函数不使用这些属性.
> copy()函数

    val jack = User(name = "Jack", age = 1)
    val olderJack = jack.copy(age = 2)

> Standard data classes
> The standard library provides the Pair and Triple classes. In most cases, though, named data classes are a better design choice because they make the code more readable by providing meaningful names for the properties.

## Sealed classes

> 封闭类是抽象类, 必须在编译时知道所有实现类. 编译过后不准继承实现.
> 封闭类只能包含抽象成员, 构造函数可见性只有`protected`(默认)和`private`
> 实现类必须跟封闭类同一个包.
> 枚举不能继承封闭类, 但是可以实现接口.
> 封闭类子类可以被扩展
> Inheritance in multiplatform projects, 不能使用`expect`和`actual`
> Sealed classes and when expression, 因为子类已经确定, 如果when覆盖了所有子类, 那么可以不用实现else

    sealed interface Error

    sealed class IOError(): Error

    class FileReadError(val file: File): IOError()
    class DatabaseError(val source: DataSource): IOError()

    object RuntimeError : Error

## [Generics: in, out, where](https://kotlinlang.org/docs/generics.html)

> declaration-site variance

    // out variance annotation
    interface Source<out T> {
        fun nextT(): T
    }

    fun demo(strs: Source<String>) {
        val objects: Source<Any> = strs // This is OK, since T is an out-parameter
        // ...
    }

> 告诉编译器使用T的超类获取

    // in variance annotation
    interface Comparable<in T> {
        operator fun compareTo(other: T): Int
    }

    fun demo(x: Comparable<Number>) {
        x.compareTo(1.0) // 1.0 has type Double, which is a subtype of Number
        // Thus, you can assign x to a variable of type Comparable<Double>
        val y: Comparable<Double> = x // OK!
    }

> 告诉编译器使用T子类设置

### type projections

    fun copy(from: Array<out Any>, to: Array<Any>) { ... }

### Star-projections

* For Foo<out T : TUpper>, where T is a covariant type parameter with the upper bound TUpper, Foo<*> is equivalent to Foo<out TUpper>. This means that when the T is unknown you can safely read values of TUpper from Foo<*>.
* For Foo<in T>, where T is a contravariant type parameter, Foo<*> is equivalent to Foo<in Nothing>. This means there is nothing you can write to Foo<*> in a safe way when T is unknown.
* For Foo<T : TUpper>, where T is an invariant type parameter with the upper bound TUpper, Foo<*> is equivalent to Foo<out TUpper> for reading values and to Foo<in Nothing> for writing values.

> 如果声明为interface Function<in T, out U>, 则可以使用:
* Function<*, String> means Function<in Nothing, String>.
* Function<Int, *> means Function<Int, out Any?>.
* Function<*, *> means Function<in Nothing, out Any?>.

> Star-projections are very much like Java's raw types, but safe.

### Generic functions

    fun <T> singletonList(item: T): List<T> {
        // ...
    }

    fun <T> T.basicToString(): String { // extension function
        // ...
    }

### Generic constraints

> Upper bounds, 相当与java extends

    fun <T : Comparable<T>> sort(list: List<T>) {  ... }

### Type erasure

> kotlin是在编译是泛型类型检查, 运行时类型也会擦除

> Generics type checks and casts, 使用`is`

    fun handleStrings(list: MutableList<String>) {
        if (list is ArrayList) {
            // `list` is smart-cast to `ArrayList<String>`
        }
    }

> Unchecked casts, 使用`as`, 不进行运行时检查

    fun readDictionary(file: File): Map<String, *> = file.inputStream().use {
        TODO("Read a mapping of strings to arbitrary elements.")
    }

    // We saved a map with `Int`s into this file
    val intsFile = File("ints.dictionary")

    // Warning: Unchecked cast: `Map<String, *>` to `Map<String, Int>`
    val intsDictionary: Map<String, Int> = readDictionary(intsFile) as Map<String, Int>

> @Suppress("UNCHECKED_CAST")去掉警告

### Underscore operator for type arguments

> The underscore operator _ can be used for type arguments, Use it to automatically infer a type of the argument when other types are explicitly specified

    abstract class SomeClass<T> {
        abstract fun execute() : T
    }

    class SomeImplementation : SomeClass<String>() {
        override fun execute(): String = "Test"
    }

    class OtherImplementation : SomeClass<Int>() {
        override fun execute(): Int = 42
    }

    object Runner {
        inline fun <reified S: SomeClass<T>, T> run() : T {
            return S::class.java.getDeclaredConstructor().newInstance().execute()
        }
    }

    fun main() {
        // T is inferred as String because SomeImplementation derives from SomeClass<String>
        val s = Runner.run<SomeImplementation, _>()
        assert(s == "Test")

        // T is inferred as Int because OtherImplementation derives from SomeClass<Int>
        val n = Runner.run<OtherImplementation, _>()
        assert(n == 42)
    }


## Nested and inner classes

> kotlin 可以嵌套其它类和接口, 标记为`inner`为内部类, 维持外部类的引用, 可以访问外部类的成员.
> 可以使用`object expression` 创建医名内部类

    window.addMouseListener(object : MouseAdapter() {

        override fun mouseClicked(e: MouseEvent) { ... }

        override fun mouseEntered(e: MouseEvent) { ... }
    })

## Enum classes

    enum class Color(val rgb: Int) {
        RED(0xFF0000),
        GREEN(0x00FF00),
        BLUE(0x0000FF)
    }

> Anonymous classes

    enum class ProtocolState {
        WAITING {
            override fun signal() = TALKING
        },

        TALKING {
            override fun signal() = WAITING
        };

        abstract fun signal(): ProtocolState
    }

> Implementing interfaces in enum classes

    enum class IntArithmetics : BinaryOperator<Int>, IntBinaryOperator {
        PLUS {
            override fun apply(t: Int, u: Int): Int = t + u
        },
        TIMES {
            override fun apply(t: Int, u: Int): Int = t * u
        };

        override fun applyAsInt(t: Int, u: Int) = apply(t, u)
    }

> Working with enum constants

    EnumClass.valueOf(value: String): EnumClass
    EnumClass.values(): Array<EnumClass>

## Inline classes

> 实现包装器类, 但没有创建新堆栈和解包的开销, 允许创建方法和属性, 也有init块. 允许继承接口

    // For JVM backends
    @JvmInline
    value class Password(private val s: String)

> The inline modifier for inline classes is deprecated.

### Representation

> kotlin会为每个inline class生成一个包装器, 一般情况会直接使用底层类型如: Int => int, Integer
> 如果其他情况就需要使用包装器类型.

    interface I

    @JvmInline
    value class Foo(val i: Int) : I

    fun asInline(f: Foo) {}
    fun <T> asGeneric(x: T) {}
    fun asInterface(i: I) {}
    fun asNullable(i: Foo?) {}

    fun <T> id(x: T): T = x

    fun main() {
        val f = Foo(42)

        asInline(f)    // unboxed: used as Foo itself
        asGeneric(f)   // boxed: used as generic type T
        asInterface(f) // boxed: used as type I
        asNullable(f)  // boxed: used as Foo?, which is different from Foo

        // below, 'f' first is boxed (while being passed to 'id') and then unboxed (when returned from 'id')
        // In the end, 'c' contains unboxed representation (just '42'), as 'f'
        val c = id(f)
    }

### Mangling

> 因为kotlin会优先使用底层类型, 但在kotlin里会有类型冲突, 如: Int => int; UInt -> int都会转成一个签名.
> 解决这个冲突, kotlin会为Uint创建不一样的签名, fun compute(x: UInt) { } => public final void compute-<hashcode>(int x), 添加一些hashcode
> kotlin 1.4.30使用新的方案解决冲突, 与原兼容`-Xuse-14-inline-classes-mangling-scheme`

### Calling from Java code

> 需要手动解决冲突, 使用`@JvmName`指定新的签名

    @JvmInline
    value class UInt(val x: Int)

    fun compute(x: Int) { }

    @JvmName("computeUInt")
    fun compute(x: UInt) { }

### Inline classes and delegation

    interface MyInterface {
        fun bar()
        fun foo() = "foo"
    }

    @JvmInline
    value class MyInterfaceWrapper(val myInterface: MyInterface) : MyInterface by myInterface

    fun main() {
        val my = MyInterfaceWrapper(object : MyInterface {
            override fun bar() {
                // body
            }
        })
        println(my.foo()) // prints "foo"
    }

## Object expressions

> 创建一个新的对象, 对原类进行细微修改, 而不需要创建新的子类.

> Creating anonymous objects from scratch, 使用`object`创建匿名对象

    val helloWorld = object {
        val hello = "Hello"
        val world = "World"
        // object expressions extend Any, so `override` is required on `toString()`
        override fun toString() = "$hello $world"
    }

> Inheriting anonymous objects from supertypes, 使用`:`可以使匿名对象继承超类, 必要时需要对超类传参

    open class A(x: Int) {
        public open val y: Int = x
    }

    interface B { /*...*/ }

    val ab: A = object : A(1), B {
        override val y = 15
    }

> Using anonymous objects as return and value types, 当匿名对象返回方法或者属性, 并且这个成员是私有并且不是内联时
> 使用通过这个成员访问这个匿名对象所有成员. 如果不是私有或者是内联, 那么匿名对象类型:

* Any if the anonymous object doesn't have a declared supertype
* The declared supertype of the anonymous object, if there is exactly one such type
* The explicitly declared type if there is more than one declared supertype

> 上面这3种情况创建的匿名对象, 成员都不可访问

    class C {
        private fun getObject() = object {
            val x: String = "x"
        }

        fun printX() {
            println(getObject().x)
        }
    }

> Accessing variables from anonymous objects, 可以访问外部函数变量

## Object declarations

> 对象声明不能是局部的
> Singleton pattern 

    object DataProviderManager {
        fun registerDataProvider(provider: DataProvider) {
            // ...
        }

        val allDataProviders: Collection<DataProvider>
            get() = // ...
    }

> Companion objects, 某些情况伴生对象名可以省略, 看起来像静态类, 但是是个实例对象, 可以继承接口
> 可以使用`@JvmStatic`修饰伴生对象, 生成真的静态成员

    class MyClass {
        companion object Factory {
            fun create(): MyClass = MyClass()
        }
    }

    val instance = MyClass.create()

语义差别:
* Object expressions, 使用时初始化, 不变的
* Object declarations, 延迟初始化, 第一次访问时初始化
* companion object, 加载类时初始化伴生对象, 语义与Java静态初始化一样

## Delegation

> kotlin 实现` Delegation pattern`, 使用by, 编译器会保存Base对象, 通过Derived代理Base所有方法.
> 代理类可以重写方法, 代理类重写属性不会生效, 永远会调用被代理类的属性.

    interface Base {
        fun printMessage()
        fun printMessageLine()
    }

    class BaseImpl(val x: Int) : Base {
        override fun printMessage() { print(x) }
        override fun printMessageLine() { println(x) }
    }

    class Derived(b: Base) : Base by b {
        override fun printMessage() { print("abc") }
    }

    fun main() {
        val b = BaseImpl(10)
        Derived(b).printMessage()
        Derived(b).printMessageLine()
    }

## Delegated properties

Lazy properties: the value is computed only on first access.
Observable properties: listeners are notified about changes to this property.
Storing properties in a map instead of a separate field for each property.

    class Example {
        var p: String by Delegate()
    }

    import kotlin.reflect.KProperty

    class Delegate {
        operator fun getValue(thisRef: Any?, property: KProperty<*>): String {
            return "$thisRef, thank you for delegating '${property.name}' to me!"
        }

        operator fun setValue(thisRef: Any?, property: KProperty<*>, value: String) {
            println("$value has been assigned to '${property.name}' in $thisRef.")
        }
    }

> Standard delegates

* Lazy properties: 当第一次访问getter时调用lambda并记住值, 以后都返回记住的值. 默认是同步的, 如果想异步
    使用LazyThreadSafetyMode.PUBLICATION, 作为lazy()参数. LazyThreadSafetyMode.NONE, 不产生任务同步代码.

    val lazyValue: String by lazy {
        println("computed!")
        "Hello"
    }

    fun main() {
        println(lazyValue)
        println(lazyValue)
    }

* Observable properties, Delegates.observable() Delegates.vetoable(), 当有新值的时候调用.

    import kotlin.properties.Delegates

    class User {
        var name: String by Delegates.observable("<no name>") {
            prop, old, new ->
            println("$old -> $new")
        }
    }

    fun main() {
        val user = User()
        user.name = "first"
        user.name = "second"
    }

### Delegating to another property

> 一个属性可以委托给另一个属性, 用一个新属性替代旧属性时非常有用
The delegate property can be:
* A top-level property
* A member or an extension property of the same class
* A member or an extension property of another class

    var topLevelInt: Int = 0
    class ClassWithDelegate(val anotherClassInt: Int)

    class MyClass(var memberInt: Int, val anotherClassInstance: ClassWithDelegate) {
        var delegatedToMember: Int by this::memberInt
        var delegatedToTopLevel: Int by ::topLevelInt

        val delegatedToAnotherClass: Int by anotherClassInstance::anotherClassInt
    }
    var MyClass.extDelegated: Int by ::topLevelInt


### Storing properties in a map

    class User(val map: Map<String, Any?>) {
        val name: String by map
        val age: Int     by map
    }

    val user = User(mapOf(
        "name" to "John Doe",
        "age"  to 25
    ))

### Local delegated properties

    fun example(computeFoo: () -> Foo) {
        val memoizedFoo by lazy(computeFoo)

        if (someCondition && memoizedFoo.isValid()) {
            memoizedFoo.doSomething()
        }
    }

### Type aliases

    typealias Predicate<T> = (T) -> Boolean


## Reference
[Classes](https://kotlinlang.org/docs/classes.html)  
