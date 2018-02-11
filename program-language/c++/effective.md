---
layout: page
permalink: /program-language/c++/effective
---

Effective

## 友元

### 友元函数
权限跟内部方法一样，可以访问类的私有成员。需要在类中使用关键字`friend`声明函数。

    // 声明
    friend Time operator*(double m, const Time & t);

    // 实现，因为友元函数不是成员函数，所以不用类限定符
    Time operator*(double m, const Time & t)
    {
    }

### 友元类
友元类的所有方法都可以访问原始类的私有成员和保护成员。另外，也可以做更严格的限制，只
将特写的成员函数指定为另一个类的友元。哪些函数或类为友元是由类定义的，而不能从外部强
加友情。

    // 在类中声明哪些类是友元
    friend class Remote; // remote中可以访问目标类的私有成员

    // 友元成员函数
    frient void Remote::set_chan(Tv & t, int c); 

前向声明 - 上面的友元成员函数声明，Tv中定义，所以Remote需要在Tv声明前面声明，而Remote中
要实现友元成员函数，所以需要Tv在Remote前面。打破这个循环需要使用前向声明(forward declaration)

    class Tv;
    class Remote {...};
    class Tv {...};

声明的排列次序不能颠倒，因为编译器看到Tv中的set_chan友元函数前，需要先看到Remote中
的set_chan定义。

### 其他友元关系

* 互为友元，两种类分别包含对方的友元类。
* 共同友元, 两种类分别声明相同的友元成员函数，使用inlinu关键字修改的友元成员函数定义。


## 异常
abort()函数，向标准错误流发送abnornal program termination信息，然后终止程序(原型声明在cstdlib或stdlib.h)

exit()函数，只返回错误代码，不显示消息。

C++11异常规范
    
    double harm(double a) throw(bad_thing);  // 不推荐使用
    double marm() noexcept; // 不抛出异常，可以使用

导演机制，对程序运行过程中发生的异常情况的一种响应。提供了将控制权从程序一个部分传递到
另一部分的途径。对异常的处理有3个组成部分：
* 引发异常，使用throw，如里没有try块处理，就会调用abort()函数
* 使用处理程序捕获异常
* 使用try块

    throw "string message"; // 抛出异常,后面可以是字符串或其他C++类型

    try 
    {
        statement;
    } 
    catch (const char * s)
    {
        statement;
    }

### 栈解退
栈解退(unwinding the stack) - try块没有直接调用引发异常的函数，而是调用了对引发异常的函数
进行调用的函数，则程序流程将从引发异常的函数跳到包含try块和处理程序的函数。

函数调用过程是使用栈来完成的，而出现异常时，程序也将释放栈中的内存，但不会释放栈的第一个返回
地址后停止，而是继续释放栈，直到找到一个位于try块中的返回地址。随后，控制权将转到块尾的异常处理
程序，而不是函数调用后面的第一条语句。

catch中的对象是原来对象的临时拷贝，而不是原来对象。如果有一个异常类继承层次结构， 应这样排列
catch块：将捕获位于层次结构最下面的异常类的catch语句放在最前面。

exception关文件(以前为exception.h或except.h)定义了exception类。

### 异常调用过程

意外异常 - 异常是在带异常规范的函数中引发并匹配定义的异常类型(throw(somethind))，不匹配就叫意外异常，默认
    会导至异常终止。throw()表示函数不会产生异常

未捕获异常 - 如果异常不是在函数中引发的(或者函数没有异常规范)，则必须捕获，没有捕获就是未捕获异常。

未捕获异常不会导至程序立刻异常终止，而是先调用terminate()函数，terminate()会调用abort()函数。可以使用
set_terminate()函数来修改这个行为。

意外异常发生时，程序将调用unexpected()函数，然后调用terminate()。还可以使用set_unexpected()函数。

### 异常的注意事项
动态分配内存，抛出异常后如何释放：
1. 在catch中释放
2. 使用智能指针模板之一
