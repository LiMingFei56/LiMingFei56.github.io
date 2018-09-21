---
layout: page
permalink: /tools/qt/layout-manager
---

## 布局管理
QLayout 布局管理，QWidget通过setLayout()来设置。

1. 定位子部件
2. 感知窗口默认大小
3. 感知窗口最小大小
4. 窗口大小变化时进行处理
5. 当内容改变时自动更新

QLayoutItem类提供一个供QLayout操作的抽象项目

QBoxLayout 基本布局管理器
QGridLayout 栅格布局管理器
QFormLayout 窗体布局管理器
QStackedLayout 栈布局管理器

layoutSizeConstraint: 设置窗口大小，只对顶级窗口有效。

### 1. QBoxLayout
在水平方向或者垂直方向排列

    QHBoxLayout *layout = new QHBoxLayout;
    layout->addWidget(ui->fontComboxBox);
    layout->addWidget(ui->textEdit);
    layout->setSpacing(50);
    layout->setContentsMargins(0, 0, 50, 100);

    setLayout(layout);


### 2. QGridLayout
把空间分隔成一些行和列

    QGridLayout *layout = new QGridLayout;
    layout->addWidget(ui->fontComboBox, 0, 0, 1, 2);
    layout->addWidget(ui->pushButton, 0, 2, 1, 1);
    layout->addWidget(ui->textEdit, 1, 0, 1, 3);

    setLayout(layout);

### 3. QFormLayout
表单的输入部件, 左边是一些标签， 右边是一些输入部件

addRow函数来添加Widget

layoutFieldGrowthPolicy: 指定部件的大小变化方式
layoutRowWrapPolicy: 设置是否换行，如果需要换行，则将输入部件放到相应的标签下面
layoutLabelAlignment: 设置标签的对其方式，分为水平方向和垂直方向
layoutFormAlignment: 设置部件在表单中的对齐方式

### 4. 设置部件大小
sizeHint: 大小提示，保存部件的建议大小
minimumSizeHint: 最小大小提示，保存部件的最小大小

如果setMinimumSize()后，那么minimumSizeHint就无效了

大小策略: sizePolicy，跟sizeHint的值相关

    *Fixed: 无法伸缩
    *Minimum: 最小值 ，可伸缩
    *Maximum: 最大值 , 可压缩
    *Preferred: 最佳大小， 可以伸缩
    *Expanding: 合适大小， 可伸缩，推荐拉伸
    *MinimumExpanding: 最小的值，倾向拉伸
    *Ignored: 忽略，可伸缩

### 5. 伸缩因子
stretch factor, 设置部件间的比例。

### 6. 可扩展窗口
使用hide(), 或者setVisible(false)函数来隐藏部件

### 7. 分裂器QSplitter
子部件可以随Qsplitter大小而改变，是继承QFrame类

### 8. 设置键盘Tab键，改变焦点到下一个
setTabOrder(); 函数


