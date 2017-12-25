---
layout: page
permalink: /program-language/objective-c/memory-model
---

Memory Model

### 内存管理
Objective-C 内存管理技术大致分为两类，唯一区别是MRR是手动释放内存，ARC是自动释放内存：

* "Manual Retain-Release" or MRR
* "Automatic Reference Counting" or ARC

#### "Manual Retain-Release" or MRR
* 我们自己的对象我们自己创建：我们创建对象使用方法`alloc`,`new`,`copy`,`mutableCopy`
* 我们可以使用retain来取得一个对象的所有权：一个接收到的对象通常保证在接收到的方法中保持有效
	，并且该方法还可以安全地将对象返回给它的调用者。我们在两种情况下使用保留
	- 在访问器方法或init方法的实现中，将要存储的对象的所有权作为属性值存储
	- 防止某个对象作为其他操作的副作用而失效
* 当我们不再需要它时，我们必须放弃我们拥有的对象的所有权：我们通过发送一个释放消息或一个自动
	释放消息来放弃对象的所有权。在Cocoa术语中，放弃对象的所有权通常被称为“释放”对象
* 您不得放弃您不属于自己的对象的所有权：这是前面明确规定的政策规则的必然结果

	retainCount 方法返回引用数量
	retain 方法获取一个引用
	release 方法释放一个引用

#### "Automatic Reference Counting" or ARC
使用ARC计算跟MRR一样，但是不用自己调用方法获取和释放引用。使用ARC需要告诉底层代码开启ARC。

	@autoreleasepool{
	}

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	[pool drain];
