---
layout: page
permalink: /ios/develop/model/core-data
---

Core Data

### Introduction
Core Data是用来管理Model层对象的框架。它提供通用的和自动的处理与对象生命周期和对象图管理
（包括持久性）相关的常见任务的解决方案。Core Data可以有效的减少50%到70%的编码工作。
这主要是由于以下内置功能，您不必执行，测试或优化：

* 更改跟踪和内建管理的撤消与重作，除基本的文本编辑
* 维护变更传播，包括维护对象之间关系的一致性
* 对象的延迟加载，部分序列化（faulting）和写入时复制数据共享以减少开销
* 自动验证属性值。被管理对象扩展了标准的键值编码验证方法，以确保单个值处于可接受的范围内，这样值的组合就有意义
* 架构迁移工具，可以简化架构更改并允许您执行高效的就地架构迁移
* 与应用程序控制器层可选集成以支持用户界面同步
* 在存储器和用户界面中对数据进行分组，过滤和组织数据
* 自动支持将对象存储在外部数据存储库中
* 复杂的查询编译。通过将NSPredicate对象与获取请求相关联，您可以创建复杂的查询，而无需编写SQL
* 版本跟踪和乐观锁定，以支持自动多写冲突解决
* 与macOS和iOS工具链有效整合

支持多种存储类型：
* NSSQLiteStoreType
* NSBinaryStoreType
* NSInMemoryStoreType
* NSXMLStoreTyp

### 创建一个 Managed Object Model
Core Data的许多核心功能依赖应用创建entities,properties和它们的关系。Core Data使用一个Managed Object
Model，叫作`NSManagedObjectModel`。

托管对象模型允许核心数据从持久存储中的记录映射到您在应用程序中使用的托管对象。托管对象模型允许核心
数据从持久存储中的记录映射到您在应用程序中使用的托管对象。实体描述根据名称，用于在应用程序中表示实
体的类的名称以及它具有的属性（属性和关系）来描述实体（您可以将其视为数据库中的表）。

### Model
Model是使用Entity来表示的

#### Entity
* Entity Name与Class Name表示的内容不一样，所以名字可以不同。
* 如果Entity只是为了提供属性模板，而不会创建对象，那么可以设置为抽象的。
* Entity可以继承其他Entity。
* 使用Sqlite时要慎重的使用Entity继承，继承来的属性会放在单独的表中，这样设计有可能影响性能。

#### Attribute
需要定义一个属性名和属性类型，属性名称不能与NSObject或NSManagedObject的任何非参数方法名称相同

如果这个属性不需要序列化到本地，只是临时变量，那么使用把这个属性设置为 `Transient`。

这个属性设置成Optional，代表可以为空，但是推荐使用默认值0来代表空。因为Sqlite中的NULL与objc中的nil不一样。
objc中nil等于0,而Sqlite中NULL不等于0.

#### Relationship
Core Data支持一对一，一对多的关系，如果需要实现多对多需要创建多个Relationshiop

### Core Data Stack
Core Data Stack是一个集合框架，作为Core Data初始化的一部分进行访问，并在应用程序中的对象与外部数据存储之间进行调解。
Core Data Stack负责所有外部数据的存储。包括4个关键类:`NSManagedObjectContext`，`NSPersistentStoreCoordinator`，
`NSManagedObjectModel`，`NSPersistentContainer`。

#### NSPersistentContainer
iOS 10 和 macOS 10.12后使用NSPersistentContainer来创建Core Data。这个类是为了简化Core Data创建。
iOS 10 和 macOS 10.12前只能使用复杂的创建流程。

#### NSManagedObjectModel
Core Data创建完就会创建这个类，NSManagedObjectModel实例描述将要被核心数据栈访问的数据。
在创建核心数据堆栈期间，将NSManagedObjectModel作为创建堆栈的第一步加载到内存中。

#### NSPersistentStoreCoordinator
NSManagedObjectModel创建完成就会创建这个类，协调员负责实现在模型中定义的实体的实例。它在模型中创建实体的新实例，
并从持久性存储（NSPersistentStore）中检索现有实例。持久性存储可以在磁盘上或内存中。根据应用程序的结构，虽然不常见
，但有可能由NSPersistentStoreCoordinator协调多个持久性存储

NSManagedObjectModel定义了数据的结构，而NSPersistentStoreCoordinator则根据持久性存储中的数据实现对象，并将这些
对象传递给请求的NSManagedObjectContext。NSPersistentStoreCoordinator还验证数据是否处于与NSManagedObjectModel中的
定义相匹配的一致状态。

将NSPersistentStore添加到NSPersistentStoreCoordinator的调用是异步执行的。有几种情况会导致此调用阻塞调用线程
（例如，与iCloud和Migrations集成）。因此，最好异步执行此调用以避免阻塞用户界面队列。

#### NSManagedObjectContext
最后创建上下文对象，这是支持与应用交互的对象。将管理对象上下文看作智能便笺本。当您从持久性存储中获取对象时
，可以将临时副本带到它们形成对象图形（或对象图形集合）的便笺本中。然后，您可以修改这些对象，只要你喜欢。但是
，除非实际保存这些更改，否则持久性存储保持不变。

所有托管对象都必须使用托管对象上下文进行注册。您可以使用上下文将对象添加到对象图中，并从对象图中删除对象
。上下文跟踪您所做的更改，包括单个对象的属性以及对象之间的关系。通过跟踪更改，上下文可以为您提供撤消和重做支持
。它还可以确保如果您更改对象之间的关系，对象图的完整性将保持不变。

如果选择保存所做的更改，上下文将确保您的对象处于有效状态。如果是这样，则将更改写入持久存储（或存储）
，为您创建的对象添加新记录，并删除您删除的对象的记录。

### 创建和存储Managed Object
在定义了托管对象模型并在应用程序中初始化了核心数据堆栈后，就可以开始为数据存储创建对象。

NSManagedObject对象创建需要2个对象` NSEntityDescription `和`NSManagedObjectContext `

### 读取Managed Object

`NSFetchRequest`，可以使用`NSPredicate`过滤结果，还可以使用配置`NSFetchRequest`，返回`NSDictionary`

如果需要实现自定义的Model逻辑，新需要继承`NSManagedObject`类。

### iOS与Core Data交互
macOS可以使用cocoa bindings实现mvvm，但是在iOS中只能使用`NSFetchedResultsController`。

#### 分页
使用`NSSortDescriptor`对象，可以把数据通过sectionNameKeyPath分成几个部分。

* sectionNameKeyPath属性也必须是NSSortDescriptor实例
* NSSortDescriptor必须是传递给获取请求的数组中的第一个描述符

#### 缓存

	[self setFetchedResultsController:[[NSFetchedResultsController alloc] 
	  initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:@"department.name" cacheName:@"rootCache"]];



### 管理Managed Objects生命周期
默认Context与MO关系是弱引用，需要Context保存强引用需要对Context设置`retainsRegisteredObjects`为true。
当Context保存有MO的强引用时，需要使用`refreshObject:mergeChanges:`方法，margeChanges为YES会合并当前对象和存储对象。
如果为NO就会设置当前对象为FAULT，Context会丢弃这个对象的引用。

Context会保存未做决定的MO对象，如调用了(save,reset,rollback,dealloc方法)，如果这时撤消会导致这些更改撤消，强引用
会改变回弱引用。

系统会保存无限长度的撤消操作，为了内存占用，需要在适当的时候调用`removeAllActions`清除context’s undo stack。

如果不需要撤消功能，可以设备Context的`undo manager`为nil。

### Managed Object 关系

#### 关系的基础

关系指定目标的对象的实体或父实体。该实体可以与源实体（自反关系）相同。关系不需要引用单个实体类型。
如果员工有两个实体，说经理和助理，员工不是抽象的，某一部门的员工可以由员工（实体）、经理（分部员工）
，助理（分部的员工），或它们的任意组合。

在关系窗格的类型字段中，可以指定关系为一个或多个，这称为基数。对一个关系由对目标对象的引用表示
，对许多关系用可变集表示。隐式地，一对多通常分别引用一对一和一对多关系。多对多关系是一种关系及其逆关系。
如何建模多对多关系取决于模式的语义。有关这种关系的详细信息，请参见多对多关系。

您还可以对多关系的目的地上的对象数量进行上限和下限。下限不一定是零。你可以指定一个部门的雇员人数必须
在3到40之间。还可以指定关系为可选的或不可选的。如果一个关系不是可选的，那么如果它是有效的，那么在
关系的目的地就必须有一个对象或对象。

基数和可选性是一个关系的正交特性。您可以指定关系是可选的，即使您有指定的上限或下限，或者两者都是。
这意味着不需要在目的地上有任何对象，但是如果存在，对象的数量必须位于指定的界限内。

#### 关系删除规则

* deny - 如果关系目标中至少有一个对象，则不要删除源对象
* nullify - 删除对象之间的关系，但不要删除任何对象
* cascade - 在删除源时，删除关系目的地的对象
* No Action - 对关系目的地的对象不做任何事情

#### 修改关系保持对象的完整性
当修改对象图时，Core Data会保持对象的完整性，只用简单的代码

	anEmployee.department = newDepartment;

#### Weak Relationships
也叫作Fetched property,通常用于跨store的关系，松散的成对关系，把相似的组成组。

与一般关系的不同:
* 使用fetch request请示数据。
* 返回的是NSArray，而不是一般关系的NSSet
* 被懒惰地评估，随后被缓存

### Faulting and Uniquing
* faulting 是一种CoreData降低内存使用的机制,是惰性加载的一种。
* Uniquing是辅助faulting的机制，它保证了在一个managed object context中只有一个managed object来表达一条记录

#### Faulting
faulting 限制对象图的大小
一个fault在内存里就是一个对象的占位符，这个占位符代表的对象并没有完全取到内存里。分为两种：

* 一个managed object的fault就是相关类的对象，但是对象的持久化存储的属性没有被初始化
* 一个relationship 的fault表示对应的集合的实例。
这样的占位符的方式降低了内存使用，也不需要把fault对象相关的对象再取到内存里。 
例如，取出如图的一个employee，那么员工的manager,department,reports默认都是fault来表示

fault对于使用者来说是透明的，在用户使用到对应的fault对象的持久化存储的属性时候，coredata会自动从磁
盘取出对应数据，这个过程称为Firing Faults.

#### Firing Faults
* CoreData先到持久化存储协调器的Cache里查找，如果有则返回，这个过程是否效率很高
* 如果没有，则自动执行一次fetch，把对应的数据返回，并且加入到持久化存储协调器的Cache里


