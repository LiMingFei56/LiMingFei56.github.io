---
layout: page
permalink: /tools/qt/windows
---

## Windows

### 窗口部件的类说明

QObject      - 所有支持Qt对象模型的对象的基类
QPaintDevice - 所有可心绘制的对象的基类
QWidget      - 所有视图类的基类
QMainWindow  - 带有菜单栏和工具栏的主窗口
QDialog      - 是各种对话框的基类
窗口         - 没有父部件，也叫作顶级部件，一般有边框和标题
子部件       - 有父部件

### 窗口类型
QWidget 的构造函数有两个参数来决定窗口类型

parent      - 默认等于0为没有父部件
WindowFlags - 取值WindowType

Qt::Widget               - 默认，可以是独立窗口
Qt::Dialog               - 对话框窗口
Qt::SplashScreen         - 欢迎窗口
Qt::FramelessWindowHint  - 不要边框
Qt::WindowStaysOnTopHint - 停留在所有窗口的上面

### 窗口状态
setWindowState()

Qt::WIndowNoState 默认
Qt::WindowMaximized 最大化
Qt::WindowMinimized 最小化
Qt::WindowFullScreen 全屏
Qt::WindowActive
