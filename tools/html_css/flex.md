---
layout: page
permalink: /tools/html_css/flex
---

Display Flex

见阮一峰[Flexible Box 弹性布局](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)

### 指定为Flex布局

任何一个容器都可以指定为 Flex 布局。

    .box{
      display: flex;
    }

行内元素也可以使用 Flex 布局。

    .box{
      display: inline-flex;
    }

Webkit 内核的浏览器，必须加上-webkit前缀。

    .box{
      display: -webkit-flex; /* Safari */
      display: flex;
    }


### 基本概念
采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子
元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。
主轴的开始位置（与边框的交叉点）叫做main start，结束位置叫做main end；
交叉轴的开始位置叫做cross start，结束位置叫做cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做main size，占据的交叉轴空间叫做cross size。

### 容器的属性

        flex-direction
        flex-wrap
        flex-flow
        justify-content
        align-items
        align-content

### 项目的属性

        order
        flex-grow
        flex-shrink
        flex-basis
        flex
        align-self


