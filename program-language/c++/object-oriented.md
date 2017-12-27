---
layout: page
permalink: /program-language/c++/object-oriented
---

Object Oriented

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

初始化列表

	C::C( double a, double b, double c): X(a), Y(b), Z(c) {
		....
	}

析构函数，就是在构造函数前加"~"，当对象被摧毁时调用:

	~Line();

#### Copy Constructor
根据一个对象创建另一个对象

	classname (const classname &obj) {
	   // body of constructor
	}

#### Friend Method
可以在外面访问私有变量,相当于Java中的静态变量

	friend void printWidth( Box box );

声明所有函数都是Friend

	friend class ClassTwo;


