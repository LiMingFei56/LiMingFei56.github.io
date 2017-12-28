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


