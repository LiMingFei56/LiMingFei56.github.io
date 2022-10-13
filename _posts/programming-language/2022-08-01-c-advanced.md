---
layout: post
title: C高级知识
categories: lang
tags: [lang] 
date: 2022-08-01
---

## C高级知识

> C专家编程

1. if (a=3) 错误, 使用if (3 == a), 常量在左边, 如果写成等于的话会报错, 常量不能当左值
2. a == 3; 赋值语句写成比较, 现代语法检查会给出警告
3. const 关键字并不真正表示常量

### Features

* function Prototype
  - forward declaration

* usual arithmetic conversion
  - 整形升级
  - value preserving

[C99 LIST FOR NEW FEATURES](https://www.open-std.org/jtc1/sc22/wg14/www/newinc9x.htm)  
[C11 LIST FOR NEW FEATURES](https://en.wikipedia.org/wiki/C11_(C_standard_revision))  


> NUL代表`\0`用于结束一个ACSII字符串
> NULL用于表示空指针

* 寻常算术转换(类型提升) - 算术运算和参参传递时会隐式提升

### 关键字

* volatile : 标识变量是经常变化的, 告诉编译器取值写值要从内存中取.

### proposal

#### 对无符号类型的建议

* 尽量不要在你的代码中使用无符号类型
* 尽量使用像int那样的有符号类型
* 只有在使用位段和二进制掩码时, 才可以用无符号数


### 编码器

* unportable code
  1. implementation-defined
  2. unspecified
* bad code
  1. undefined behavior
  2. a constraint
* portable code
  1. strictly-conforming
  只使用已确定的特性
  不突破任何由编译器实现的限制
  不产生任何依赖由编译器定义的或未确定的或未定义的特性的输出
  2. conforming

> 编译限制, 对函数参数数量, 表达式嵌套的括号, 一行最多字符等的限制

### 预处理
`#pragmas` 向编译器传递信息 

> 判断是否是C++程序, 或者判断是否已包含头文件  使用宏判断

    #ifdef __cplusplus
    extern "C" {
    #endif /* __cplusplus */

    HEADER FILE	MACRO FOR CHECKING
    math.h	_MATH_H
    stdio.h	_STDIO_H
    assert.h	_ASSERT_H
    ctype.h	_CTYPE_H
    signal.h	_SIGNAL_H
    stdarg.h	_STDARG_H
    stdlib.h	_STDLIB_H

### 指针

* 悬垂指针(dangling pointer): 引用失效的东西, 悬在地址空间内.


### Bug

#### 不该做的做了(多做之过)

##### switch

1. 代码块中定义变量, 但是不一定执行
2. 默认使用 fall through 
3. 任何位置都可以定义标签, 并在执行时跳转到那里

##### 相邻的字符串常量将被自动合并成一个字符串

1. 创建字符串数组时, 漏掉了`,`不会发出错误信息

##### 缺省全局可见

1. interpositioning特性: 用户编写和库函数同名的函数并取而代之的行为

#### 该做的没做(少做之过)

1. lint程序错误地从编译器分离出来
2. shell参数解析
3. 在"\"和newline中的空格
4. 意外形式的注释
5. 编译器日期被破坏

##### lint 

> 早用lint程序, 勤用lint程序. lint程序是软件的道德准则. 当你做错事时, 它会告诉你哪里不
> 对. 应该始终使用lint程序, 按照它的道德准则办事.



#### 该做但做得不合适(误做之过)

1. 有些运算符的优先级是错误的
2. 运算符重载意义过多

![符号重载]((https://github.com/LiMingFei56/picturebed/raw/main/c-prefessional-program/c-symbol-overload.png)  
![运算符优先级问题]((https://github.com/LiMingFei56/picturebed/raw/main/c-prefessional-program/c-algorithm-priority.png)  

##### 意群

> 优先级和结合性规则告诉你哪些符号组成一个意群的同时, 这些意群内部如何进行计算的次序
> 始终是未定义的.
> 大部分编程语言并未明确规定操作数计算的顺序. 在不确定优先级时使用`()`.

    x = f() + g() * h();

    可以知道乘法是在加法之前执行.  但是不知道f(), g(), h()是什么时间执行, 执行顺序有
    可能是任意的.

> 结合性, 所以操作符都有左结合性或右结合性. 当操作符优先级一样时就需要考虑结合性.

### 声明

> 类型模型(type model)

    char * const *(*next) ();
    void (*signal(int sig, void(*func)(int)))(int);

你不可以像下面那样做：
* 函数的返回值不能是一个函数，所以像foo()()这样是非法的。
* 函数的返回值不能是， 一个数组，所以像foo()[]这样是非法的。
* 数组里南不能有两数，所以像foo[]()这样是非法的。
但像下面这样则是合法的：
* 函数的返回值允许是一个函数指针，如：int(\*fun())();
* 函数的返回值允许是一个指向数组的指针，如：int(\*foo())[]
* 数组里面允许有丽数指针，如int(\*foo[])()
* 数组里面允许有其他数组，所以你经常能看到int foo[][]


理解C语言声明的优先级规则:
A 声明从它的名字开始读取，然后按照优先级顺序依次读取。
B 优先级从高到低依次是：
    B. 1 声明中波括号括起来的那部分
    B. 2后缀操作符：
        括号（；表示这是一个函数，而
        方括号口表示这是一个数组
    B. 3前缀操作符：星号*表示“指向…的指针”
C 如果const 和（或）volatile 关键宇的后面紧跟类型说明符（如int,long 等），那么
它作用于类型说明符。在其他情况下，const 和（或）volatile 关键字作用于它左边
紧邻的指针星云

#### 声明和使用尽可能相似

    int *p[3];
    *p[i];

#### const

    const int * grape; // 指向的对象是只读的
    int const * grape; // 指向的对象是只读的
    int * const grape_jelly; // 指针是只读的

    const int * const grape_jam;
    int const * const grape_jam;


#### typedef

> 跟变量声明完全一样, 就是多了个关键字

1. 宏定义类型可以扩展修饰符, typedef不能
2. 宏定义类型只能字面值替换, 连续几个变量声明中, 不能保证变量
类型相同; typedef可以

### 数组和指针

区分定义和声明
只要记住下面的内容即可分清定义和声明：
声明相当于普通的声明：它所说明的并非自身，而是描述其他地方的创建的对象
定义相当于特殊的声明：它为对象分配内存。

* 左值(地址): 编译时可知
* 右值(地址的内容): 运行时可知

* 数组操作: char a[], a是一个字符数组起始地址.
* 指针操作: char \*p, p是一个指针, 保存一个指向字符内容的地址.
> 数组中可以直接取字符; 指针需要先取地址, 再根据地址取字符

    // 可以
    extern char p[];
    char *p;

    // 不可以, 少了一步取地址 
    extern char *p;
    char p[10];
    
> 初始化指针时所创建的字符串常量被定义为只读. 修改这个字符串是未定义的

数组与指针相等的情况:
* 表达式中的数组名被编译器当作一个指向该数组第一个元素的指针
* 下标总是与指针的偏移量相同
* 在函数参数的声明中, 数组名被编译器当作指向该数组第一个元素的指针.::

> 表达式中数组和指针可以互换, 因为它们在编译器里的最终形式都是指针, 并且都可以
> 进行取下标操作. 像加法一样, 取下标操作符的操作数是可以交换的, 所以a[6] 等效 6[a].

数组和指针可交换性的总结:
1. 用al这样的形式对数组进行访问总是被编详器“改写”或解释为像\*(a+1这样的指
针访问。
2. 指针始终就是指针。它绝不可以改写成数组。你可以用 下标形式访问指针，一般都是
指针作为函数参数时，而且你知道实际传递给两数的是-个数组。
3，在特定的上下文中，也就是它作为两数的参数（也只有这种情况），
一个数组的声盼
可以看作是一个指针。作为两数参数的数组（就是在一个两数调用中〉始终会被编译器修改
成为指向数组第一个元素的指针。
4. 因此，当把一个数组定义为两数的参数时，可以选择把它定义为数组，也可以定义指
针。不管选择哪种方法，在西数内部事实上获得的都是一个指针。
5. 在其他所有情况中，定义和声明必须匹配。如果定义了一个数组，在其他文体对它进
行声明时也必须把它声明为数组，指针也是如此。

> 数组的数组与多维数组的主要区别，就在于数组的数组各维之间的内在关系是一种鲜明的层级关系。
> 上一维把下一维看作下一级数组，也就是数组嵌套。数组引用时需要层层解析，直到最后一维。
> 在C语言的多维数组中, 最右边的下标是最先变化的, 这个约定被称为"行主序".

    int squash[i][j] 会声明几种形式, 解释为 *(*(squash + i) + j)
    int squash[23][12]
    int *squash[23]
    int **squash
    int (*squash)[12]
    取值也包含数组和指针的区别

    int main(int argc, char *argv[])

### a.out assember output 可执行文件

    a.out文件
    a.out的其他内容
    BSS段所需大小
    数据段
    文本段

> 载入器一般使用(mmap)取每个段的映像.

#### ELF executable and linking format

* 段 segments, 段就是一片连续的虚拟地址, 所以相邻的段被接合.
    A BSS段(Block Started by Symbol): 保存没有值的变量
    B 数据段: 初始化后的全局和静态变量
    C 文本段: 可执行文件的指令
    D 堆栈段: 保存局部变量, 临时数据, 传递到函数中的参数等. 函数调用时存储堆栈结构
        (stack frame, 也叫过程活动记录precedure activation recored). 用作暂时存储区(alloca函数).
    E 堆    : malloc() 动态分配的内存

* 页错误(page fault) - 当试图访问当前系统分配给堆栈空间之外时, 它将产生一个硬件中断
* 总线错误(bus fault) - 几乎都是由于未对齐的读或写引起的.
* 段错误(segmentation violation) - 内存管理单元的异常所致, 解除引用一个未初始化或非法值的指针引起的.

引起段错误的地方:
* 坏指针值错误
* 改写错误(overwrite)
* 指针释放引起的错误

* 节 section

#### Mach-O macintosh

#### 线程

> 每个线程有自己的堆栈, 大小为1MB(当需要时增长).


#### 过程活动记录

> `setjmp` 和 `longjmp`函数可以操作过程活动记录
> 这被称作`展开堆栈`(unwinding stack)

* goto不能跳出C语言当前的函数. 就像是往哪里去(go to)
* longjmp可以跳到更运, 甚至是其它的源文件, 但是只能是曾经到过的地方(调用过setjmp). 就像是从何处来(come from)

工具
* size: 查看文本段, 数据段, bss段大小
* nm, otool -L:显示符号表
* strings: 查看嵌入于二进制文件中的字符串
* sum: 打印文件的检验和与程序块计数
* dtruss: 打印可执行文件执行的系统调用
* file: 告诉你一个文件包含的内容
* time: 显示程序所使用的实际时间和CPU时间

### Intel 80x86

* 段在UNIX中, 是一块以二进制形式出现的相关内容
* 段在Intel 80x86, 是内存模型设计, 内存会被分成64k为单位的段

> 段寄存器内存地址形成经过是: 取得段寄存器的值, 左移4位 加上16位偏移地址. 也就是
> 有多种位模式不同的地址, 最后结果是指向同一个地址.



## Reference
[Undefined behavior](https://en.cppreference.com/w/cpp/language/ub)  
[Undefined Behavior in C and C++](https://www.geeksforgeeks.org/undefined-behavior-c-cpp/)  
[What are the most useful new features in C99](https://stackoverflow.com/questions/2047065/what-are-the-most-useful-new-features-in-c99)  
