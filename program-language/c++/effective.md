---
layout: page
permalink: /program-language/c++/effective
---

Effective

### Dynamic Distribution
使用new关键字在堆中动态分配内存，如果分配失败，以前会返回空指针，现在将产生std:bad_alloc
异常。

定位new运算符 - 可以指定需要使用的内存位置。placement
