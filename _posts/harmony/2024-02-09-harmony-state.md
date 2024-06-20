---
layout: post
title: Harmony 状态管理
categories: harmony 
tags: [harmony]  
date: 2024-02-09
---

## Harmony 状态管理

### 状态变量分类

根据状态变量的影响范围，将所有的装饰器可以大致分为：

* 管理组件拥有状态的装饰器：组件级别的状态管理，可以观察组件内变化，和不同组件层级的变化，但需要唯一观察同一个组件树上，即同一个页面内。
* 管理应用拥有状态的装饰器：应用级别的状态管理，可以观察不同页面，甚至不同UIAbility的状态变化，是应用内全局的状态管理。

从数据的传递形式和同步类型层面看，装饰器也可分为：

* 只读的单向传递；
* 可变更的双向传递。

![Image2](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20231227152827.25552042316398131233455234147205:50001231000000:2800:78B3926FE0F1A9B11661D29DFDAB768726B6ACF3F656BE668B7BA7F1ECC32A29.png?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true?needInitFileName=true)

### 管理组件拥有的状态

* @State：@State装饰的变量拥有其所属组件的状态，可以作为其子组件单向和双向同步的数据源。当其数值改变时，会引起相关组件的渲染刷新。
* @Prop：@Prop装饰的变量可以和父组件建立单向同步关系，@Prop装饰的变量是可变的，但修改不会同步回父组件。
* @Link：@Link装饰的变量和父组件构建双向同步关系的状态变量，父组件会接受来自@Link装饰的变量的修改的同步，父组件的更新也会同步给@Link装饰的变量。
* @Provide/@Consume：@Provide/@Consume装饰的变量用于跨组件层级（多层组件）同步状态变量，可以不需要通过参数命名机制传递，通过alias（别名）或者属性名绑定。
* @Observed：@Observed装饰class，需要观察多层嵌套场景的class需要被@Observed装饰。单独使用@Observed没有任何作用，需要和@ObjectLink、@Prop连用。
* @ObjectLink：@ObjectLink装饰的变量接收@Observed装饰的class的实例，应用于观察多层嵌套场景，和父组件的数据源构建双向同步。

### 管理应用拥有的状态概述

* LocalStorage：页面级UI状态存储，通常用于UIAbility内、页面间的状态共享。
* AppStorage：特殊的单例LocalStorage对象，由UI框架在应用程序启动时创建，为应用程序UI状态属性提供中央存储；
* PersistentStorage：持久化存储UI状态，通常和AppStorage配合使用，选择AppStorage存储的数据写入磁盘，以确保这些属性在应用程序重新启动时的值与应用程序关闭时的值相同；
* Environment：应用程序运行的设备的环境参数，环境参数会同步到AppStorage中，可以和AppStorage搭配使用。

### 其他状态管理功能

@Watch用于监听状态变量的变化。

$$运算符：给内置组件提供TS变量的引用，使得TS变量和内置组件的内部状态保持同步。

## Reference
+ [状态管理概述](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-state-management-overview-0000001524537145-V3)
