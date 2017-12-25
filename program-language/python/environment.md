---
layout: page
permalink: /program-language/python/environment
---

Environment

### Introduction

Python是由Guido van Rossum在1985 - 1990年创建的。

* 解释型，像脚本一样；也可以编译成字节码，执行
* 交互式
* 面向函数，面向结构，面向对象
* 动态数据类型和动态数据类型检查
* 自动垃圾回收
* 很容易与其他语言交互，c,c++,com,activeX,CORBA,JAVA

Python被设计为高可读性。使用英文关键字，不像其它的语言使用符号，而且语法结构比其他语言少。

### Python Environment Variables

* PYTHONPATH - 它有一个类似于PATH的角色。这个变量告诉Python解释器在哪里定位导入到程序中的模块文件
	。它应该包含Python源代码库目录和包含Python源代码的目录。 PYTHONPATH有时是由Python安装程序预设的
* PYTHONSTARTUP - 它包含一个包含Python源代码的初始化文件的路径。每次启动解释器都会执行它
	。它在Unix中被命名为.pythonrc.py，它包含加载实用程序或修改PYTHONPATH的命令
* PYTHONCASEOK - 它在Windows中用于指示Python在导入语句中查找第一个不区分大小写的匹配项。设置这个变量为任何值来激活它
* PYTHONHOME - 这是一个替代的模块搜索路径。它通常嵌入在PYTHONSTARTUP或PYTHONPATH目录中，以使开关模块库变得简单

### Running Python Option

1 -d It provides debug output.
2 -O It generates optimized bytecode (resulting in .pyo files).
3 -S Do not run import site to look for Python paths on startup.
4 -v verbose output (detailed trace on import statements).
5 -X disable class-based built-in exceptions (just use strings); obsolete starting with version 1.6.
6 -c cmd run Python script sent in as cmd string
7 file run Python script from given file

