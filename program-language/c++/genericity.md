---
layout: page
permalink: /program-language/c++/genericity
---

Genericity

### Templates

模板是泛型编程的基础，它涉及以独立于任何特定类型的方式编写代码

    template<class Type>
    等价于
    template<typename Type>

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

	template <class type>
    ret-type func-name(type t1, type t2) {
	   // body of function
	}

    bool Stack<type>::isempty()
    {
    }

### Class Template
    
	template <class type> // 首先定义一个模板
    class class-name {
        private:
            type items[MAX];
	}

    Statck<type>::Stack()
    {
    }

    // 使用模板
    Stack<int> kernels;

### 模板多功能性

> 递归使用模板

    ArrayTF<ArrayTF<int, 5>, 10> twodee;

> 使用多个类型参数

    template<class T1, class T2>

> 默认类型模板参数

    template<class T1, class T2 = int>

### 模板的具体化
类模板与函数模板很相似，因为可以有隐式实例化、显式实例化和显式具体化，统称为具体化(specialization)
。模板以泛型的方式描述类，而具体化是使用具体的类型生成类声明。

1. 隐式实例化 - 声明一个或多个对象，指出所需的类型，而编译器使用通用模板提供的处方生成具体的类定义。
    编译器在需要对象之前，不会生成类的隐式实例化（如指针，定义时不需要，初始化时才需要）。
    `ArrayTP<double, 30> *pt; // a pointer, no object needed yet`

2. 显式实例化 - 使用关键字template指出所需类型来声明类时，编译器将生成类声明的显式实例化。
    `template class ArrayTP<String, 100>;`

3. 显式具体化 - 是特写类型的定义（用于替换摸板中的泛型）。
    `template <> class Classname<specialized-type-name>`


