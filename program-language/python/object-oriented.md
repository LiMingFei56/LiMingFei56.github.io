---
layout: page
permalink: /program-language/python/object-oriented
---

Object Oriented

### Class

#### 创建Class

	class ClassName:
		'Optional class documentation string'
		class_suite

* 文档字符串可以通过__doc__来访问
* class_suite包含所有成员变量的定义

#### 实例化类

	emp1 = Employee("Zara", 2000)

#### 访问成员变量

	emp1.displayEmployee()
	Employee.empCount

使用内建的方法：

	getattr(obj, name[, default])
	hasattr(obj,name)
	setattr(obj,name,value)
	delattr(obj, name)

#### 内建的类属性

* __dict__	 - 包含类的名字空间的字典
* __doc__	 - doc 字符串
* __name__	 - 类名称
* __module__ - module 名称
* __bases__  - 包含基类的可能为空的元组，按其在基类列表中出现的顺序排列

__del__()析构函数，对象被销毁时调用。

#### 继承

	class SubClassName (ParentClass1[, ParentClass2, ...]):
		'Optional class documentation string'
		class_suite

issubclass(sub, sup) - 检查sub是不是sup的子类
isinstance(obj, Class) - 检查obj是不是Class的实例

#### Override 和 Overload方法
可以重写和重载父类的方法

基本重载方法

__init__ ( self [,args...] ) - 构造函数
__del__( self )				 - 删除对象
__repr__( self )			 - 转换成string
__str__( self )				 - 打印语句
__cmp__ ( self, x )			 - 比较

#### 数据隐藏
Python中没有访问控制，但有约定
"_"和"__"开头的属性被任为是私有的
