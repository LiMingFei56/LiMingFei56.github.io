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

## 基本类型

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
|String   | String       | "abc" """abc""""                                    | +1     |

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

## Declaration And Definition Variable
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

## Control Flow
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



### Python

