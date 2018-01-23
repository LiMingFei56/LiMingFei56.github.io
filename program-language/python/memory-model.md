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

#### Namespaces
Namespaces是从名称到对象的映射，Python中的Namespaces是使用Dictionaries实现的。

Namespaces类型：
    内置Namespaces - 通常也是归于Module，叫作builtins
    Module全局Namespaces - Global 
    函数中的局部Namespace - Local
    类的Namespaces 

Namespaces中的Attributes使用"."来引用，分为只读和可写(可写 - 可修改和删除)

Namespaces在不同的时候创建，有不同的生命周期:
    * 内置Namespaces - 直到程序退出才删除
    * Module全局Namespaces - 当Module读取时创建，通常也是到程序退出时删除
    * 由解释器顶级调用执行的语句，被任为是__main__Module的一部分
    * 函数中的局部Namespaces - 当调用函数时创建，当返回或异常时删除(递归调用会创建不同的Namespaces)
    * 类的Namespaces - 定义一个类时创建 

对一个名称赋值，不会复制数据，而是把名称和数据建立绑定关系。删除也就是删除绑定关系。

#### Scope
Scope是一个文本域，如果给定一个非限止的名称，那么会根据规则在Namespaces中寻找。Scope是
静态决定，动态使用的。

动态使用规则：
    1. 在函数中局部Namespaces中 - Local Name
    2. 在闭包中 - 非Local Name 非Global Name
    3. Module全局Namespaces - Global Name
    4. 内置Namespaces

`nonlocal` - 可以修改闭包中属性的值，不然闭包中的属性是只读的
`global` - 可以修改全局属性的值

#### dir()方法
返回模块中定义的名字

#### globals() 和 locals()
返回可以访问的对应作用域的变量名，返回的是个Dictionary。可以使用keys（）来遍历

#### reload()
再次导入模块`reload(module_name)`




