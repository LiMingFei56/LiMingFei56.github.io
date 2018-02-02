---
layout: page
permalink: /program-language/c++/memory-model
---

Memory Model

### Dynamic Memory

#### 内存模型

Stack - 所有局部变量会保存到栈时，过了作用域会自动删除
Heap  - 在运行时动态分配的内存，需要自己管理

使用`new`关键字分配的内存，需要调用`delete`释放内存

避免在C++中使用C的malloc()函数，因为`new`可以有效的创建对象

### 命名空间
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

### 对象存储
#### 自动存储

#### 静态存储

#### 动态存储

#### 线程存储
