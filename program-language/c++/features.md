---
layout: page
permalink: /program-language/c++/features
---

Features

### 查找函数
1. 函数原型如果是static，就在当前文件中寻找
2. 否则，所有文件中寻找，如果找到多个将发出错误消息
3. 在库中搜索

### 语言链接性 Language Linking
C++中支持函数的重载，所以不能使用C语言的LL，必须将重载的函数翻译为不同的符号名称。
因此，C++编译器执行名称矫正或名称修饰，spiff(int)转换为_spiff_i，而spiff(double, double)
转换为_spiff_d_d，为种方法叫作C++语言链接性。

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
