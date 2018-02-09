---
layout: page
permalink: /program-language/c/environment
---

Environment

### 程序入口

    #include <stdio.h>

    int main(int argc, char **argv){
        return 0;
    }

### 编译器
    
    clang function.c

### 函数库

动态库 - ".so(shared object)",是一个"just-in-time(JIT)"链接，可执行文件小，共享一份库文件(节省空间)
静态库 - ".a(archive)"，通过ar工具来创建和更新，会包含在可执行文件中，运行速度比so快。




