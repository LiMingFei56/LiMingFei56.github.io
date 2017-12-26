---
layout: page
permalink: /program-language/python/regular-expression
---

Regular Expression

python中`re`模块提供Perl-like的正则表达式支持。为了防止一些字符转义带来的混淆，可以使用Raw String。

### Match 函数
从字符串开头开始匹配

	re.match(pattern, string, flags=0)

#### 获取抓取组

	match.group(num=0)
	match.groups()

### Search 函数
从字符串任意位置开妈匹配

	re.search(pattern, string, flags=0)

#### 获取抓取组

	match.group(num=0)
	match.groups()
	
### Search and Replace

	e.sub(pattern, repl, string, max=0)

### Option Flags

* re.I 不区分大小写
* re.L 根据当前语言环境来解释单词。这个解释影响字母组（\ w和\ W），以及字边界行为（\ b和\ B）
* re.M 使$匹配一行的结尾（不仅仅是字符串的结尾），并使^匹配任何行的开始（不仅仅是字符串的开始）
* re.S 使句点（点）匹配任何字符，包括换行符
* re.U 根据Unicode字符集解释字母。此标志影响\ w，\ W，\ b，\ B的行为
* re.X 允许“cuter”正则表达式语法。它忽略空格（除了set []内部或者被反斜杠转义），并将未转义的＃作为注释标记


