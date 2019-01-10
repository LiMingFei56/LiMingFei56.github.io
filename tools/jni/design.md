---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/jni/design
---

## Design

### JNI Interface Functions and Pointers

1. 本地代码通过JNI Functions来访问Java VM的功能
2. JNI functions是实现了一个Interface pointer.
3. Interface Pointer是一个指向指针的指针
4. 第一个Pointer是一个指向Pointer数组
5. Pointer数组的每一个Pointer都指向一个interface funcation
6. 每个interface funcation 都在数组内的预定义偏移处
    
### Description Of figure interface pointer

  JNI interface的组织结构像 C++的虚函数表或者COM接口. 使用接口表比使用硬连接好,
可以把JNI名称空间与本地代码分离. 一个VM可以容易的提供多个版本的JNI函数表.

* JNI interface pointer只在当前线程有效, 不能传递给其他线程, 但允许在Pointer
      的作用域生成和保存thread-local data.
* 本地方法会接收一个JNI interface pointer作为参数. 同一个JAVA线程中调用本地方法, 
      传递的JNI interface pointer

### Compiling, Loading and Linking Native Methods

因为JAVA VM是多线程的, 所以本地代码编辑时应该加上支持多线程的参数.
    
使用System.loadLibrary加载本地方法:
* 参数是本地库的名字, 不带后缀(因为特定的平台会转换成不同的库名称,  pkg_Cls to libpkg_Cls.so, pkg_Cls to pkg_Cls.dll)
* 每个class loader维护一个本地库的列表, 所以不能冲突. 单个库的本地方法可以在多个类中, 这些类需要在同一个class loader中.
* `静态加载`: 使得library和VM结合并依赖. 需要System.loadLibrary调用成功(或者等效的方法), 使库是加载的
* 一个库L, 当且仅当实现方法为"JNI_OnLoad_L", 被认为是静态链接的
* 如果静态链接的库L, 实现"JNI_OnLoad_L"和"JNI_OnLoad"两个函数, 那么"JNI_OnLoad"会被忽略
* 如果System.loadLibrary("L")第一次调用, 那么会使用JNI_OnLoad相同的参数和返回值, 调用"JNI_OnLoad_L"
* 库L静态加载后, 禁止再动态加载
* 当库L所在的Class loader被垃圾回收, 那么当库L实现"JNI_OnUnload_L"时会被执行
* 当库L实现"JNI_OnUnLoad_L"和"JNI_OnUnLoad"时, "JNI_OnUnLoad"会被忽略
* RegisterNatives() 注册类相关的本地方法, 是静态链接

#### Resolving Native Method Names
动态链接器根据其名称解析条目:
* 前缀"Java_"
* 一个全路径的类名
* 一个下划线分隔符
* 一个方法名
* 对于重载的本机方法，两个下划线（“__”）后跟参数签名

VM会在本地库中查找本地方法, 只有本地方法重载时才匹配参数, 不然只匹配方法名. 本地方法和JAVA方法不会冲突.

本地方法名转义: 使用"_"分隔, 使用数字开头为转义字符:
    * 0xxxx:Unicode
    * 1    :'_'
    * 2    :';'
    * 3    :'['

本地方法调用都遵循给定平台上的标准库调用约定. UNIX systems use the C calling convention, while Win32 systems use __stdcall.

#### Native Method Argaments

JNI interface pointer是本地方法的第一个参数, 类型是JNIEnv.
第二个方法参数根据是否是静态方式(静态方式就是类的引用, 非静态方式为类对象的引用)
剩下的参数对应JAVA的函数参数

* 使用C++可以省略JniEnv的间接引用, 和JniEvn参数.
* 底层实现是一样的, 在C++中JNI函数被实现为内联成员函数, 扩展后跟C一样

### Referencing Java Objects
原始类型在JAVA和本地方法之间是值传递. 
JAVA对象是引用传递: 
1. JAVA层中垃圾回收器需要保留并跟踪对象, 以免使用时被回收, 不需要时再回收
2. 本地代码中可以标记对象, 可以被回收, 并正确的被垃圾回收器回收

#### Global and Local References
JNI驱动中使用两种引用:
local: local references 在本地方法调用中有效, 在本地方法返回后可以自动回收
Global: global references 需要显示的释放内存, 才会被回收

* 默认本地方法是使用local作为参数和返回
* 允许使用local创建global引用
* Java方法应该接收本地和全局引用
* 本地方法可以返回本地和全局引用

有些时候使用local引用也要手动释放:
* 使用大型Java对象, 本地方法返回去执行了其他的计算并引用了, 那么该方法返回后不参自动释放回收.
* 本地方法创建的大量本地引用, 不会都是同时需要的. 使用后手动释放节约内存

JNI允许在本地方法任何地方删除本地引用, 最好不要创建额外的本地引用, 返回的除外
本地引用只在当前线程中有效

#### Implementing Local references
Java到本地方法的本地引用(包括本地方法返回的本地引用), 会放到一个注册表中(防止垃圾回收), 当本地方法返回后
会把注册表中的条目全部删除, 用以垃圾回收.

注册表不会删除重复引用.
不保证全局引用和堆内存中的回收.

### Accessing Java Object
JNI提供丰富访问global和local引用的接口, 这意味着无论VM如何在内部表示Java对象，相同的本机方法实现都会起作用

通过这些API访问引用数据, 开销有些高, 首先考虑使用本地数据结构.

#### Accessing Primitive Arrays
传给本地代码数组或者字符串, 迭代Java数组并使用函数调用检索每个元素, 非常低效.

使用`pinning`, 确定数组的内容, 本地代码直接得到数组的指针.
    * 垃圾回收器需要支持pinning.
    * VM必须在内存中连续布局原始数组(boolean除外可以打包或解包, 不可移植)

提供一组函数复制JAVA数组的一段到本地内存缓冲区, 如果只需要大数组的小量元素可以使用.
使用另一组函数来检索数组的`pinning`版本, 这些功能可能需要Java VM执行存储分配和复制。这些函数实际上是否复制数组取决于VM实现
    * 如果垃圾回收器支付pinning, 那么不需要复制
    * 否则复制到本地代码堆内存, 并返回一个指针

当不再需要时, 本地代码通知JNI, JNI会协调原始数组和复制的数组后释放内存.

垃圾回收器算法需要灵活决定复制或者pinning
JNI实现需要支持多线程访问同一个数组

#### Accessing Fields and Methods
JNI通过符号名称和类型签名来标识方法和字段

通过两步过程来定位字段和方法:

```
jmethodID mid = env->GetMethodID(cls, “f”, “(ILjava/lang/String;)D”);
jdouble result = env->CallDoubleMethod(obj, mid, 10, str);
```

field or method id 不会阻止VM卸载这个id对应的类, 该类卸载后id无效:
    * 保证类的实时引用
    * 重新计算id

### Reporting Programming Errors
JNI 不会检测参数的有效性, 由程序员控制, 非法参数会导致错误的结果, 甚至VM Crash

JNI 允许本机代码引发任意JAVA异常, 也可以处理Java异常. 未处理的Java异常会传播回VM

#### Exceptions and Error Codes
本地代码有时会返回一个错误代码和抛出异常来报告一个错误.

Java代码判断返回值是否异常, 再调用ExceptionOccurred()获取异常详细信息.
有两种情况需要先调用ExceptionOccurred():
    * 本地代码返回调用Java代码的结果
    * 某些JNI数组访问函数不返回错误代码, ArrayIndexOutOfBoundsException或ArrayStoreException

#### Asynchronous Exceptions
在多线程的情况下，当前线程以外的线程可能会发布异步异常。异步异常不会立即影响当前线程中本机代码的执行，直到:
    * 本机代码调用可能引发同步异常的JNI函数之一，或
    * 本机代码使用ExceptionOccurred（）显式检查同步和异步异常。

请注意，只有那些可能引发同步异常的JNI函数才会检查异步异常。
本机方法应在必要的位置插入ExceptionOccurred（）检查（例如在没有其他异常检查的紧密循环中），以确保当前线程在合理的时间内响应异步异常。

#### Exception Handling
有两种方法可以处理本机代码中的异常：
    * 本机方法可以选择立即返回，从而导致在启动本机方法调用的Java代码中抛出异常。
    * 本机代码可以通过调用ExceptionClear（）来清除异常，然后执行自己的异常处理代码。

引发异常后，本机代码必须首先清除异常，然后再进行其他JNI调用。当存在挂起的异常时，可以安全调用的JNI函数是：

ExceptionOccurred()
ExceptionDescribe()
ExceptionClear()
ExceptionCheck()
ReleaseStringChars()
ReleaseStringUTFChars()
ReleaseStringCritical()
Release<Type>ArrayElements()
ReleasePrimitiveArrayCritical()
DeleteLocalRef()
DeleteGlobalRef()
DeleteWeakGlobalRef()
MonitorExit()
PushLocalFrame()
PopLocalFrame()







