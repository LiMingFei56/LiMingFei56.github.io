---
layout: page
permalink: /program-language/python/memory-model
---

Memory Model

### 命名空间和作用域
变量是映射到对象的名称（标识符）。名称空间是变量名称（键）及其相应对象（值）的字典。
Python语句可以访问本地名称空间和全局名称空间中的变量。如果本地变量和全局变量具有相同的名称，则局部变量会隐藏全局变量。
每个函数都有自己的本地名称空间。类方法遵循与普通函数相同的范围规则。
Python对变量是本地还是全局进行了有根据的猜测。它假设在函数中赋值的任何变量都是本地的。
因此，为了给一个函数中的全局变量赋值，你必须首先使用全局语句。
`global VarName`语句告诉Python，VarName是一个全局变量。 Python停止搜索变量的本地名称空间。

#### dir()方法
返回模块中定义的名字

#### globals() 和 locals()
返回可以访问的对应作用域的变量名，返回的是个Dictionary。可以使用keys（）来遍历

#### reload()
再次导入模块`reload(module_name)`




