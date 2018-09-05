---
layout: page
permalink: /tools/qt/environment
---

## Environment

### 1. 项目目录说明

    1. main.cpp 项目的入口
    2. *.cpp 项目源文件
    3. *.h 项目头文件
    4. *.ui 设计xml文件
    5. projectname.pro 项目配置文件
    6. projectname.pro.user 项目构建相关信息文件

### 2. projectname.pro

    QT += core gui widgets // 添加module，使用qmake的话core和gui默认导入
    TARGET = HelloWorld1 // 应用名称
    TEMPLATE = app // 使用的模版
    DEFINES += QT_DEPRECATED_WARNINGS // 定义特性，这个是使编译器发出警告
    CONFIG += c++11 // 编译器配置
    SOURCES += main.cpp // 源文件
    HEADERS += helloworld1.h // 头文件
    FORMS += helloworld1.ui // 设计文件
    RC_ICONS = myico.ico // 应用icon

### 3. 编译原理
#### 3.1. 编译UI文件
使用"uic"命令编译hello.ui文件，生成ui_hello.h文件

    uic -o ui_hellodialog.h hellodialog.ui

ui_前缀是规范，里面有Ui_HelloDialog类，会生成Ui命名空间

### 3.2. 生成.pro文件
在项目根目录下，使用qmake -project会生成.pro文件

    greaterThan(QT_MAJOR_VERSION, 4) : QT += widgets // 添加widgets模块，兼容qt4

### 3.3. 生成MakeFile文件
在项目根目录下，使用qmake生成MakeFile文件

### 3.4. 编译
在项目根目录下，使用make生成可执行文件


注：QT的工程目录中不能有中文，否则编译无法通过。
