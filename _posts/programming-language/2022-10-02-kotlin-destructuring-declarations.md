---
layout: post
title: kotlin destructuring declarations
categories: lang
tags: [lang]
date: 2022-10-02
---

## kotlin destructuring declarations

    val (name, age) = person

被翻译成:

    val name = person.component1()
    val age = person.component2()

    for ((a, b) in collection) { ... }



## Reference
