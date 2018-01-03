---
layout: page
permalink: /program-language/objective-c/grammar
---

Grammar

### Program Structure
Objective-C程序通常由下面组成:
* Preprocessor Commands
* Interface
* Implementation
* Method
* Variables
* Statements & Expressions
* Comments

### Basic Syntax
Objective-C程序是由Tokens组合而成，一个Token是个keyword,identifier,constant,string,symbol.

#### 分号
Objective-C分隔语句就使用分号

#### 注释
/* */注释  不支持嵌套

#### 标识符
* 字母和下划线开头，后面可以接字母、下划线、数字
* Objective-C 区分大小写
* @,$,%不能用于标识符

#### 关键字
![](/assets/objective-c/keywords.png)

#### 空白
* 一行只包含空白，或者注释的，objc认为是空行，会忽略它。
* 空白是用来描述空格，制表符，换行符和注释的术语。
* 空白可以让Compiler识别出Token。

#### 左值与右值
* 左值 - 引用内存位置的表达式称为“左值”表达式。左值可以作为任务的左侧或右侧出现
* 右值 - 术语“右值”是指存储在内存中的某个地址处的数据值。右值是不能赋值的表达式，这意味着右值可能出现在赋值的右边，而不是左边

### 数据类型
数据类型表示数据在内存占用多少位，和怎么解释内存中的位模式。

* 基本类型：整型和浮点型
* 枚举类型
* Void类型
* 派生类型：pointer,array,stucture,union,function

*sizeof()*来得到类型占用的内存大小

*float.h*定义了一些宏，可以用来实现实数

*void*表示值不可用，可以用于声明函数返回值和参数，表示没有返回值和参数

### 变量和常量定义
type variable_list; // 变量定义，int    i, j, k;
type variable_name = value; // 变量初始化，没有初始化的都隐式使用NULL初始化(所有字节都为0)
extern type variable_list; // 声明一个外部变量

\#define identifier value // 预处理，常量定义
const type variable = value; // 关键字，常量定义，只是表示当前的引用不可修改，不表示这个内存不能修改

变量前加上"_"是Apple的编程规范，表示成员变量。一般使用@synthesize来定义别名。这个是Xcode自动定义的

@dynamic 告诉编译器，这个属性运行时定义。

### 操作符
* 算术操作符
* 关系操作符
* 逻辑操作符
* 位操作符
* 赋值操作符
* 杂项操作符：sizeof(),&,*,?:

*操作符优先级*
![操作符优先级](/assets/objective-c/operate-precedence.png)

### Controls
* if else
* switch
* while
* do while
* for
* nested loops

跳出:break，continue

### 函数
函数必须在使用前提供函数`declaration`，还需要提供函数`definition`

函数定义同C语言，而对象方法定义如下

#### Method Declaration

	- (return_type) function_name:( argumentType1 )argumentName1 
	joiningArgument2:( argumentType2 )argumentName2 ... 
	joiningArgumentn:( argumentTypen )argumentNamen;	

+ 开头的方法可以不用实例调用，相当于静态方法

#### Method Defining

	- (return_type) method_name:( argumentType1 )argumentName1 
	joiningArgument2:( argumentType2 )argumentName2 ... 
	joiningArgumentn:( argumentTypen )argumentNamen 
	{
	   body of the function
	}

#### Call Method

	/* calling a method to get max value */
	ret = [sampleClass max:a andNum2:b];

### Block
Objective-C中Block被实现成一个对象，可以实现闭包或Lambde表达式

#### Declaration

	returntype (^blockName)(argumentType);
	
	void (^simpleBlock)(void);

#### Defining

	returntype (^blockName)(argumentType)= ^{
	};
	
	void (^simpleBlock)(void) = ^{
	    NSLog(@"This is a block");
	};

#### Call

	simpleBlock();

#### 使用`typedef`定义Block

### 数值对象
把整型，浮点型转换成对象 NSNumber * ,BOOL,NSInteger, NSString *

### Array
不可变长度，存储同类型元素的集合

#### Declaration
type arrayName [ arraySize ];

#### Initializing
double balance[5] = {1000.0, 2.0, 3.4, 17.0, 50.0};

### Pointe

#### Declaration
type *var-name;

#### NULL
int  *ptr = NULL;

### String
Objective-C是使用`NSString`代表String，它是`NSMutableString`的子类，使用`@“...”`创建一个NSString对象

### Stuctures

#### Declaration

	struct [structure tag]
	{
	   member definition;
	   member definition;
	   ...
	   member definition;
	} [one or more structure variables];

### Preprocessors
![](/assets/objective-c/preprocessors.png)

### typedef
定义类型的别名

### Type Casting
(type_name) expression

支持整数提升
支持算术转换

### Log处理
使用NSLog打印log,支持C语言打印格式化。

可以用宏来禁止发布版本的应用LOG。

### 错误处理
NSError代表错误，包括下面内容：

* Domain: 错误域可以是预定义的NSError域之一，或者描述自定义域和域的任意字符串不能为nil。
* Code: 错误的错误代码
* User Info: 错误和userInfo的userInfo字典可能为nil

	NSString *domain = @"com.MyCompany.MyApplication.ErrorDomain";
	NSString *desc = NSLocalizedString(@"Unable to complete the process", @"");
	NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
	NSError *error = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];

### 命令行参数
int main( int argc, char *argv[] )
