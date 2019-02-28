---
layout: page
permalink: ./technology-home/platform/flutter/data-backend/
---

## Data & Backend

### 1. State management
reactive app的状态管理

广意上应用state表示为应用在运行中保存在内存中的所有内容，但是有些是framework管理的，需要开发人员管理
分为两种：`短暂状态`和`应用状态`

#### 1.1. 短暂状态
也叫ui状态和本地状态，包含在单个widget的状态。Widget树上的其他部分不会访问这些状态，不会序列化它，不会
以复杂的方式改变。

不用使用State manager来管理短暂状态，不用但是应用重启状态重置。

#### 1.2. 应用状态
也叫共享状态，状态需要在不同的部分共享，需要在不同的user sessions中共享。

#### 1.3. 简单的管理
使用State setState()、ScopedModel、Redux、Rx、hooks

Widget是通过父Widget的Build()方法构建的，所以Widget使用的状态需要放在父Widget或者更高的级别上。

flutter有机制使得可以对后代提供数据和服务，通过`InheritedWidget`, `InheritedNotifier`, `InheritedModel`等。但是
这个机制很低层。