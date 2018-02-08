---
layout: page
permalink: /program-language/c++/genericity
---

Genericity

### Templates

模板是泛型编程的基础，它涉及以独立于任何特定类型的方式编写代码

#### 模板函数的发展

##### 1. 是什么类型 C++98

    template<class T1, class T2>
    void ft(T1 x, T2 y)
    {
        ?type? xpy = x + y;   // 这里不知道xpy是什么类型，所以98中不允许这样写
    }

##### 2. 关键字decltype C++11
decltype提供上述解决方案

    decltype(x + y) xpy; // make xpy the same type as x + y
    xpy = x + y;
    // 等价于
    decltype(x + y) xpy = x + y;

decltype(expression) var;工作原理（为确定类型，编译器必须遍历一个核对表）:
第一步：如果expression是一个没有用括号括起的标识符，则var的类型与该标识符的类型相同，
    包括const等限定符
第二步：如果expression是一个函数调用，则var的类型与函数的返回类型相同
第三步：如果expression是一个左值，则var为指向其类型的引用，要进入第三步必须用括号括起的标识标

##### 3. 另一种函数声明语法 C++11 后置返回类型
当返回类型为decltype时，前面的函数声明就遇到问题，因为没有到decltype的作用域，编译不知道

后置返回类型(trailing return type)

    template<class T1, class T2>
    auto gt(T1 x, T2 y) -> decltype(x + y)
    {
        return x + y;
    }

#### Function Template

	template <class type> ret-type func-name(parameter list) {
	   // body of function
	}

#### Class Template

	template <class type> class class-name {
	   .
	   .
	   .
	}


