---
layout: page
permalink: /program-language/c/data-structrue
---

Data structrue

### 基本数据类型

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


### 类型自动转换
1. 类型提升(promotion)：表达中有符号和无符号的char和short转换成int,(如果short大小和int相等，那么无符
    号short会转换成无符号int)；float会转换成double。
2. 运算中，操作数会转换成较高的类型级另。
3. 类型级别从高到低的顺序是long double,double,float,unsigned long long, long long, unsigned long,
    long, unsigned int, int(如果long长度和int相等，那么unsigned int比long的级别高)。short 和 char
    已经转换成int了。
4. 赋值语句，会把右操作数转成左操作类型，可能发生promotion，或者demotion。
5. 当函数参数传递中也会产生promotion,可以使用原型来阻止自动提升的发生。

### struct
1. 结构声明：struct
2. 初始化结构：使用{}
3. 访问结构成员：struct-value.属性
4. 声明结构数组：struct book library[MAXBKS]
5. 结构嵌套：在结构里定义结构
6. 结构指针：struct guy * him；
7. 结构指针取地址：&him
8. 结构指针访问成员：him->income
9. 结构赋值：把一个结构的内容赋值给另一个

    struct MyStruct
    {
        int x;
        int y;
    }a, b;

### union
1. 联合：union，是一个能在同一个存储空间里（但不同时）存储不同类型数据的数据类型。
2. 声明联合变量：union hold fit;
3. 访问：fit.valB
4. 指针访问：pu = &fit; x=pu->digit

    union hold {
       int digit;
       double bigfl;
       char letter;
    } 

    fit.digit = 5;
    union hold valB = valA;
    union hold valC = {88};
    union hold valD = {.bigfl = 118.2};

### enum
1. 枚举类型(enum)：声明代表整数常量的符号名称，enum常量是int类型
2. 枚举声明：enum spectrm {red};
3. 枚举声明变量：enum spectrm color;上面的括号里是color可能的值
4. 枚举默认值：从0开始
5. 枚举指定值：enum spectrm {red=100}，一个枚举只指定一个值，后面的会被赋予后续的值。
6. 用法：switch
