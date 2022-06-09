---
layout: post
title: "Tools MySqlWorkbench"
categories: tools
tags: [tools]
date: 2021-02-04
---

## Tools MySqlWorkbench

### 问题

#### 1. Fatal Python error: initfsencoding: unable to load the file system codec
    sys.path = ['/Applications/MySQLWorkbench.app/Contents/Resources/libraries'
    , '/Library/Frameworks/Python.framework/Versions/3.7/lib/python37.zip'
    , '/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7'
    , '/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/lib-dynload']

    ModuleNotFoundError: No module named 'encodings'  
    Current thread 0x000000010de87e00 (most recent call first): zsh: abort      

    cd /Applications/MySQLWorkbench.app/Contents/macOS
    ./MySQLWorkbench -verbose

> macOS 老版本把`Python.framework`放在/Library/Frameworks目录中, 而新版本放在
> /System/Library/Frameworks目录中, 但这个新目录中的Python版本为2.7. MySqlWorkbench
> 需要3.7

    brew install python@3.7
    cd /usr/local/Cellar/python@3.7/3.7.9_3/Frameworks
    把Python.framework复制到/Library/Frameworks目录下

#### 2. MySqlWorkbench style
[3.2.5 Fonts and Colors Preferences](https://dev.mysql.com/doc/workbench/en/wb-preferences-fonts-and-colors.html)  
[MySQL Workbench Dark Theme](https://stackoverflow.com/questions/17325408/mysql-workbench-dark-theme)  

    /Applications/MySQLWorkbench.app/Contents/Resources/data/code_editor.xml
    修改颜色 见MySQL Workbench Dark Theme

    defaults write com.oracle.workbench.MySQLWorkbench NSRequiresAquaSystemAppearance -bool yes
    关闭暗模式

## Reference

