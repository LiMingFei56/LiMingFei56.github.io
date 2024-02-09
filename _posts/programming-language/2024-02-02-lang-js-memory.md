---
layout: post
title: JS Memory Management
categories: lang
tags: [lang]
date: 2024-02-01
---

## JS Memory Management

### Garbage collection

#### Reference-counting garbage collection

> no modern JavaScript engine uses reference-counting for garbage collection anymore.

#### Mark-and-sweep algorithm

#### Configuring an engine's memory model

    node --max-old-space-size=6000 index.js
    node --expose-gc --inspect index.js
    
### Data structures aiding memory management

    WeakMaps and WeakSets
    WeakRefs and FinalizationRegistry


## Reference
+ [Memory management](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_management)
