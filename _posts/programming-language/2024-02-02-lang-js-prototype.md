---
layout: post
title: JS Prototype
categories: lang
tags: [lang]
date: 2024-02-01
---

## JS Prototype

> JS 查找属性会依次查看原型, 直到找到或者原型为null为止

    # 指定someObject原型
    someObject.[[Prototype]]

    # 读取及设置原型
    Object.getPrototypeOf()
    Object.setPrototypeOf()
    obj.__proto__   # 非标准
    __proto__ syntax

### Prototype setter

> A property definition of the form __proto__: value or "__proto__": value does not create a property with the name __proto__. Instead, if the provided value is an object or null, it points the [[Prototype]] of the created object to that value. (If the value is not an object or null, the object is not changed.)

> Note that the __proto__ key is standardized syntax, in contrast to the non-standard and non-performant Object.prototype.__proto__ accessors. It sets the [[Prototype]] during object creation, similar to Object.create — instead of mutating the prototype chain.


## Reference
+ [Inheritance and the prototype chain](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
