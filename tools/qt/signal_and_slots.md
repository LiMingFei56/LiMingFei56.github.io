---
layout: page
permalink: /tools/qt/signal-and-slots
---

## 信号和槽
信号和槽都是函数，需要把操作事件也就是信号，与自定义槽关联起来，那么就可以事件驱动
调用槽函数.

### 1. 自定义槽

    public slots:
        void showChildDialog();
    Qt4中 slots必须使用；Qt5中 新connect语法可以不用
    
    public slots表明这个槽可以在类外被调用

### 2. 信号和槽关联
在需要使用信号和槽的类中需要使用Q_OBJECT宏，这个宏扩展普通C++功能。

#### 2.1 Qt5 connect
connect() 函数是QObject中的函数，4个参数分别是发射信号的对象、发射的信号、接收信号
的对象和要执行的槽。

#### 2.2 自动关联
自动关联就是将关联函数整合到槽命名中。

    on_showChildButton_clicked()
    on_<发射信号的对象>_<信号>组成

自动关联是在setupUi()中实现的，所以要代码添加控件的话，需要在setupUi()前才行




