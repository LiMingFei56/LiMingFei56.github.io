---
layout: page
permalink: ./technology-home/platform/flutter/user-interface/widget-box-constraints
---

## Box constraints

Widget渲染是由底层RenderBox来处理。RenderBox是由ParentWidget给出约束，约束包括
最小最大宽高，尺寸。


### 1. 约束的类型
通过有三种Boxes:
* 尝试尽可能的大空间，如Center和ListView
* 尝试和children一样的大小，如Transform和Opacity
* 尝试特定的大小，如Image(图片的大小)和Text(字的大小)

由参数决定约束，如Container - 默认是尽可能的大，但是可以指定width来限制
由flex决定约束，如Row and Column(Flex Boxes)

紧密约束 - 没有其余的可用空间（最小值等于最大值）。如App Widget，包含在RenderView
    类中，这个box赋予子Widget一个约束，强制其填充应用程序的内容区域。
稀疏约束 - 保持最大值，如Center。

大多Boxes，特别是只有一个孩子的Widget，都会把约束传递给孩子，这样可以保证boxes嵌
套时，它们可以完全适合。

### 2. 无限制约束
无限制约束就是把宽和高设置成`double.INFINITY`。

无限制约束时尽可能大的boxes不可以用，并在调试模式抛出异常。通常用于Flex Boxes和
Scrollable regions。

### 3. Flex
分为Main Axis 和 Cross Axis
MainAxisAlignment
CrossAxisAlignment 设置

CrossAxis不能是无限制的，不然不能工作

MainAxis有限 - 尝试尽可能的大
MainAxis无限制 - 尝试让子Widget适应这个方向。flex必须为0，不能使用Expanded
