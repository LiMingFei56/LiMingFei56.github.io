---
layout: post
title: "编译原理"
categories: compute
tags: [compute]
date: 2021-04-19
---

## 编译原理

### 阶段

#### 1. 词法分析阶段

#### 2. 语法分析阶段

#### 3. 语义分析阶段

#### 4. 中间代码生成阶段

#### 5. 代码优化阶段

#### 6. 目标代码生成阶段

#### 7. 符号表管理

#### 8. 出错处理

### 文法和有限自动机

#### 0型文法

#### 1型文法

#### 2型文法

#### 3型文法, 也叫正规式

### 自动机

FSA: Finite state automaton, 有限状态自动机
DFA: Deterministic Finite Automaton, 确定有限自动机, 但不同于不确定的有限自动机，DFA中不会有从同一状态出发的两条边标志有相同的符号
NFA: Non-deterministic Finite Automaton, 不确定有限自动机

状态为一个有向图

1. DFA的一个状态是NFA的一个状态集合。
2. 读了输入a1 a2 … an后，NFA能到达的所有状态：s1, s2, …, sk，则DFA到达状态{s1, s2, …, sk}
3. 把NFA变成DFA 一般使用子集构造法
4. 将DFA化简的方法为合并不可区别状态


### Reference
[编译原理——词法分析](https://blog.csdn.net/wowocandymilk/article/details/86375340)  
[文法和正规式](https://blog.csdn.net/tianyunlinger/article/details/113755949?ivk_sa=1024320u)  
[正规式与正规集](https://blog.csdn.net/chen_zan_yu_/article/details/100846700)  
