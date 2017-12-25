---
layout: page
permalink: /program-language/objective-c/object-oriented
---

Object Oriented

### Class

* 类使用`@interface`和`@implementation`定义
* 几乎所有的东西都是对象
* 对象接收消息，这样的对象叫接收者
* 对象包含实例变量
* 对象和实际变量有范围
* 类隐藏对象的实现
* 属性用于提供对其他类中的类实例变量的访问

#### Class Definitions

	@interface Box:NSObject
	{
	    //Instance variables
	    double length;   // Length of a box
	    double breadth;  // Breadth of a box
	}
	@property(nonatomic, readwrite) double height; // Property
	
	@end

* NSObject是所有类的超类，提供了一些基本的方法，如内存分配和初始化。
* 类中的实际变量是私有的，只有类的实际可以访问

#### Class Implementation

	@implementation Box
	
	@synthesize height; 
	
	-(id)init
	{
	   self = [super init];
	   length = 1.0;
	   breadth = 1.0;
	   return self;
	}
	
	-(double) volume
	{
	   return length*breadth*height;
	}
	
	@end

#### 分配和初始化对象

	Box box1 = [[Box alloc]init];     // Create box1 object of type Box
	
	- (id)initWithName:(NSString *)name andAge:(NSInteger)age{
	    personName = name;
	    personAge = age;
	    return self;
	}

返回id类型的方法就是构造函数，最好调用超类的构造函数`self = [super init];` 

#### 属性
属性是为了让类之外的地方访问类的实际变量

	@property(nonatomic, readwrite) double height; // Property

* @property开头
* 访问修饰，nonatomic or atomic, readwrite or readonly and strong, unsafe_unretained or weak
* 变量类型，上面是double
* 最后是变量名

`@synthesize`我们可以在实现类中添加合成语句。但在最新的XCode中，合成部分由XCode来处理，
而不需要包含合成语句

属性在背后创建setter和getter方法。

### Inheritance

	@interface derived-class: base-class

#### 访问控制
继承一个类，可以访问这个类的所有成员，但是不能访问@implementation中定义的成员

派生类继承了所有的基类方法和变量，但除了以下情况：

* 定义在@implementation文件中的成员不能访问
* 如果继承类在基类中实现方法，则执行派生类中的方法

### Categories
在现有的类里添加新的行为，可以使用`Categories`和`extensions`

#### 定义类别

	@interface ClassName (CategoryName)

	@end

* 即使没有原始的实现代码，也可以为所有有类定义类别
* 在类别中声明的任何方法都将可用于原始类的所有实例以及原始类的任何子类
* 在运行时，类别添加的方法与原始类别实现的方法没有区别
* 编译时必须引入类别定义的头文件，不然会编译出错

### Posing
Mac OS X 10.5后不可用。

使用一个类代替另一个类。

* 一个类只能直接或间接代替它的超类。
* 冒充类不能定义目标类中没有的新的实例变量（虽然它可能定义或覆盖方法）
* 目标类可能在被冒充之前不会收到任何消息
* 一个冒充的类可以通过超级方法调用被覆盖的方法，从而结合目标类的实现
* 冒充类可以覆盖在类别中定义的方法

### Extensions
* 跟`Categories`很像，声明时不用使用`CategoryName`，所以又叫匿名类别。
* 声明的方法必须在implementation中实现，所以不能扩展没有源码的类，如NSString
* 可以添加私有方法和私有属性
* 即使对于继承的类，任何在扩展中声明的方法或变量都是不可访问的

### Protocols
Objective-C允许你定义协议，这些协议声明预期用于特定情况的方法。协议在符合协议的类中实现。

	@protocol ProtocolName
	@required
	// list of required methods
	@optional
	// list of optional methods
	@end

	@interface MyClass : NSObject <MyProtocol>
	...
	@end

### Dynamic Binding
动态绑定决定了在运行时而不是在编译时调用的方法。动态绑定也被称为后期绑定

在Objective-C中，所有的方法都是在运行时动态解析的。执行的确切代码由方法名称（选择器）和接收对象决定

动态绑定启用多态性。例如，考虑包括Rectangle和Square的对象集合。每个对象都有自己的printArea方法的实现

### Fast Enumeration

	for (classType variable in collectionObject )
	{ 
		statements 
	}

	for (classType variable in [collectionObject reverseObjectEnumerator] )
	{
		statements
	}


