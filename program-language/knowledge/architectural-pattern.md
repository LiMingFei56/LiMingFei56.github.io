---
layput: page
permalink: /program-language/knowledge/architectural-pattern
---

Architectural Pattern

### MVVM
多了一些 wx:if 这样的属性以及 {{ }} 这样的表达式 在网页的一般开发流程中，我们通常会通过
JS 操作 DOM (对应 HTML 的描述产生的树)，以引起界面的一些变化响应用户的行为。例如，用户
点击某个按钮的时候，JS 会记录一些状态到 JS 变量里边，同时通过 DOM API 操控 DOM 的属性或
者行为，进而引起界面一些变化。当项目越来越大的时候，你的代码会充斥着非常多的界面交互逻
辑和程序的各种状态变量，显然这不是一个很好的开发模式，因此就有了 MVVM 的开发模式(例如
React, Vue)，提倡把渲染和逻辑分离。简单来说就是不要再让 JS 直接操控 DOM，JS只需要管理状
态即可，然后再通过一种模板语法来描述状态和界面结构的关系即可。 小程序的框架也是用到了这
个思路，如果你需要把一个 Hello World 的字符串显示在界面上
