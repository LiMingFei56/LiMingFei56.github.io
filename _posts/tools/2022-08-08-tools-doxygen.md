---
layout: post
title: Doxygen
categories: tools
tags: [tools]
date: 2022-08-08
---

## Doxygen

> 文档生成工具, 是以配置文件配置项来工作, 也可以用`doxywizard`qt 写的gui工具来配置.
> 每个项目都要有自己的配置文件

    doxygen -g <config-file> // 产生配置文件
    doxygen <config-file>    // 产生文档

### 配置文件选项

* INPUT: 指定源文件, 如果为空查询当前目录下的.h, .c, .cpp源文件. 如果是大型项目, 需要可以指定一个
  或者多个目录, 并且配置`FILE_PATTERNS`
* FILE\_PATTERNS: 文件模式匹配, 如\*.cpp, \*.h
* RECURSIVE: 递归查询源文件
* EXCLUDE: 排除文件
* EXCLUDE\_PATTERNS: 排除模式匹配
* EXTENSION\_MAPPING:
* EXTRACT\_ALL
* SOURCE\_BROWSER: 分析源代码
* OUTPUT\_DIRECTORY: 指定文档输出目录
    1 RTF_OUTPUT
    2 LATEX_OUTPUT
    3 XML_OUTPUT
    4 MAN_OUTPUT
    5 DOCBOOK_OUTPUT
* BRIEF\_MEMBER\_DESC
* REPEAT\_BRIEF
* JAVADOC\_AUTOBRIEF

### 注释

#### Comment blocks for C-like languages (C/C++/C#/Objective-C/PHP/Java)

> 一共有三种风格:

    1. javadoc风格

        /**
         * ... text ...
         */

    2. QT风格

        /*!
         * ... text ...
         */

    3. C++ 风格

        ///
        /// ... text ...
        ///

        //!
        //!... text ...
        //!

> 当前使用Javadoc风格, 别的风格见管网

1. 成员后面加文档
        
        int var; /**< Detailed description after the member */

2. 函数:
        
> `@param`表示参数, [in, out] 表示方向, 也可以使用内联注释, `<`表示字段在注释前面

        void foo(int v /**< [in] docs for input parameter v. */);

### Special Commands

> 可以使用`\`或者`@`开头
    

## Reference
[Doxygen](https://doxygen.nl/manual/index.html)  
