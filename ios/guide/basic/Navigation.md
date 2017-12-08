---
layout: page
permalink: /ios/guide/basic/navigation
---

Navigation

### Segue
在两个Scenes之间跳转使用Segue。

Action Segue有多个类型:

	* Show
	* Show Detail
	* Present Modally
	* Present As Popover
	* Custom

Scene间传递数据的两种方法:

	* 使用Unwind Segue，用来传送简单的数据
	* 使用Delegate，用来传送复杂的数据

多个Segue是通过Identify来区分的

不同的Segue，返回的操作也不同

### Unwind Segue
Unwind Segue向后移动一个或者多个Scene，到一个存在的ViewController。实现Unwind Segue
需要提供ViewController中prepare方法，和 destination view controller。


### Navigation
Navigation Controller管理向后和向前的View Controller栈。Navigation stack中第一个
添加的View Controller永不会移除。


