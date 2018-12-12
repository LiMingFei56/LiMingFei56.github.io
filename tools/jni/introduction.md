---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/jni/introduction
---

## Introduction
Java Native Interface(JNI), 允许Java代码通过Java VM与c, c++, assembly交互.
JNI不影响Java VM内部实现, 所以JNI程序可以在所以支持JNI Java VM上运行.

什么情况下会用到JNI:
    1. 标准Java库不能实现的, 与平台相关的功能
    2. 已经用c, c++, assembli实现的库, 希望在Java环境中使用
    3. 性能, 安全相关的一块代码

JNI可以调用Java的哪些功能:
    1. 创建, 检查, 更新Java对象
    2. 调用Java方法
    3. 捕获和抛出异常
    4. 装载Classes和获得Class信息
    5. 执行运行时类型检测

### 历史
来自不同供应商的VM提供不同的本机方法接口

Java Native Interface有多个版本:
    * JDK 1.0 native method interface
    * Netscape’s Java Runtime Interface
    * Microsoft’s Raw Native Interface and Java/COM interface

JDK 1.0 native method interface 因2个最大问题被淘汰:
    * C读Java对象是按照Structures来读取, 但是Java标准没有对Java对象保存到内存的描述, 如果Java VM这块变了
        那么JNI程序需要重新编译
    * 依赖保守垃圾回收, 不受限制地使用unhand宏使得必须保守地扫描本机堆栈

Java Runtime Interface:
    * 考虑了移植性, 对Java VM的行为假设较少
    * JRI解决了广泛的问题，包括本机方法，调试，反射，嵌入（调用）等

Raw Native Interface and Java/COM Interface:
Microsoft提供了二种本地方法接口:
    * 底等级Raw Native Interface (RNI), RNI提供了与JDK本机方法接口的高度源级向后兼容性，尽管它有一个主要区别。本机代码必须使用RNI函数与垃圾收集器明确交互，而不是依赖于保守的垃圾收集。
    * 高等级Java/COM interface, 为Java VM提供与语言无关的标准二进制接口。 Java代码可以像使用Java对象一样使用COM对象。 Java类也可以作为COM类公开给系统的其余部分。

### 目标(标准化JNI)
    * 每个VM 供应商都要支持大体积的Native Code
    * 针对不同的VM 不用不同的VM
    * 编写一次代码, 可以在不同的VM上运行

把VM供应商一起组成标准组织:
    * 二进制兼容性 - 主要目标是在给定平台上的所有Java VM实现中对本机方法库进行二进制兼容。程序员应该只为给定平台维护其本机方法库的一个版本。
    * 效率 - 为了支持时间关键代码，本机方法接口必须施加很少的开销。确保VM独立性（以及二进制兼容性）的所有已知技术都带有一定量的开销。我们必须以某种方式在效率和VM独立性之间达成妥协。
    * 功能 - 接口必须公开足够的Java VM内部，以允许本机方法完成有用的任务。

### Java Native Interface Approach
希望选择一个现有的方法来作为标准接口, 但是这个总是很难:

JRI是最好的, JNI就是参照JRI来实现的, 但是JNI和JRI不是二进制兼容的

RNI是JDK 1.0 nmi的补充, 但:
    * RNI将内部Java对象的布局暴露给本机代码
    * 直接访问Java对象作为C结构使得无法有效地合并“写入障碍”，这在高级垃圾收集算法中是必需的。

Java/COM Interface:
    * 首先，Java / COM接口缺少某些所需的功能，例如访问私有字段和引发一般异常。
    * 其次，Java / COM接口自动为Java对象提供标准的IUnknown和IDispatch COM接口，以便本机代码可以访问公共方法和字段。遗憾的是，IDispatch接口不处理重载的Java方法
      ，并且在匹配方法名称时不区分大小写。此外，通过IDispatch接口公开的所有Java方法都被包装以执行动态类型检查和强制。这是因为IDispatch接口在设计时考虑了弱类型
      语言（例如Basic）。
    * 第三，COM不是处理单独的低级功能，而是旨在允许软件组件（包括完整的应用程序）协同工作。我们认为将所有Java类或低级本机方法视为软件组件是不合适的。
    * 第四，由于缺乏对UNIX平台的支持，因此立即采用COM受到阻碍。

虽然Java对象不作为COM对象公开给本机代码，但JNI接口本身与COM二进制兼容。 JNI使用与COM相同的跳转表结构和调用约定。这意味着，只要跨平台支持COM，JNI就可以成为Java VM的COM接口。

JNI不被认为是给定Java VM支持的唯一本机方法接口。标准接口使程序员受益，他们希望将本机代码库加载到不同的Java VM中。在某些情况下，程序员可能必须使用较低级别的
VM特定接口来实现最高效率。在其他情况下，程序员可能使用更高级别的界面来构建软件组件。实际上，随着Java环境和组件软件技术的日趋成熟，本机方法将逐渐失去意义。




