---
layout: page
permalink: /tools/regular_expressions/syntax
---

正则表达式语法

### 1. 字符字面值
*abc*: 字符字面值是最基本的regex是字符字面值,区分大小写

*\Q..\E*: 它们之间所有字符都被当作字面值表示,\E可以省略.JGsoft engine
, Perl, PCRE, PHP, Delphi, Java支持这种语法,java4 5有bug.Boots支持外面的字符,但
不支持里面的.

### 2. 不可打印字符
	\t			: 匹配制表符										ASCII 0x09
 	\r 			: 匹配回车											ASCII 0x0D
 	\n 			: 匹配换行											ASCII 0x0A
 	\a 			: 匹配钟											ASCII 0x07
 	\e 			: 匹配ESC											ASCII 0x1B
 	\f 			: 匹配换页											ASCII 0x0C
 	\v 			: 匹配垂直选项(有一些引擎是表示其他意思)			ASCII 0x08
 	\c(A-Z)(a-z): 匹配Ctrl+A-Z(\c后其他字符不被推荐使用,有的引擎只支持大写字母)
 	\u or \x	: 表示一个Unicode字符(\u4e00-\u9fa5表示中文)
 	\x			: 表示一个十六进制数,或引擎编码中对应的字符
 	\0			: 表示一个八进制

### 3. 字符集
字符集可以让引擎匹配几个字符中的一个,使用"[]"括起来,比如gr[ae]y,可以匹配gray和
grey.如果不知道文档是英国写的还是美国写的.

[]中的顺序不重要,结果是一样的.

字符集可以使用连接符来表示范围,[0-9]表示0到9中选一个数字.当中也可以使用多个范围
[0-9a-fA-F]0到9或者a到f或者A到F.也可以范围与单个字符一起使用.

可以使用[A-Za-z_][A-Za-z_0-9]*在编程语言中查找一个标识符
可以使用0[xX][A-Fa-f0-9]+可以在C语言中匹配一个16进制

#### 3.1. 否定字符集
在"["后面输入否定符"^"表示取不在这个选择里的,[^0-9]表示除0到9数字外的,这也会匹配
换行符,如果不想匹配换行符需要把换行符添加到字符集中{^0-9\r\n} 否定字符集也是需要匹配一个字符,q[^u]不是表示q后面没有u,而是q后面跟随一个非u字符.

#### 3.2. 字符集中的元字符
在字符集中特殊符号为],\,^,-.

如果表示取星号或加号可以使用[*+]

#### 3.3. 重复字符集
使用?,+,*可以重复一个字符集.重复字符集不是重复匹配结果.

#### 3.4. 引擎中的字符集
引擎会尝试regex中所有的可能来匹配.而且会从左到右去取.

#### 3.5. 字符集减法
XML Schema, XPath, .Net, JGsof支持

[a-z-[aeiuo]]

[0-9a-f-[4-6]]

否定优先减法

大多引擎不支持字符集减法,但是该表达式在其他引擎中是正确的,但是结果不正确.

#### 3.6. 字符集交集
支持Java, JGsoft V2, and by Ruby 1.9 and later.

[class&&[intersect]] == [class&&intersect]

[0-9&&[0-6&&[4-9]]] 匹配4-6

不支持的引擎会把&当成字面值

#### 3.7. 速记字符集
	\d	数字 [0-9] (大多数支持Unicode中所有数字,Java,Javascript,PCRE除外)
	\w	文字 [A-Za-z0-9_] (Unicode中其他script,ASCII也不一样)
	\s	空白 [ \t\r\n\f] (包含什么取决与引擎
	\v	垂直制表符 
[\da-fA-F]字符集中使用速记
[^\d]否定速记

引擎有些自己独有的速记字符集

#### 3.8. 点字符
点可以匹配所有字符(除了换行符)

有一些引擎有选项,可以使点可以匹配换行符

换行符在不同的引擎里也不一样.大多数使用\n当作换行,windows中会把\r\n转换成\n.
也有的引擎可以使用选项把\n当作换行符.

### 4. 边界锚
边界锚不是匹配字符,而是表示之前,之后,之中.

**^**: 表示字符前边界 ^a 匹配abc,而^b不匹配,只匹配行内

**$**: 表示字符后边界 c$ 匹配abc,而a$不匹配,只匹配行内
如果引擎支持多行匹配选项,打开的话^&可以匹配多行

单独的锚会配置一个0长度的字符,有时候有用,有时候会出问题.

**\A**:匹配字符串的开始,在整个文件中匹配
""\Z"":匹配字符串的结尾,在整个文件中匹配

### 5. 字边界
**\b**: 匹配0字符,表示字的边界

### 6. 选择条
**|**: 在多个选项中选择第一个匹配的选

### 7. 可选项
**?**: 代表前面的字符是可选的.

但是?是贪婪的,除非不能匹配,否则就匹配.

### 8. 重复符
**\***: 匹配指定字符0次到多次,贪婪,匹配尽量多

**+**: 匹配指定字符1次到多次,贪婪,匹配尽量多

**{min,max}**: 限制重复次数

*和+号都是贪心的,可以在它们后面加?,表示懒惰的,尽量少匹配

懒惰的替代方案,<[^>]+>,   匹配html标签.所为懒惰的匹配会发生回溯,而加号不会发生回
溯.

\Q..\E后面加量词,只对之间最后一个字符起作用.

### 9. 组和抓取
可以使用()把一个片段当成一个组,可以使用量词作用到这个组上.括号会创建一个数字抓取
组,会保存()中的内容.

使用组抓取可以很方便的反向引用匹配出来的段落.序号从1开始,最大支持99.
如果不想组编号,可以使用(?:)语法.

可以使用原子组, 不用回溯到抓取组.

### 10. 命名组和命名反向引用
现代的引擎都支持对组的命名和使用命名来反向引用.

Python 使用`(?P<name>group)` 来命名,使用` (?P=name)`来引用group
Java7 .Net 使用`(?<name>group) or (?'name'group)` 来命名,使用 \k<name> 
	or \k'name' 来引用

命名组和下标组不推荐混合使用

命名组最好不要用同一个名字,但是有些引擎支持使用同名组,他们会使用同一个存储地址来
存储组的值.

### 11. 相对的反向引用
有一些引擎支持相对的反向引用,(a)(b)(c)\k<-3>匹配abca,(a)(b)(c\k<-2>)匹配abcb

### 12. 分支重置组
使用`(?|regex)`来表示一个分支重置组,如(?|(a)|(b)|(c)),有a b c三个选择,但是共用
一个下标为1的组.

命名组可以和分支重置组下起使用.

### 13. 自由间隔表达式
现代引擎支持自由间隔表达式,可以让表达式更据可读性.
a b c匹配abc

### 14. 在表达式中指定匹配模式
有时候工具和语言不会提供配置,而且不同引擎的配置又不一样.
可以在正则表达式开头配置引擎,(?ismx)

* (?i): 表达式不区分大小写
* (?c): 表达式大小写敏感,只支持Tcl
* (?x): 打开自由间距模式
* (?t): 关闭自由间距模式,只支持Tcl
* (?s): 单行模式中,点可以匹配换行符
* (?m): 多行模式中,使每行的开关和结尾跟"$"匹配
* (?p): Tcl中使每行的开头和结尾匹配"$",和使点匹配换行符
* (?w): 在Tcl中,插入和美元符号只在主题字符串中匹配开关和结尾,和不匹配换行符
* (?n): 将所有未命名的组变成非捕获组。只支持.NET，XRegExp和JGsoft风格。在Tcl中
		，（？n）与（？m）相同
* (?J): 允许重复的组名称。只有PCRE和使用它的语言支持，如Delphi，PHP和R.
* (?U): 打开“非理性模式”，它切换贪婪和懒惰的量词的语法。
* (?d): UNIX_LINES,只匹配换行,而不匹配\r\n和unicode中其他换行
* (?b): 使得Tcl将正则表达式解释为POSIX BRE。
* (?e): 使得Tcl将正则表达式解释为POSIX ERE.
* (?q): 使得Tcl将正则表达式解释为一个文字字符串（减去（？q）字符）。
* (?X): 如果该组合不是有效的正则表达式标记，则会使用反斜杠转义字母。只有PCRE
		和使用它的语言才支持。

现代引擎允许把配置放到表达式的中间,那么配置只试用于配置的右侧部分.可以使用"-"来
关闭一个选项.

### 15. 原子组
使用`(?>group)`,原子组一个组,当正则表达式引擎退出时，会自动抛弃组内任何标记记忆
的所有回溯位置.

### 16. Possessive quantifiers
表达式不管是贪婪,还是懒惰,都会回溯尝试所有可能的匹配.Possessive Quantifiers是出于
性能考虑,防止引擎过多的回溯匹配.

多使用一个"+"就会让引擎不必尝试过多的匹配

*+,++,?+,{n,m}+

### 17. Lookahead and Lookbehind Zero-Length Assertions
lookahead 和 lookbehind 统称为 lookaround. 之所以叫0宽断言是因为lookaround不会占
用字符,只会返回是否匹配.

 * `(?=(regex))` lookahead肯定regex匹配
 * `(?!(regex))` lookahead否定regex匹配
 * `(?<=(regex))` lookbehind肯定regex匹配
 * `(?<!(regex))` lookbehind否定regex匹配

lookaround是原子的,引擎会忘记它周围的一切,不会在lookaround中尝试回溯.

\K是lookbehind的新特性,`a\Kb`等价于`(?<=a)b`

### 18. 条件判断
`(?ifthen|else) ` 条件判断表达式,如果if为true就匹配then,否则匹配else.

if块可以使用lookaround.

	(?(?=regex)then|else)

if块可以使用命名捕获组的名称.

	(?<test>a)?b(?(test)c|d)

### 19. 平衡组
平衡组是用来匹配平衡结构和嵌套结构,学术上叫作抓捕组减法.

.NET使用平衡

Perl,PCRE,Ruby是使用递归

JGsoft V2支持平衡和递归

(?<capture-subtract>regex) or (?'capture-subtract'regex) 使用命名抓取组
(?<-subtract>regex) or (?'-subtract'regex) 使用命名非抓取组

平衡组会保存一个匹配,然后减去匹配的项,直到结束或不匹配.

	(?'open'o)+(?'-open'c)+   匹配   ooooooooooccccccccc

### 20. Perl,PCRE,Ruby 递归


[其他见教程](http://www.regular-expressions.info/continue.html)
