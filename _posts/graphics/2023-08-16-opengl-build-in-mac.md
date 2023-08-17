---
layout: post
title: OpenGL build in mac
categories: graphics
tags: [graphics]
date: 2023-08-16
---

## OpenGL build in mac

OpenGL framework path: /System/Library/Frameworks/OpenGL.framework/OpenGL


clang -lc++ -L/opt/homebrew/Cellar/glfw/3.3.8/lib -framework Cocoa -framework IOKit -framework CoreVideo -lglfw -framework CoreFoundation -framework OpenGL src/01-triangles/01-triangles.cpp lib/LoadShaders.cpp lib/gl3w.c -Iinclude -I/opt/homebrew/Cellar/glfw/3.3.8/include

clang -g -lc++ -framework Cocoa -framework IOKit -framework CoreVideo -lglfw -framework CoreFoundation -framework OpenGL helloworld.c -I/opt/homebrew/Cellar/glfw/3.3.8/include -L/opt/homebrew/Cellar/glfw/3.3.8/lib


-lc++: 引入C++标准库


### lib

freeglut: macos glut - OpenGL Utility Toolkit 依赖X11创建窗口, 如XQuartz库
glfw: OpenGL Context Creation


## Reference
