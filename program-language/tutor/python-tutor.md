---
layout: page
permalink: /program-language/python/grammar
---

Grammar

### Basic Syntax

#### Identifiers
标识符用来定义变量，方法，类，模块和其他对象。由字母和下划线开头，后面可以跟字母和下划线还有数字。

区分大小写。

Python命名约束：

* 类名以大写字母开头，其他的由小写字母开头
* 以单下划线开头的标识符指明这个标识符是私有的
* 用两个前导下划线开始标识符表示一个强烈的私有标识符
* 如果标识符还以两个尾随下划线结尾，则标识符是语言定义的特殊名称

#### keywork
and	exec	not
assert	finally	or
break	for	pass
class	from	print
continue	global	raise
def	if	return
del	import	try
elif	in	while
else	is	with
except	lambda	yield


#### 语法
Python以回车表示语句结束，如果一行包含多个语句就使用";"号。

Python使用缩进来表示语句块，同一语句块必须保证同层度的缩进。

Python使用"\"来表示多行表达式，执行进看成一行执行。

Python使用('),（"）,(""),(""")来表示字符串，(""")字符串表示长字符串，可以跨多行。

Python使用"#"表示注释

Python中一个代码块称为`suites`

### 变量类型

	counter = 100          # An integer assignment
	miles   = 1000.0       # A floating point
	name    = "John"       # A string

	a = b = c = 1
	a,b,c = 1,2,"john"

#### 准备数据类型

*	Numbers
*	String
*	List
*	Tuple
*	Dictionary

#### 数字

	# 创建变量
	var1 = 1
	var2 = 10
	
	# 删除变量
	del var1[,var2[,var3[....,varN]]]]
	
	del var
	del var_a, var_b

* 使用l和L表示长整型，建议使用L以区别1
* 复数由实数和虚数表示

支持的数字类型：

* int (signed integers)
* long (long integers, they can also be represented in octal and hexadecimal)
* float (floating point real values)
* complex (complex numbers)

#### String

	str = 'Hello World!'
	
	print str          # Prints complete string
	print str[0]       # Prints first character of the string
	print str[2:5]     # Prints characters starting from 3rd to 5th
	print str[2:]      # Prints string starting from 3rd character
	print str * 2      # Prints string two times
	print str + "TEST" # Prints concatenated string

#### Lists

	list = [ 'abcd', 786 , 2.23, 'john', 70.2 ]
	tinylist = [123, 'john']
	
	print list          # Prints complete list
	print list[0]       # Prints first element of the list
	print list[1:3]     # Prints elements starting from 2nd till 3rd
	print list[2:]      # Prints elements starting from 3rd element
	print tinylist * 2  # Prints list two times
	print list + tinylist # Prints concatenated list

* 使用"[]"表示
* 可以保存任何元素类型
* 可以修改元素

#### Tuples

	tuple = ( 'abcd', 786 , 2.23, 'john', 70.2  )
	tinytuple = (123, 'john')
	
	print tuple           # Prints complete list
	print tuple[0]        # Prints first element of the list
	print tuple[1:3]      # Prints elements starting from 2nd till 3rd 
	print tuple[2:]       # Prints elements starting from 3rd element
	print tinytuple * 2   # Prints list two times
	print tuple + tinytuple # Prints concatenated lists

* 使用"()"表示
* 可以保存任命元素类型
* 不可修改元素

#### Dictionary

	dict = {}
	dict['one'] = "This is one"
	dict[2]     = "This is two"
	
	tinydict = {'name': 'john','code':6734, 'dept': 'sales'}
	
	
	print dict['one']       # Prints value for 'one' key
	print dict[2]           # Prints value for 2 key
	print tinydict          # Prints complete dictionary
	print tinydict.keys()   # Prints all the keys
	print tinydict.values() # Prints all the values

* 使用"{}"表示
* 键值对表示(Hash Table Type)，可以保存任何类型
* 可以修改

#### 类型转换
有时个需要在内建的数据类型间转换，使用`<type>(<expression>)`

	int(x [,base])
	long(x [,base] )
	float(x)
	complex(real [,imag])
	str(x)
	repr(x)
	eval(str)
	tuple(s)
	list(s)
	set(s)
	dict(d)
	frozenset(s)
	chr(x)
	unichr(x)
	ord(x)
	hex(x)
	oct(x)

### 基本操作符
* Arithmetic Operators(**和//为幂操作符)
* Comparison (Relational) Operators
* Assignment Operators
* Logical Operators
* Bitwise Operators
* Membership Operators(in,not in)
* Identity Operators(is, is not)

操作符优化级
![](/assets/python/python-operator-description.png)

### 控制流

#### if

	# if
	if expression:
		statement(s)
	
	# 单行if
	if ( var == 100 ) : print "Value of expression is 100"

	# if...else
	if expression:
	   statement(s)
	else:
	   statement(s)

	# 嵌套if
	if expression1:
	   statement(s)
	   if expression2:
	      statement(s)
	   elif expression3:
	      statement(s)
	   else:
	      statement(s)
	   elif expression4:
	      statement(s)
	else:
	   statement(s)

#### 循环

##### while

	while expression:
		statement(s)

##### for

	for iterating_var in sequence:
		statements(s)

##### 嵌套循环

	for iterating_var in sequence:
		while expression:
			statement(s)
		statements(s)
	
##### 循环控制
* break
* continue
* pass 空操作，什么都不干

### 数字
数字操作模块

### String
string - 一般的表示需要转义
`r/R` - 原始字符串，会忽略转义
% - 字符串格式化
`u/R` - 表示unicode编码

	print "My name is %s and weight is %d kg!" % ('Zara', 21)

### Lists
	
	list1 = ['physics', 'chemistry', 1997, 2000];
	print "list1[0]: ", list1[0]
	list[2] = 2001;
	del list1[2]

	# list 操作
	len(list) - 返回list长度
	'+' - 连接2个list
	'*' - 连接重复次数
	in  - 判断元素是不是在list中
	for - 叠代list

	# Indexing, Slicing, and Matrixes
	L[2]
	L[-2]
	L[1:]

### Tuples

	tup1 = ('physics', 'chemistry', 1997, 2000)
	tuples不能修改元素
	del tup1 # 删除tuples

	# tuples 操作
	len(tuples) - 返回tuples长度
	'+' - 连接2个tuples
	‘*’ - 重复连接
	in  - 同list
	for - 同list

	# Indexing, Slicing, and Matrixes
	同list

任何以逗号分隔的，没有标识符号（即列表括号，元组括号等）的多个对象的集合默认为元组

### Dictionary

	dict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
	dict['Age'] = 8; # update existing entry
	del dict['Name']
	del dict

* key可以为任何类型
* key不允许重复
* key是不可变的

### Date & Time
使用time模块表示时间
使用callender模块表示日历

###	Function
* 以def开头
* 在()中定义参数列表
* 函数的第一个语句可以是可选的文档字符串
* 每个函数中的代码块都以冒号（:)开始并缩进
* 语句return [expression]退出函数，可选地将表达式传回给调用者。不带参数的返回语句与返回无相同

	def functionname( parameters ):
	   "function_docstring"
	   function_suite
	   return [expression]

在Python中参数都是引用传递

#### 参数

	def printme( str ) // 必须参数
	printme( str = "My string") // 关键字调用
	def printinfo( name, age = 35 ) // 默认参数 printinfo( name="miki" )

	# 可变长度参数
	def functionname([formal_args,] *var_args_tuple ):
	   "function_docstring"
	   function_suite
	   return [expression]


	def printinfo( arg1, *vartuple )

#### 匿名函数
使用lambda定义的函数

* ambda表单可以接受任意数量的参数，但只能以表达式的形式返回一个值。他们不能包含命令或多个表达式
* 一个匿名函数不能直接调用打印，因为lambda需要一个表达式
* Lambda函数具有自己的本地名称空间，不能访问变量而不是其参数列表中的变量和全局名称空间中的变量
* 虽然看起来lambda是函数的单行版本，但它们不等同于C或C ++中的内联语句，其目的是在调用期间通过传递函数堆栈分配来达到性能上的原因

	lambda [arg1 [,arg2,.....argn]]:expression

### Modules
一个模块允许你在逻辑上组织你的Python代码。将相关的代码分组到一个模块使得代码更易于理解和使用。
模块是具有任意命名属性的Python对象，您可以将其绑定和引用

	import module1[, module2[,... moduleN] // 导入语句

	from modname import name1[, name2[, ... nameN]] // 只导入指定的属性

	from modname import * // 导入所有

模块搜索路径：

* 当前目录
* PYTHONPATH
* default path（unix的default path为/usr/local/lib/python/）

#### Packages
一个包是一个分层文件目录结构，它定义了一个由模块，子包和子子包组成的单一Python应用程序环境，等等
如里一个目录下的Python文件可以看成一个Modules，那么可以定义一个`__init__.py`文件。

这个文件包含目录下所有的文件：

	from Pots import Pots
	from Isdn import Isdn
	from G3 import G3

那么只用导入这个包就行了。

### 异常处理
Python提供两种重要的特性处理异常和添加debug功能:

* Exception handling - 
* Assertions - 

#### Assertions

	assert Expression[, Arguments]
	assert (Temperature >= 0),"Colder than absolute zero!"

#### Excaptions

	try:
	   You do your operations here;
	   ......................
	except ExceptionI:
	   If there is ExceptionI, then execute this block.
	except ExceptionII:
	   If there is ExceptionII, then execute this block.
	   ......................
	else:
	   If there is no exception then execute this block.

	except: # 通用捕获

	except(Exception1[, Exception2[,...ExceptionN]]]): # 多异常捕获

	except ExceptionType, Argument: #	异常可以包含参数

	try:
	   You do your operations here;
	   ......................
	   Due to any exception, this may be skipped.
	finally:
	   This would always be executed.
	   ......................

* 一个try语句可以有多个except语句。当try块包含可能会抛出不同类型异常的语句时，这很有用
* 您还可以提供一个通用的except子句，它处理任何异常
* 在except子句之后，可以包含一个else子句。如果try：块中的代码不引发异常，则else-block中的代码将执行
* else块是一个不需要try：block保护的代码的好地方

#### Raising 异常

	raise [Exception [, args [, traceback]]]
	raise "Invalid level!", level

#### 自定义异常

	class Networkerror(RuntimeError):
		def __init__(self, arg):
			self.args = arg
