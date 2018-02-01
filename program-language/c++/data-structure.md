---
layout: page
permalink: /program-language/c++/data-structrue
---

Data structrue

### 基本数据类型

|Type     | Type Express | Explanation                              | Format Specifier    | sizeof |
|---------|--------------|------------------------------------------|---------------------|--------|
|Character| char         | 'A' or 65 or 0x41 or 0101                | %c                  | 1      |
|         | wcha_t       |                                          |                     | 2或者4 |
|         | char16_t     |                                          |                     | 2      |
|         | char32_t     |                                          |                     | 4      |
|String   | char [] or * | "abc" or {'a', 'b', 'c', '\0'}           | %s                  | +1     |
|Integer  | int          | 65 or 0x41 or 0101                       | %d                  | 4      |
|         | short int    | 65 or 0x41 or 0101                       | %hi                 | 2      |
|         | long int     | 65 or 0x41 or 0101       l               | %ld                 | 8      |
|         | long long int| 65 or 0x41 or 0101       ll              | %lli                | 8      |
|Float    | float        | 0.01 or 1E-2                             | %f or %g or %e or %a| 4      |
|         | double       | 0.01 or 1E-2                             | %f or %g or %e or %a| 8      |
|         | long double  |                                          |                     | 8      |
|Singed   |              | singed 和 unsinged       u               |                     |        |
|Boolean  |              | 0 = flase ; 非0 = true                   |                     |        |
|Point    | type *v      | char *s = "abc";                         | %lu                 | 8      |
|Void     | void         | 表示无类型，通常跟Point一起使用          |                     |        |

Boolean 使用bool表示, 0 = false; 非0 = true。 长度为1;

***不支持二进制表示***
***整数默认为int, 浮点数默认为double***

### 类型转换
什么情况需要类型转换：
* 将一种算术类型的值赋给另一种算术类型的变量时
* 表达式中包含不同的类型时
* 将参数传递给函数时

#### 自动转换，类型提升
表达式中的转换，char和short会转换成int,float会转换成double，计算后再转换回来

低等级类型会自动转换成高等级类型:
long double
double
float
unsigned long long
signed long long

### 类型推断
使用auto关键字可以类型自动推断：
* 整型一般推断为int
* 浮点型一般推断为double
* 有后缀就按照后缀类型来

一般用在复杂的类型声明中

    std::vector<double> scores;
    std::vector<double>::iterator pv = scores.begin();

    std::vector<double> scores;
    auto pv = scores.begin();
