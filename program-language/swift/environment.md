---
layout: page
permalink: /program-language/swift/environment
---

Environment

### 程序入口
Code written at global scope is used as the entry point for the program, so you don’t need a main function

    import Foundation

    print("Hello World")

    let argv = Process.arguments  
  
    for arg in argv {
        //打印所有接收到的参数 
    
        print(arg)  
    }

### 程序

    需要swift环境

    swiftc helloworld.swift
    ./helloworld

    swift helloworld.swift
