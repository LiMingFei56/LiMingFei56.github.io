---
layout: page
permalink: /program-language/grammar
---


<!--
    ### C
    ### C++
    ### Objc
    ### Java
    ### Kotlin
    ### Swift
    ### Python
-->

Grammar

* [1.Basic Type](#1)
* [2.Declaration And Definition Variable](#2)
* [3.Control Flow](#3)
* [4.Function And Lambda](#4)

<h2 id="1">1.Basic Type</h2>

### C

|Type     | Type Express | Explanation                              | Format Specifier    | sizeof |
|---------|--------------|------------------------------------------|---------------------|--------|
|Character| char         | 'A' or 65 or 0x41 or 0101                | %c                  | 1      |
|String   | char [] or * | "abc" or {'a', 'b', 'c', '\0'}           | %s                  | +1     |
|Integer  | int          | 65 or 0x41 or 0101                       | %d                  | 4      |
|         | short int    | 65 or 0x41 or 0101                       | %hi                 | 2      |
|         | long int     | 65 or 0x41 or 0101                       | %ld                 | 8      |
|         | long long int| 65 or 0x41 or 0101                       | %lli                | 8      |
|Float    | float        | 0.01 or 1E-2                             | %f or %g or %e or %a| 4      |
|         | double       | 0.01 or 1E-2                             | %f or %g or %e or %a| 8      |
|         | long double  |                                          |                     | 8      |
|Singed   |              | singed 和 unsinged                       |                     |        |
|Boolean  |              | 0 = flase ; 非0 = true                   |                     |        |
|Point    | type *v      | char *s = "abc";                         | %lu                 | 8      |
|Void     | void         | 表示无类型，通常跟Point一起使用          |                     |        |

***不支持二进制表示***
***整数默认为int, 浮点数默认为double***

### C++
同C

Boolean 使用bool表示, 0 = false; 非0 = true。 长度为1;

***不支持二进制表示***
***整数默认为int, 浮点数默认为double***

### Objc
同C

***不支持二进制表示***
***整数默认为int, 浮点数默认为double***

### Java

|Type     | Type Express | Explanation                              | sizeof |
|---------|--------------|------------------------------------------|--------|
|Byte     | byte or Byte | 1 or 0x1 or 01 or 0b0000001 or 000_001   | 1      |
|Character| char or Character | '1' 49 or 0x31 or 061 or 0b00110001 | 2      |
|Short    | short or Short | 1 or 0x1 or 01 or 0b00000001           | 2      |
|Integer  | int or Integer | 1 or 0x1 or 01 or 0b00000001           | 4      |
|Long     | long or Long   | 1 or 0x1 or 01 or 0b00000001 or 1l     | 8      |
|Float    | float or Float | 0.01 or 1e-2 or 0.01f                  | 4      |
|Double   | double or Double  | 0.01 or 1e-2 or 0.01                | 8      |
|Boolean  | boolean or Boolean| true or false 1不等于true           | 1      |
|String   | String         | "abc"                                  | +1     |
|Void     | Void or void   | 表示无类列，不能单独使用               |        |


***数值支持下划线***

### Kotlin

|Type     | Type Express | Explanation                              | sizeof |
|---------|--------------|------------------------------------------|--------|
|Double   | Double       | 123.5, 123.5e10                          | 8      |
|Float    | Float        | 123.5f                                   | 4      |
|Long     | Long         | 123L or 0x0F or 0b00000001               | 8      |
|Int      | Int          | 123 or 0x0F or 0b00000001                | 4      |
|Short    | Short        | 123 or 0x0F or 0b00000001                | 2      |
|Byte     | Byte         | 123 or 0x0F or 0b00000001                | 2      |
|Character| Char         | '' 不是一个数字                          |        |
|Boolean  | Boolean      | true or flast 不是一个数字               |        |
|String   | String       | "abc" """abc"""                          | +1     |
|Unit     | Unit         | 相当与java的void，表示无类型             |        |
|Nothing  | Nothing      | 表示没有实例，永远到不了的地方           |        |

***不支持8进制***
***数值支持下划线***
***整数默认为int, 浮点数默认为double***

### Swift

|Type     | Type Express | Explanation                              | sizeof |
|---------|--------------|------------------------------------------|--------|
|Double   | Double       | 123.5 or 1.24e2 or 0xFp2                 | 8      |
|Float    | Float        | 123.5f                                   | 4      |
|Int      | Int          | 123 or 0b or 0o or 0x                    | 4      |
|         | Int8 Int16 Int32 Int64 UInt8 UInt16 UInt32 UInt64       |        |
|Character| Character    | "" 字符串扩展字形，近似字符              |        |
|Boolean  | Bool         | true or flast 不是一个数字               |        |
|String   | String       | "abc" """abc"""                          | +1     |

***数值支持下划线***
***整数默认为int, 浮点数默认为double***

### Python

|Type     | Type Express | Explanation                               |
|---------|--------------|-------------------------------------------|
|Integer  | int          | 123                                       |
|Float    | float        | 123.5                                     |
|String   | str          | '' or "" or r"" or u"" or """             |

***数值支持下划线***


<h2 id="2">2.Declaration And Definition Variable</h2>

### C
定义是特殊的声明，会分配内存并初始化；
    
    // 变量
    int i;
    extern int i;
    static int i;
    
    // 常量
    const int i;
    extern const int i;
    static const int i;
    
    #define i 123;

### C++
同C

### Objc
同C

### Java

    //变量
    int i;

    //常量
    final int i;

### Kotlin
支持类型推导，可以根据初始化值类型来导推出类型，所以可以省略类型定义

    //变量
    var i: Int

    //常量
    val i: Int

### Swift
支持类型推导，可以根据初始化值类型来导推出类型，所以可以省略类型定义

    //变量
    var i: Int

    //常量
    let i: Int

### Python

    i = 12

<h2 id="3">3.Control Flow</h2>

### C

#### IF Statement

    if () {
    } else if() {
    } else {
    }

#### SWITCH Statement
switch的分支是可以穿透的(Fallthrough)，需要使用`break`语句来打断穿透

    switch(){
        case :
            break;
        default:
            break;
    }

#### FOR Statement

    for( ; ;){}

#### WHILE Statement

    while(){}

#### DO-WHILE Statement

    do{}while();

#### Jumps

    break 打断穿透；跳出当前循环
    continue 路过当前循环，并开始下一次

### C++
同C

### Objc
同C

### Java
同C

#### FOREACH Statement
Like C# foreach ，循环Iterator

Interator:
    * 实现Iterator接口

    for (item: <Iterator>){}

### Kotlin

#### IF Expression
if是表达式，会返回一个值，括号最后一个表达式就是返回的值

    var a = if(a < b) a else b

    if () {
    } else if () {
    } else {
    }

#### WHEN Expression
when是表达式， 大括号中最后一个表达式就是返回值
when分支不是穿透的(Fallthrough)，不用使用break语句

        var a = when(d1){
            123.0 -> "小于"
            123.5 -> "大于"
            else -> "else"
        }

分支条件只能是常量或者Boolean值，多个条件使用','分隔，可以使用in is表达式

#### For Statement
C#类型的foreach，循环Iterator

Iterator:
    * 成员或扩展函数 iterator(), 返回type
    * 成员或扩展函数 next(), 返回boolean
    * 成员或扩展函数 hasNext(), 返回boolean
    * 这三个方法必须使用`operator`修饰

    for (item in collection) print(item)

    for (i in array.indices) {
        print(array[i])
    }

    for ((index, value) in array.withIndex()) {
        println("the element at $index is $value")
    }

#### While Statement

    while (x > 0) {
        x--
    }

#### Do..while Statement

    do {
        val y = retrieveData()
    } while (y != null) // y is visible here!

#### Jumpe

    break. 终止最近的封闭循环
    continue. 进入最近的封闭循环的下一步

Labels. 在循环前加上labelname@,可以控制指定的循环（内层终止外层）

    loop@ for (i in 1..100) {
        for (j in 1..100) {
            if (...) break@loop
        }
    }

### Swift

#### If Statement

    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }

#### Switch Statement

* 不会显示的穿透(Fallthough)
* 条件可以有多个，使用','分隔
* 可以使用Interval Matching
* 可以使用元组
* 可以使用let，值绑定
* 可以使用where，做额外的比较


    // normal
    switch some value to consider {
        case value 1:
            respond to value 1
        case value 2,
             value 3:
            respond to value 2 or 3
        default:
            otherwise, do something else
        }

    // Interval Matching
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    let naturalCount: String
    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")

    // Tuple
    let somePoint = (1, 1)
    switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
    }

    // Where
    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }


#### For Statement
Like C# foreach, 循环迭代Iterator，数组，Range, String, Dictionary

    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names {
        print("Hello, \(name)!")
    }

#### While Statement

    while condition {
        statements
    }

#### Repeat-While Statement

    repeat {
        statements
    } while condition

#### Guard Statement
提前退出，判断一个条件是否成立，如果不成立就会执行else语句，该语句中最后只能return, break, continue, or throw

    guard let name = person["name"] else {
        return
    }

#### Jumpe

    continue - 跳过当前循环，进入下一步
    break - loop(结束最近的loop);switch(结束当前分支)
    Fallthrough - 开启Switch穿透

Labeled Statement

    label name: while condition {
        statements
    }
    
    break label name

### Python

#### If Statement

    if_stmt ::=  "if" expression ":" suite
             ( "elif" expression ":" suite )*
             ["else" ":" suite]

#### For Statement
迭代Sequence

    for_stmt ::=  "for" target_list "in" expression_list ":" suite
              ["else" ":" suite]

#### While Statement

    while_stmt ::=  "while" expression ":" suite
                ["else" ":" suite]

#### Jumpe

    continue - 继续下一个迭代
    break    - 结束当前迭代
    pass     - 占位符，什么都不做，一般表示还没有实现


<h2 id="4">4.Function And Lambda</h2>
### C

#### Function

    // 函数原型，声明在头文件中
    <return_type> function_name(parameter_list);

    // 定义需要跟函数原型的参数类型和返回类型一至,收用函数原型的头文件
    <return_type> function_name(parameter_list){
    }

#### inline
使用inline修饰的函数为内联函数

### C++
同C

### Objc

#### Function

    // 函数声明
    -(return_type)function_name:(one_parameter_type)one_parameter_name two_argument_label:(two_parageter_type)two_parageter_name;

    // 函数定义
    -(return_type)function_name:(one_parameter_type)one_parameter_name two_argument_label:(two_parageter_type)two_parageter_name{
    }

#### Block

    // Block 声明
    double (^multiplyTwoValues)(double, double);

    // Block 定义
    ^ (double firstValue, double secondValue) {
        return firstValue * secondValue;
    }

    使用__block修饰closure中变量的值，不然是只读的

#### Inline
使用inline修饰的函数为内联函数

### Java

#### Function

    public void myFunction(int a, int b){
    }

#### Lambda jdk 8
只支持functional interfaces（SAM(单一抽象方法/Single Abstract Method)），相当与匿名函数

    // 1. 不需要参数,返回值为 5  
    () -> 5  
      
    // 2. 接收一个参数(数字类型),返回其2倍的值  
    x -> 2 * x  
      
    // 3. 接受2个参数(数字),并返回他们的差值  
    (x, y) -> x – y  
      
    // 4. 接收2个int型整数,返回他们的和  
    (int x, int y) -> x + y  
      
    // 5. 接受一个 string 对象,并在控制台打印,不返回任何值(看起来像是返回void)  
    (String s) -> System.out.print(s)  

#### Inline
使用关键字`final`修饰的函数为内联函数

### Kotlin

#### Function

    fun read(b: Array<Byte>, off: Int = 0, len: Int = b.size): Int {
        ...
    }

    fun double(x: Int): Int = x * 2

infix Function:
* 成员函数或扩展函数
* 单个函数参数
* 使用`infix`修饰


    infix fun Int.shl(x: Int): Int {
    ...
    }

    // call extension function using infix notation

    1 shl 2

嵌套函数:

    fun dfs(graph: Graph) {
        fun dfs(current: Vertex, visited: Set<Vertex>) {
            if (!visited.add(current)) return
            for (v in current.neighbors)
                dfs(v, visited)
        }
    
        dfs(graph.vertices[0], HashSet())
    }

#### Lambda

    // 声明
    (T, T) -> Boolean

    // 定义
    { x: Int, y: Int -> x + y }

Anonymous Functions

    fun(x: Int, y: Int): Int = x + y

Function Literals with Receiver

    sum : Int.(other: Int) -> Int
    1.sum(2)

#### inline
内联函数 - 使用关键字`inline`修饰
非内联函数 - 使用关键字`noinline`修饰

    inline fun foo(inlined: () -> Unit, noinline notInlined: () -> Unit) {
        // ...
    }

#### Tail recursive functions

    tailrec fun findFixPoint(x: Double = 1.0): Double
        = if (x == Math.cos(x)) x else findFixPoint(Math.cos(x))

### Swift
#### Function
    
    func greet(person: String, alreadyGreeted: Bool = false) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }
    print(greet(person: "Tim", alreadyGreeted: true))

    // 多个返回对象
    func minMax(array: [Int]) -> (min: Int, max: Int)?  

    // 声明argument labels
    func someFunction(argumentLabel parameterName: Int)

    // 嵌套函数
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }

#### Function type
    
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    (Int, Int) -> Int

#### Lambda

    { (parameters) -> return type in
        statements
    }

    { (s1: String, s2: String) -> Bool in
        return s1 > s2
    }

Operator Methods

Trailing Closures

    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // function body goes here
    }

    someFunctionThatTakesAClosure(closure: {
        // closure's body goes here
    })

Escaping Closures
    
    @escaping

Autoclosures

    @autoclosure

### Python

#### Function
    
    def fib(n)
    // Argument Values
    def ask_ok(prompt, retries=4, reminder='Please try again!'):
    // Keyword Arguments
    def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    // Arbitrary Argument Lists
    def write_multiple_items(file, separator, *args):
    // Unpacking Argument Lists
    def parrot(voltage, state='a stiff', action='voom'):
    d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
    parrot(**d)

#### Lambda
Small anonymous functions

    lambda a, b: a+b

