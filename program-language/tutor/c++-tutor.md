---
layout: page
permalink: /program-language/c++/grammar
---

Grammar

### Basic Syntax

#### 分号
每个语句结尾需要添加分号

#### 标误符
字母和下划线开头，可以接字母、下划线和数字

#### 三合

可以使用"??="  这样的3个字符序列  表示一个特别字符 "#"

??/ \
??' ^
??( [
??) ]
??! |
??< {
??> }
??- ~

#### 注释

// - 表示单行注释
/* */ - 表示多行注释

不允许嵌套

### 数据类型
Boolean					bool
Character				char
Integer					int
Floating point			float
Double floating point	double
Valueless				void
Wide character			wchar_t

类型修改
signed
unsigned
short
long

#### typedef
定义类型别名

	typedef type newname; 

#### 枚举类型

	enum enum-name { list of names } var-list; 

### 变量

	type variable_list;

	extern int d = 3, f = 5;    // declaration of d and f. 
	int d = 3, f = 5;           // definition and initializing d and f. 
	byte z = 22;                // definition and initializes z. 
	char x = 'x';               // the variable x has the value 'x'.

#### 声明全局变量

	// Variable declaration:
	extern int a, b;
	extern int c;
	extern float f;

定义本地变量需要自己初始化
定义全局变量系统自动初始化 0

#### 定义常量

* #define #define identifier value
* const const type variable = value;

#### 其他变量修改

* volatile - 改变量改变是原子的
* restrict - 一个限制指针的指针最初是指向它所指向的对象的唯一方法。只有C99添加了一个新的类型限定符restrict

#### 变量作用域控制
* auto - 本地变量默认修改，表示作用域在本地
* register - 表示这个变量很常用，要求编译器优先存储到寄存器中
* static - 作用局部变量表示在方法间共享，作用全局变量表示限制在文件中
* extern - 声明一个全局变量，这个全局变量是在其他文件中定义
* mutable - 只作用类对象，表示一个mutable成员变量，可以通过const成员方法修改

### 操作符
* Arithmetic Operators
* Relational Operators
* Logical Operators
* Bitwise Operators
* Assignment Operators
* Misc Operators
 
#### 优先级
同C
![](/assets/c++/operator-precedence.png)

### 控制流
循环
* while loop
* for loop
* do...while loop

循环控制
* break
* continue
* goto

分支
* if
* if...else
* switch
* ?:

### Functions

*declaration*

	return_type function_name( parameter list );

*defintion*

	return_type function_name( parameter list ) {
		body of the function
	}

#### Arguments
C++是值传递，可以指定默认值

### 数组

	type arrayName [ arraySize ];

	double balance[5] = {1000.0, 2.0, 3.4, 17.0, 50.0};

### String

*C-Style*

	char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
	char greeting[] = "Hello";

*C++-Style*

	#include <string>
	string str1 = "Hello";

### 指针

	type *var-name;

'*' - 取值符
'&' - 取地址符
'->'- 取结构成员

### 指针与引用

* 不能有一个空引用
* 一个引用只能表示一种类型，指针可以变换类型
* 引用必须在创建时初始化，指针可以在任何时候初始化

	// declare reference variables
   int&    r = i;
   double& s = d;

### Date and Time
使用`<ctime>`库

	struct tm {
	   int tm_sec;   // seconds of minutes from 0 to 61
	   int tm_min;   // minutes of hour from 0 to 59
	   int tm_hour;  // hours of day from 0 to 24
	   int tm_mday;  // day of month from 1 to 31
	   int tm_mon;   // month of year from 0 to 11
	   int tm_year;  // year since 1900
	   int tm_wday;  // days since sunday
	   int tm_yday;  // days since January 1st
	   int tm_isdst; // hours of daylight savings time
	}

### Structures

	struct [structure tag] {
	   member definition;
	   member definition;
	   ...
	   member definition;
	} [one or more structure variables];  

### Exception Handling

	try {
	   // protected code
	} catch( ExceptionName e1 ) {
	   // catch block
	} catch( ExceptionName e2 ) {
	   // catch block
	} catch( ExceptionName eN ) {
	   // catch block
	}

	throw "Division by zero condition!";

	
