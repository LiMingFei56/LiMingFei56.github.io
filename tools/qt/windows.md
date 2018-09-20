---
layout: page
permalink: /tools/qt/windows
---

## Windows

### 1. 窗口部件的类说明

QObject      - 所有支持Qt对象模型的对象的基类
QPaintDevice - 所有可心绘制的对象的基类
QWidget      - 所有视图类的基类
QMainWindow  - 带有菜单栏和工具栏的主窗口
QDialog      - 是各种对话框的基类
窗口         - 没有父部件，也叫作顶级部件，一般有边框和标题
子部件       - 有父部件

### 2. 窗口类型
QWidget 的构造函数有两个参数来决定窗口类型

parent      - 默认等于0为没有父部件
WindowFlags - 取值WindowType

Qt::Widget               - 默认，可以是独立窗口
Qt::Dialog               - 对话框窗口
Qt::SplashScreen         - 欢迎窗口
Qt::FramelessWindowHint  - 不要边框
Qt::WindowStaysOnTopHint - 停留在所有窗口的上面

### 3. 窗口状态
setWindowState()

Qt::WIndowNoState 默认
Qt::WindowMaximized 最大化
Qt::WindowMinimized 最小化
Qt::WindowFullScreen 全屏
Qt::WindowActive

### 4. 窗口大小，位置计算
窗口默认大小为子部件的大小，而位置是不确定的

有两套函数来确定大小与位置，分为包含边框和不包含边框
|--------|-------------------------|-----------------------------------------------|
| 类型   |  包含边框               |  不包含边框                                   |
| QPoint |  pos                    |  geometry                                     |
| int    |  x                      |  geometry().y                                 |
| int    |  y                      |  geometry().x                                 |
| int    |  frameGeometry().width  |  geometry().width and width                   |
| int    |  frameGeometry().height |  geometry().heigh and height                  |

### 5. 对话框
模态对话框 - 在没有关闭当前对话框之前，不能再与同一个应用程序的其他窗口进行交互。
            QDialog.exec() 和 QDialog.setModal(true) QDialog.show()开启模态对话框
            但是两个的效果不一样，一个是后续窗口没有出现，show出现了

setWindowModality() - 设置模态对话框要阻塞窗口，那么show的效果跟exec一样了
    Qt::NonModal  -  不阻塞
    Qt::WindowModal - 阻塞同血源的窗口（父和子）
    Qt::ApplicationModal - 当前应用的所有窗口


### 6. 标准对话框
QColorDialog
QFileDialog
QFontDialog
QInputDialog
QMessageBox
QProgressDialog
QErrorMessage
QWizardPage

### 7. QFrame类族
#### 7.1 QFrame
带有边框的部件的基类，QFrame类的主要功能就是用来实现不两只的边框效果，由Shape和Shadow
来实现。

setLineWidth  - 边框边界线的宽度
setMidLineWidth - 为了形成#d效果，在边框中插入另一条线的宽度
setFrameShape - 设置边框形状
setFrameShadow - 设置边框阴影

#### 7.2 QLabel
显示文本和图片
font 设置字体
wordWrap 设置自动换行
QFontMetrice 设置文本过长的处理方法
scaledContents 缩放标签中的内容
setPixmap 设置图片
setMovie 设置gif动态图片


#### 7.3 QLCDNumber
让数码字符显示类似液晶数字一样的效果

#### 7.4 QStackedWidget
部件栈，可以包含多个部件，但是一次只显示一个。一般需要配合QComboBox或者QListWidget使用，
来选择它的各个页面。

#### 7.5 QToolBox
提供一列层叠窗口部件，

### 8. Button类族
QAbstractButton 是按钮部件的抽象基类。

#### 8.1. QPushButton
标准按钮， 

#### 8.2. QCheckBox、QRadioButton和QGroupBox
多选和单选，都需要QGroupBox中管理

### 9. QLineEdit
行编辑器

#### 9.1. 显示模式
Normal - 正常模式
NoEcho - 不显示任何输入
Password - 显示密码样式
PasswordEchoOnEdit - 输入时正常显示，输入完后显示密码样式

#### 9.2. 输入掩码
inputMask 限制输入的内容

#### 9.3. 输入验证
QValidator 验证输入
setValidator
QRegExp 正则验证

#### 9.4. 自动补全
QCompleter

### 10. QAbstractSpinBox
提供一个数值设定框和一个行编辑器来显示设定值。

#### 10.1. QDateTimeEdit
可以编辑日期和时间的部件

setDateTime  设置当前时间
setDisplayFormat 设置显示格式


#### 10.2. QSpinBox 和 QDoubleSpinBox
一个用来设置整数，一个设置浮点

suffix  -  后缀
prefix  -  前缀
minimum -  最小
maximum -  最大
singleStep - 单步
value   -  当前显示的值 
decimals-  小数位数

### 11. QAbstractSlider
可以滑动的部件，有个整数值，可以定位到一个整数区间的任意值 

QScrollBar - 一般用于QScrollArea来实现滚动区域
QSlider    - 音量控制或进度
QDial      - 刻度表盘部件
