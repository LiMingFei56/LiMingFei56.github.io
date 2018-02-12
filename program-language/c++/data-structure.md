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

### Array

    //声明数组
    typeName arrayname[arraySize];

    // 初始化
    int cards[4] = {3, 6, 8, 10};
    int cards[4] = {3, 6}; // 其他设置为0
    double earnings[4] {1, 2}; // C++11初始化方法 其他设置为0

### String

    string str1;
    string str2 = "panther";

    // C++11
    char first_date[] = {"Le Chapon Dodu"};
    char second_date[] = {"The Elegant Plate"};
    string third_date = {"The Bread Bow"};

    L"Chief Astrogator"; // w_char string
    u"Felonia Ripova"; // char_16 string
    U"Humber Super Snipe"; // char_32 string
    u8"UTF-8"; // 1~4位字符
    R"\n"; 原始字符

### Struct 同c
    
    struct inflatable
    {
        char name[20];
        float volume;
        double price;
    };

    //C++11 初始化
    inflatable duck {"Daphne"}; // 未设置的都设置为0

### Union 同c

    union one4all
    {
        int int_val;
        long long_val;
        double double_val;
    };

### Enum 同c

    enum spectrum
    {
        red
        , orange
        , yellow
        , green
        , blue
        , violet
        , indigo
        , ultraviolet
    };

### 指针 同c
指针与数组基本等价的原因在于指针算术和C++内部处理数组的方式。

指针算术:
数组: 数组+1 就是值加1
指针：指针+1 就是指针+1*指针类型字节

数组地址:
数组名被解释为其第一个元素的地址，而对数组名应用地址运算符时，得到的是整个数组的地址。

    short tell[10];
    cout << tell << endl; // displays &tell[0]
    cout << &tell << endl; // displays address of whole array

&tell[0] - 是一个2字节内存块
&tell - 是一个20字节的内存块

### 模板类vector
    
    #include <vector>
    using namespace std;

    vector<double> a2(4);
    a2[1] = 1.0 / 5.0;

### 模板类array c++11

    #include <array>
    using namespace std;

    array<double, 4> a3 = {};
    a3 = a3;

    a3[1] = 12;

### 智能指针模板类
智能指针是行为类似于指针的类对象，可以用来帮助管理动态内存分配。动态分配内存后，忘记
或者产生异常，而没有调用delete，那么会导至内存泄漏。智能指针可以使指针被释放时，也释放
指针指向的内存。

* auto_ptr C++98   C++11中被摒弃
* unique_ptr C++11
* shared_ptr C++11
* weak_ptr

这三个智能指针模析都定义了类似指针的对象，可以将new获得(直接或间接)的地址赋给这种对象。
当智能指针过期时，其析构函数将使用delete来释放内存

    auto_ptr<double> pd(new double);
    unique_prt<double> pdu(new double);
    shared_prt<double> pss(new double);

区别：
> auto_ptr 可以指向同一个对象，所以程序将试图删除同一个对象两次。解决这个问题有3个方法，
第一种是定义赋值运算符，使之执行深复制；
第二种建立所有权(ownership)概念，这就是unique_ptr；
第三种是使用引用计数(reference counting)，这就是shared_prt；

### 容器

#### 迭代器

* 输入迭代器：只读，单向，单通过
* 输出迭代器：只写，单向，单通行
* 正向迭代器：读写，迭代顺序相同
* 双向迭代器：同正向迭代器，并且支持递减运算符
* 随机访问迭代器：支持随机访问

#### 容器种类

##### 序列
* vector - 数组，自动内存管理，可变长度，随机访问
* deque - 双端队列，like vector
* list - 双向链表
* forward_list - 单链表
* queue - 适配器类，提供典型的队列接口
* priority_queue - 适配器类，最大的元素被移到队首
* stack - 适配器类，提供典型的栈接口
* array - 数组，长度固定

##### 关联容器
* set - 关联集合，可反转，可排序，键唯一
* multimap - 可反转，可排序，一个键对应多个值

无序关联容器
* unordered_set
* unordered_multiset
* unordered_map
* unordered_multimap
