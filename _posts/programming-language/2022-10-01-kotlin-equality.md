---
layout: post
title: kotlin equality
categories: lang
tags: [lang]
date: 2022-10-01
---

## kotlin equality

In Kotlin there are two types of equality:
    * Structural equality (== - a check for equals())
    * Referential equality (=== - two references point to the same object)

> Structural equality

    a == b -> a?.equals(b) ?: (b === null)

> Floating-point numbers equality

    IEEE 754 -0.0 != 0.0

## Reference
