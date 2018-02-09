---
layout: page
permalink: /program-language/c++/memory-model
---

Memory Model

单元 - 翻译单元，也就是文件

## 内存模型和名称空间

### 内存模型

栈（Stack) - 所有局部变量会保存到栈时，过了作用域会自动删除
堆（Heap）- 在运行时动态分配的内存，需要自己管理
静态空间（Static）- 由于静态变量的数目在程序运行期间是不变的，因此编译器只用分配
    固定的内存块来存储所有静态变量

### 存储持续性、作用域和链接性
* 存储持续性 - 描述数据保留在内存中的时间
* 作用域(scope) - 描述名称在文件的多大范围可见
* 链接性(linkage) - 描述名称如何在不同单元单共享

存储持续性：
* 自动存储 - 函数定义中声明的变量（包括函数参数），过了作用域会自动消除， 使用栈实现
* 静态存储 - 使用static关键字在文件中定义的变量，在程序整个运行过程中都存在，在静态空间实现
* 动态存储 - 用new分配的内存一直存在，直到delete，使用堆实现
* 线程存储 - c++11出来的，使用关键字thread_local定义的变量，生命周期与线程一样长

作用域：
* 局部作用域 - 只在代码块中可用
* 全局作用域（也叫文件作用域） - 在定义位置到文件结束都可用
* 函数原型作用域(function prototype scope) - 名称只在包含参数列表的括号内可用
* 类作用域 - 在类中声明的成员的作用域为整个类
* 名称空间作用域 - 在名称空间声明的名称在整个名称空间使用

链接性：
* 无链接性 - 只能在当前函数或代码块中访问
* 内部链接性 - 只能在当前文件中访问
* 外部链接性 - 可在其他文件中访问

存储方法，通过存储持续性、作用域、链接性来描述：
* 自动存储持续性： 自动、局部、无链接性
* 静态持续性： 静态、全局、（根据定义的方式和位置）

### 名称空间
声明区域(declaration region) - 可以在其中进行声明的区域
潜在作用域(potential scope) - 变量的潜在作用域从声明点开始，到其声明区域结尾。

声明名称空间有4种方法，使作用域不一样
* using namespace std;放在函数定义之前，文件中所有地方都可以使用
* using namespace std;放在函数定义中，只能在函数中使用
* using std::cout;放在函数中，只能在函数中使用cout
* 完全不使用编译指令using，使用std::来引用

#### 定义Namespace

	namespace namespace_name {
		// code declarations
	}

使用`::`来使用Namespace，

	name::code;

#### using

	using namespace std;
	using std::cout;

#### 不连续命名空间

	namespace namespace_name1 {
	   // code declarations
	   namespace namespace_name2 {
	      // code declarations
	   }
	}

	// to access members of namespace_name2
	using namespace namespace_name1::namespace_name2;
	
	// to access members of namespace:name1
	using namespace namespace_name1;

### new delete
c++中使用new 和delete 代替malloc() free()

int * psome = new int [10];
delete [] psome;

* 不要使用delete来释放不是new分配的内存
* 不要使用delete释放同一个内存块两次
* 如果使用new[]为数组分配内存，则应使用delete[]来释放
* 如果使用new[]为一个实体分配内存，则应使用delete来释放
* 对空指针应用delete是安全的

