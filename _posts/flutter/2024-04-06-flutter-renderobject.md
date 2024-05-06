---
layout: post
title: Flutter RenderObject
categories: flutter
tags: [flutter]
date: 2024-04-06
---

## Flutter RenderObject

> layout, painting, compositing and hit-testing
> render tree
> Every widget bears an optional direct connection to a specific instance of RenderObject

performLayout
paint
describeSemanticsConfiguration

> widget 充当用户界面的声明性模型, RenderObject 屏幕上表示widget.


### Rendering Process

#### Layout Phase

> 计算自身和子Widget大小

    @override
    void performLayout() {
    	Size size = constraints.biggest;
    	assert(size.width >= 0);
    	assert(size.height >= 0);
    	width = size.width;
    	height = size.height;
    	hasSize = true;
    }

#### Paint Phase

> 绘制不会改变Widget属性, 绘制命令由底层 Skia 图形库执行和捕获.

    @override
    void paint(PaintingContext context, Offset offset) {
      if (_image == null) return;
      context.canvas.drawImage(_image, offset, new Paint());
    }

#### Composite Phase

> 合成阶段是渲染管道的最后一步。  在这里，布局步骤中计算的所有属性和绘制步骤中生成的绘制命令都组合在一起形成图层，这些图层被转换为 GPU 友好的格式，以实现高效绘图。
> 可以处理图层位置或几何形状的变化，而无需完全重新生成图层，从而实现快速高效的渲染过程。

## Reference
+ [Understanding Flutter RenderObject Class: The Core of Flutter Rendering Engine](https://www.dhiwise.com/post/understanding-flutter-renderobject-class-the-core-of-flutter)
