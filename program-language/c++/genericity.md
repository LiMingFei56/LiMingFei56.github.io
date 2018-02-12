---
layout: page
permalink: /program-language/c++/genericity
---

Genericity

### Templates

模板类型简化：
 auto
 decltype
 using = 
 typedef

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

### 泛型
使用模板和通用算法来实现。模板使得算法独立于存储的数据类型，而迭代器使算法独立于使用的
容器类型。

#### 迭代器
* 应能够对迭代器执行解除引用的操作，以便能够访问它引用的值。即如果p是一个迭代器，则应对*p进行定义
* 应能够将一个赋给另一个。即如果p和q都是迭代器，则应对表达式p=q进行定义
* 应能够将一个迭代器和另一个进行比较，看它们是否相等。即如果p和q都是迭代器，则应对p==q和p!=q进行定义
* 应能够使用迭代器遍历容器中的所有元素，这可以通过为迭代器p定义++p和p++来实现

### 包装器function
当模板参数接收一个可调用类型（callable type），就会导致模板的效率极低。调用类型分为函
数名、函数指针、函数对象或有名称的lambda表达式，模板会根据这些不同类型生成不同的模板对象

可以使用包装器function来解决上述问题，因为上述的可调用类型的调用特征标(call signature)相同。它
从调用特征标的角度定义了一个对象，可用于包装调用特征标相同的call type。

    std::function<double(char, int)> fdci; 2个参数char, int，返回double

    function<double(double)> ef1 = Fq(10.0);
    use_f(y, ef1);

### 可变参数模板(variadic template)
一般定义模板参数，会分为模板参数包(parameter pack)，里面包含模板类型; 函数参数包，里面包含形参值
。C++11提供了一个用省略号表示的元运算符(meta-operator)

    template<typename... Args>
    void show_list1(Args... args)
    {
    }

Args是一个模板参数包
args是一个函数参数包

    showlist1('$', 80, "sweet", 4.5);

args... 为函数参数包展开
