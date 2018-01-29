---
layout: page
permalink: /program-language/java/data-structrue
---

Data structrue

### 基本数据类型

|Type     | Type Express | Explanation                              | sizeof |
|---------|--------------|------------------------------------------|--------|
|Byte     | byte or Byte | 1 or 0x1 or 01 or 0b0000001 or 000_001   | 1      |
|Character| char or Character | '1' 49 or 0x31 or 061 or 0b00110001 | 2      |
|Short    | short or Short | 1 or 0x1 or 01 or 0b00000001           | 2      |
|Integer  | int or Integer | 1 or 0x1 or 01 or 0b00000001           | 4      |
|Long     | long or Long   | 1 or 0x1 or 01 or 0b00000001 or 1l     | 8      |
|Float    | float or Float | 0.01 or 1e-2 or 0.01f                  | 4      |
|Double   | double or Double  | 0.01 or 1e-2 or 0.01                | 8      |
|Boolean  | boolean or Boolean| true or false 1不等于true           | 1      |
|String   | String         | "abc"                                  | +1     |
|Void     | Void or void   | 表示无类列，不能单独使用               |        |

### String特性
#### 不变性(immutable)
> String一旦生成就不再改变.

#### 常量池的优化
> 当2个String对象拥有相同的值时,他们只引用常量池中的同一个拷贝.

#### String类Final定义
> 让String不能有任何的子类,对系统安全性的保护.

### AbstractStringBuilder
> 可变长度的String,主要用来提高字符串连接的效率,如果使用'+'来连接字符串会创建多个字符串
  对象,造成一定的开销.AbstractStringBuilder内部使用char数组来保存字符串.每当添加内容
  时会先调用Arrays.copyOf来添加char数组长度,然后System.arraycopy添加内容.

#### StringBuffer
> 是线程安全的,操作char数组的方法上都加上的synchronized关键字.


### List研究
#### List简介
> List是一个有序的集合,这个接口可以通过索引精确控制元素的插入.用户可以使用元素的索引来查询
  元素.List不同Set,它允许插入重复的值,甚至允许插入null.

#### ArrayList和Vector
> ArrayList和Vector是List的实现,他们是用对象数组来保存元素,每当元素个数到达一个閥值那
  么它们会使用Arrays.copyOf来增加数组大小.ArrayList是一次增加原来大小的一半.Vector是
  先判断有没有设置增加的数目(capacityIncrement),如果没有设置就增加原来的数组长度.

> Vector是线程安全的,在元素操作上添加了synchronized关键字,性能比ArrayList差.

#### LinkedList
> 是使用双键表的结构(Node)来实现的,在添加和删除元素的操作上比ArrayList有性能好,但是在
  元素查询上没有ArrayList好.

### Set
> Set是一个无重复元素的Colletion,通过equals来比效2个对象,最多一个null元素.
  使用Iterator来迭代.

#### HashSet
> 通过Hashcode来对元素排序

#### TreeSet
> 通过Comparator来对元素排序

### Queue
> 用来处理先进先出(FIFO)的集合,在Collection接口之上,添加了插入,取出,检查3个操作.Queue
  操作有两种模式.
  1. 如果操作失败会抛出异常.add,remove,element.
  2. 如果操作失败会返回特殊的值,如null.offer,poll,peek.

#### DelayQueue
> 插入一个延迟的元素,只有元素到期后可以从头取出,不允许插入null.
  元素需要实现Delay接口,提供compareTO和getDelay一致的排序.

  DelayQueue是线程安全的.

### Stack
> 后进先出(LIFO)

### Map
> 是键值对,Key是set,不允许重复对象,null对象只能有一个.
  Hash Table是哈希表,一种散列表,长度是一个int

#### HashMap
> 以HashCode排序,不保证顺序

#### TreeMap
> 实现SortMap,能够保证记录根据键排序.

#### LinkedHashMap
> 也可以保证顺序

#### HashTable
> 安全的HashMap

