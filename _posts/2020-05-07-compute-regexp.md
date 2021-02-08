---
layout: post
title: "Compute RegExp"
categories: computer
tags: [computer]
date: 2020-05-07
---

## Compute RegExp

### Unix 正则表达式

> 使用sed时, 不能使用`|`操作, 查询了一下[Regex alternation/or operator (foo|bar) in GNU or BSD Sed
](https://unix.stackexchange.com/questions/145402/regex-alternation-or-operator-foobar-in-gnu-or-bsd-sed)
> sed 是使用POSIX基本正则, 不包括`|`操作, 需要使用`-E`参数开启正则扩展


### 反向引用

> 替换时, 需要使用前面匹配到的对象, 需要使用到反向引用. 首先需要对正则表达式使用
> 分组, 然后在替换时引用分组.
>

    # vim \1 代表分组1
    %s/\(.*\)——\(.*\)/\2——\1/g

    %s/\([a-z]*\)\(.\{2,3\}\),/\1\=${\1},/g

### Reference
[Regular Expressions](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03)
[Extended Regular Expressions](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04_03)
