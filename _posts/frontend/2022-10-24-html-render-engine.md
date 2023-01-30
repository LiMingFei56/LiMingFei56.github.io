---
layout: post
title: HTML/CSS Render engine
categories: frontend
tags: [frontend]
date: 2022-10-24
---

## HTML/CSS Render engine

### 查看元素边界

    <!-- 控制台运行 -->
    [].forEach.call($$("*"),function(a){
    a.style.outline="1px solid #"+(~~(Math.random()*(1<<24))).toString(16)
    })

### 查看鼠标点击坐标

    element.addEventListener("mousedown", function (e) {
        <!-- let bounds = document.getElementById("graph").getBoundingClientRect(); -->

        let bounds = parent.getBoundingClientRect();
        let x = e.clientX - bounds.left;
        let y = e.clientY - bounds.top;

        console.log(x, y);
    });

    

## Reference
[litehtml](https://github.com/litehtml/litehtml)  
[Ultralight](https://github.com/ultralight-ux/Ultralight)  
[Let's build a browser engine!](https://limpet.net/mbrubeck/2014/08/08/toy-layout-engine-1.html)  
[PBRT-like renderer](https://www.pbrt.org/)  

