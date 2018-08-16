---
layout: page
permalink: /ios/worklog/view/view-scrool
---

## UIScrollView

UIScrollView为了正确的工作，需要确定contentSize的大小，然而内容大小一般不能确定，这
个时候需要设置约束，让UIScrollView来计算出contentSize的大小，也就是自适应大小。

contentSize需要确定宽和高

宽可以使用约束设置成UIScrollView的宽度，也可以比UIScrollView宽，那么就可以横向滑动

高的话需要让各个view设置好margin top 和 height ，并且view需要有上下级关系，最后一个
view需要设置margin bottom。  这样从下到下就可以算出整体的contentHeight


