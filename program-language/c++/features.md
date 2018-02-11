---
layout: page
permalink: /program-language/c++/features
---

Features


### 操作符重载

    operatorop(argument-list)

    op为操作符，但是不能是创建新的操作符

操作符重载限制：
1. 重载后的运算符必须至少有一个操作数是用户定义的类型，这将防止用户为标准类型重载
    运算符。
2. 使用运算符时不能违反运算符原来的句法规则。
3. 不能创建新运算符
4. 有些运算符不能重载
5. 有些运算符只能通过成员函数进行重载

### 友元
通过让函数成为类的友元，可以赋予该函数与类的成员函数相同的访问权限。

### 转换函数
为了把当前类型转换成其他类型，需要转换函数

    // 声明转换函数
    operator typeName();

typeName为转换目标类型

    operator int(); // 把当前类型转换成int类型

要求：
* 转换函数必须是类方法
* 转换函数不能指定返回类型
* 转换函数不能有参数

### RTTI
运行阶段类型识别(Runntime Type Identification)。

* 如果可能的话，dynamic_cast运算符将使用一个指向基类的指针来生成一个指向派生类的指针
    否则，该运算符返回0 -- 空指针
* typeid运算符返回一个指出对象的类型的值
* type_info结构存储了有关特定类型的信息

只能将RTTI用于包含虚函数的类层次结构，原因在于只有对于这种类层次结构，才应该将派生对象的
地址赋给基类指针。

### 类型转换运算符
C++的通用类型转换太过松散，最好使用下面的方法，指出了进行类型转换的原因，并让编译
器能够检查程序的行为是否与设计者想法吻合。

* dynamic_cast - dynamic_cast <type-name>(expression)，安全的运行时类型转换
* const_cast - const_cast<type-name>(expression)，改变值为const或volatile，或去掉这2个修改
* static_cast - static_cast<type-name>(expression)，仅当type-name可被隐式转换为expression所属的类型
    或反过来时，转换才是合法的，否则出错。
* reinaterpret_cast - reinterpret_cast<type-name>(expression)，内存地址转换成对象等


