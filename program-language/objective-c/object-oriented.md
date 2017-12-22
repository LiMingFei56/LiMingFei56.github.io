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


