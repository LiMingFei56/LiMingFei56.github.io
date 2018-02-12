---
layout: page
permalink: /program-language/c++/object-oriented
---

Object Oriented

### this关键字
在类中非静态函数后面加const，如`double add() const;`表示该函数不会修改this对象

### Class 

*definitions*

	class Box {
	   public:
	      double length;   // Length of a box
	      double breadth;  // Breadth of a box
	      double height;   // Height of a box
	};

#### Define C++ Objects

	Box Box1;          // Declare Box1 of type Box

#### Method

*declaretion*
	return_type method_name(argument_list);

*definition*

	可以使用作用域解柝运算符"::"来引用方法;

	class Box {
	   public:
	      double length;         // Length of a box
	      double breadth;        // Breadth of a box
	      double height;         // Height of a box
	
	      // Member functions declaration
	      double getVolume(void);
	      void setLength( double len );
	      void setBreadth( double bre );
	      void setHeight( double hei );
	};
	
	// Member functions definitions
	double Box::getVolume(void) {
	   return length * breadth * height;
	}

#### 访问控制

* public   - 类可见的所有地方都可以访问
* private  - 默认的访问权限，类外部都不能访问
* protected- 子类可以访问

#### 构造函数和析构函数

*declaretion*

	class_name(argument_list);

*definition*

	Line::Line( double len) {
		cout << "Object is being created, length = " << len << endl;
		length = len;
	}

成员初始化列表
如果C是一个类，有一个接收3个double参数的构造函数，X、Y、Z是类成员，那么可以使用下面
成员初始化列表来初始化

	C::C( double a, double b, double c): X(a + b), Y(b + c), Z(ab + b + c) {
		....
	}

* 这种格式只能用于构造函数；
* 必须用这种格式来初始化非静态const数据成员(至少在C++11之前是这样的)
* 必须用这种格式来初始化引用数据成员

数据成员被初始化的顺序与它们出现在类声明中的顺序相同，与初始化器中的排列顺序无关


析构函数，就是在构造函数前加"~"，当对象被摧毁时调用:

	~Line();

*默认构造函数*
如果定义了一个构造函数，编译器不会自动创建默认的构造函数、复制构造函数和复制赋值
构造函数。这种情况下，可以使用关键字`default`显式地声明这些方法的默认版本。

    Someclass() = default;

*委托构造函数*
可以调用其他的函数

*继承构造函数*
使用名称空间中函数可用的语法，可以使派生类继承基类的构造函数（除了默认构造函数、
复制构造函数和移动构造函数除外），但不会使用与派生类构造函数的特征标匹配的构造
函数

    class Base
    {
        int q;
        double w;

        public:
            Base(int k) : q(k), w(100){}
    }

    class DR : public Base
    {
        public:
            using Base::Base; // 继承基类的构造函数
    }

#### Copy Constructor 默认的复制构造函数的功能
根据一个对象创建另一个对象

	classname (const classname &obj) {
	   // body of constructor
	}

何时调用：
> 初化时调用

    StringBad ditto(motto);
    StringBad metoo = motto;
    String also = StringBad(motto);
    StringBad *pStringBad = new StringBad(motto);

> 按值参数传递时

`explicit`和`implicit`修饰只有一个参数的构造函数，默认为`implicit`。编译会缺省的
转换操作：将该构造函数对应数据类型的数据转换为该类对象。

#### Friend Method
可以在外面访问私有变量,相当于Java中的静态变量

	friend void printWidth( Box box );

声明所有函数都是Friend

	friend class ClassTwo;

友元函数可以通过强制类型转换，将派生类引用或指针转换为基类引用或指针，然后使用该
指针或引用调用基类的友元函数。

#### 内联函数
使用`inline`修饰的函数

	inline int Max(int x, int y) {
		return (x > y)? x : y;
	}

#### This 指针
c++中所有对象都有指向自己的指针，名称为`this`

#### 静态成员
可以使用`static`关键字修饰成员，变量和方法

静态变量在类中只有一个副本，可以通过类直接引用。
静态方法可以通过类直接引用。

### 继承

	class derived-class: access-specifier base-class

访问权限默认为私有的。

Accessi         | public | protected | private
----------------+--------+-----------+------------
Same class      | yes    | yes       | yes
Derived classes	| yes    | yes       | no
Outside classes | yes    | no        | no

派生类会继承基类下面所有的方法：

* Copy构造函数
* 重载操作符，除赋值操作符

构造函数不会继承，只能调用派生类构造函数，派生类的构造函数会自动调用基类的构造函灵敏
，可以使用member initialization list来指定调用基数的构造函数。

析构函数和赋值操作符也不继承

继承时需要考虑是否要重写，析构函数，复制构造函数，赋值操作符

使用访问限定符时有下面规则：
* 使用public继承：基类的访问控制不变
* 使用protect继承：基类的public和protect成员，继承来为protect
* 使用private继承：基类的public和protect成员，继承来为private

有关派生类构造函数的要点如下：
* 首先创建基类对象
* 派生类构造函数应通过成员初始化列表将基类信息传递给基类构造函数
* 派生类构造函数应初始化派生类新增的数据成员

#### 多重继承

	class derived-class: access baseA, access baseB....

multiple inheritance会导致会有多个同一个基类的对象，如果需要把基类修饰为`virtual`。
当类通过多条途径和非虚途径继承某个特定的基类时，该类将包含一个表示所有的虚途径的基类
子对象和分别表示各条非虚途径的多个基类子对象。

使用虚基类将改变C++解析二义性的方式。
非虚基类：如果类从不同类那里继承了多个同名成员（数据或方法），则使用该成员名时，如果
没有用类名进行限定，将导致二义性（可以使用继承可见性限制）。

虚基类：这样做不一定会导致二义性（名称冲突在同一个继承树中），需要判断成员名称的
优先级(dominates)。派生类中的名称，优先于直接或间接祖先类中的相同名称；如果名称冲突在
不同继承树中，需要使用作用域解析符来调用。

*虚基类构造函数问题*
>   非虚基类的构造函数是一步步调用的，C调用B，B调用A。如果多基类时，
这种自动传递信息会通过多条不同的途径传递信息。所以基类是`virtual`时，禁止信息通过
中间类自动传递给基类。

>   解决上述问题，需要显式的调用虚基类的构造函数，初始化列表默认调用虚基类的默认
构造函数，如果调用其他的构造函数，需要显式调用。

*调用哪个方法*
>   多重继承可能从不同的基数继承多个函数签名相同，实现不同的方法，导致函数调用二义性。

>   1. 使用作用域解析运算符来告诉编译器使用哪一个方法
>   2. 在派生类中重新定义方法，并指出要使用哪个方法


#### 操作符重载

	Box operator+(const Box&);

### 多态
在C++中函数默认采用静态连接，所以不能实现多态。

需要在实现多态的方法前加上`virtual`，让该方法采用动态连接。

#### 纯虚拟方法,相当于抽像方法
abc(abstract base class) - 当类包含纯虚拟方法时，则不能创建该类的对象，只能做为基类

	// pure virtual function
      virtual int area() = 0;

在派生类中使用`override`关键字描述的虚方法，会让编译器检查该虚方法是否正确实现:

    void PrintTuring() override;

#### 虚析构函数
如果不指定析构函数为`virtual`，那么只会调用基类的析构函数。
如果指定了`virtual`，会先调用子类的析构函数，然后自动调用基类的析构函数

