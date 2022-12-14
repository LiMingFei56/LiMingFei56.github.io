---
layout: post
title: 回车与换行
categories: computer
tags: [computer]
date: 2022-10-24
---

## 回车与换行

* \r = CR (Carriage Return) → Used as a new line character in Mac OS before X
* \n = LF (Line Feed) → Used as a new line character in Unix/Mac OS X
* \r\n = CR + LF → Used as a new line character in Windows

> 在vim中, `\n`是匹配行结束, `\r`是匹配回车符. 插入中, `\n`是插入null字符(`^@`), `\r`是插入
> 回车`CR`. 所以要把字符替换成换行, 需要`%s/a/\r/g`

> 打开特殊字段匹配(可以匹配`^@`之类), :set magic

* NUL == 0x00 == 0 == Ctrl + @ == ^@ shown in vim
* LF == 0x0A == 10 == Ctrl + J
* CR == 0x0D == 13 == Ctrl + M == ^M shown in vim



## Reference
[How to replace a character by a newline in Vim](https://stackoverflow.com/questions/71323/how-to-replace-a-character-by-a-newline-in-vim)  
[What is the difference between \r\n, \r, and \n? [duplicate]](https://stackoverflow.com/questions/15433188/what-is-the-difference-between-r-n-r-and-n)  
