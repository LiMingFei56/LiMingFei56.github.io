---
layout: post
title: C/C++ Debug
categories: lang
tags: [lang]
date: 2022-08-03
---

## C/C++ Debug

### detect memory leaks

#### macOS

  lldb
  leaks 
  export MallocStackLogging=1

##### Sanitizer

> Mac自带的clang中没有包含`Sanitizer`, 需要安装llvm`brew install llvm`

###### AddressSanitizer(ASan): 内存地址越界检查（其实包括了内存泄漏检查）
* LeakSanitizer(LSan): 内存泄漏检查，可以单独使用
  
    export ASAN_OPTIONS=detect_leaks=1


* ThreadSanitizer (TSan): 线程安全检查
* UndefinedBehaviorSanitizer (UBSsan): 未定义行为检查
* MemorySanitizer (MSan): 内存分配检查


    in cmake
    -DCMAKE_BUILD_TYPE=ASAN -DCMAKE_CXX_COMPILER=/usr/local/opt/llvm/bin/clang++
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=[sanitizer_name] [additional_options] [-g] [-OX]")

## Reference
[Mac下C++内存检查指北(Valgrind VS Asan)](https://zhuanlan.zhihu.com/p/508470880)  
[Memory check on macOS 12 Monterey?](https://stackoverflow.com/questions/69792467/memory-check-on-macos-12-monterey)  
[Diagnosing Memory, Thread, and Crash Issues Early](https://developer.apple.com/documentation/xcode/diagnosing-memory-thread-and-crash-issues-early)  
[google/sanitizers](https://github.com/google/sanitizers)  
[Memory error checking in C and C++: Comparing Sanitizers and Valgrind](https://developers.redhat.com/blog/2021/05/05/memory-error-checking-in-c-and-c-comparing-sanitizers-and-valgrind)  
