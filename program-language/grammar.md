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

#### IF Expression

    if () {
    } else if() {
    } else {
    }

#### SWITCH Expression
    switch(){
        case :
            break;
        default:
            break;
    }

#### FOR Expression

    for( ; ;){}

#### WHILE Expression

    while(){}

#### DO-WHILE Expression

    do{}while();

### C++
同C

### Objc
同C

### Java
同C

#### FOREACH Expression

    foreach;

### Kotlin
    
    if Expression 是表达式，大括号中最后一个表达式就是返回值

    when Expression 是表达式， 大括号中最后一个表达式就是返回值
        when {
            x.isOdd() -> print("x is odd")
            x.isEven() -> print("x is even")
            else -> print("x is funny")
        }
    不用break，每个分支是断开的

    for loops 为迭代器，相当于C# foreach，只作用于可迭代的
        array.indices
        array.withIndex()

    while () {}

    do {} while()

### Swift

    if expression {
    } else if expression {
    } else {
    }

    switch(){
        case :
        default:
    }
    不用break，每个分支是断开的

### Python

