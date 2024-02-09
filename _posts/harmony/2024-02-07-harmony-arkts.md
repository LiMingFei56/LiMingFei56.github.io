---
layout: post
title: Harmony ArkTS
categories: harmony
tags: [harmony]
date: 2024-02-07
---

## Harmony ArkTS

> ArkTS是在TypeScript上扩展. UI是声明式, 设置属性和事件链式调用.

### Decorator

* @Component 自定义组件, ArkTS卡片
* @Entry     入口组件, ArkTS卡片, 一个页面有且只有一个
* @State     状态变量
* @Builder   @Component轻量实现
* @BuilderParam @BuilderParam用来装饰指向@Builder方法的变量, 为自定义组件增加特定的功能. 类似slot
* @Styles    @Styles装饰器可以将多条样式设置提炼成一个方法
* @Extend    @Extend，用于扩展原生组件样式

#### 多态样式

stateStyles是属性方法，可以根据UI内部状态来设置样式，类似于css伪类，但语法不同。ArkUI提供以下四种状态：

focused：获焦态。
normal：正常态。
pressed：按压态。
disabled：不可用态。


### Event

> onClick有时需要调用bind, 确保this是当前UI组件. 箭头函数不需要

### Component

* struct：自定义组件基于struct实现，struct + 自定义组件名 + {...}的组合构成自定义组件，不能有继承关系。对于struct的实例化，可以省略new。
* @Component：@Component装饰器仅能装饰struct关键字声明的数据结构。struct被@Component装饰后具备组件化的能力，需要实现build方法描述UI，一个struct只能被一个@Component装饰。
* build()函数：build()函数用于定义自定义组件的声明式UI描述，自定义组件必须定义build()函数。
* @Entry：@Entry装饰的自定义组件将作为UI页面的入口。在单个UI页面中，最多可以使用@Entry装饰一个自定义组件。@Entry可以接受一个可选的LocalStorage的参数。

#### 页面和自定义组件生命周期

页面生命周期:
* onPageShow：页面每次显示时触发一次，包括路由过程、应用进入前台等场景。
* onPageHide：页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景。
* onBackPress：当用户点击返回按钮时触发。

组合生命周期:
* aboutToAppear：组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
* aboutToDisappear：在自定义组件析构销毁之前执行。不允许在aboutToDisappear函数中改变状态变量，特别是@Link变量的修改可能会导致应用程序行为不稳定。

![Image1](https://alliance-communityfile-drcn.dbankcdn.com/FileServer/getFile/cmtyPub/011/111/111/0000000000011111111.20240115115417.19084898994421050948770894591938:50001231000000:2800:A35F79D99F20173F0309774937C4BCBD554915F61D2B6D5A985BF64B529E6178.png?needInitFileName=true?needInitFileName=true)

#### 自定义组件的创建和渲染流程

1. 自定义组件的创建：自定义组件的实例由ArkUI框架创建。
2. 初始化自定义组件的成员变量：通过本地默认值或者构造方法传递参数来初始化自定义组件的成员变量，初始化顺序为成员变量的定义顺序。
3. 如果开发者定义了aboutToAppear，则执行aboutToAppear方法。
4. 在首次渲染的时候，执行build方法渲染系统组件，如果子组件为自定义组件，则创建自定义组件的实例。在执行build()函数的过程中，框架会观察每个状态变量的读取状态，将保存两个map：
 a. 状态变量 -> UI组件（包括ForEach和if）。
 b. UI组件 -> 此组件的更新函数，即一个lambda方法，作为build()函数的子集，创建对应的UI组件并执行其属性方法，示意如下。

#### 自定义组件重新渲染

当事件句柄被触发（比如设置了点击事件，即触发点击事件）改变了状态变量时，或者LocalStorage / AppStorage中的属性更改，并导致绑定的状态变量更改其值时：

1. 框架观察到了变化，将启动重新渲染。
2. 根据框架持有的两个map（自定义组件的创建和渲染流程中第4步），框架可以知道该状态变量管理了哪些UI组件，以及这些UI组件对应的更新函数。执行这些UI组件的更新函数，实现最小化更新。

#### 自定义组件的删除

如果if组件的分支改变，或者ForEach循环渲染中数组的个数改变，组件将被删除：

1. 在删除组件之前，将调用其aboutToDisappear生命周期函数，标记着该节点将要被销毁。ArkUI的节点删除机制是：后端节点直接从组件树上摘下，后端节点被销毁，对前端节点解引用，前端节点已经没有引用时，将被JS虚拟机垃圾回收。
2. 自定义组件和它的变量将被删除，如果其有同步的变量，比如@Link、@Prop、@StorageLink，将从同步源上取消注册。

不建议在生命周期aboutToDisappear内使用async await，如果在生命周期的aboutToDisappear使用异步操作（Promise或者回调方法），自定义组件将被保留在Promise的闭包中，直到回调方法被执行完，这个行为阻止了自定义组件的垃圾回收。

    // Index.ets
    import router from '@ohos.router';

    @Entry
    @Component
    struct MyComponent {
      @State showChild: boolean = true;

      // 只有被@Entry装饰的组件才可以调用页面的生命周期
      onPageShow() {
        console.info('Index onPageShow');
      }
      // 只有被@Entry装饰的组件才可以调用页面的生命周期
      onPageHide() {
        console.info('Index onPageHide');
      }

      // 只有被@Entry装饰的组件才可以调用页面的生命周期
      onBackPress() {
        console.info('Index onBackPress');
      }

      // 组件生命周期
      aboutToAppear() {
        console.info('MyComponent aboutToAppear');
      }

      // 组件生命周期
      aboutToDisappear() {
        console.info('MyComponent aboutToDisappear');
      }

      build() {
        Column() {
          // this.showChild为true，创建Child子组件，执行Child aboutToAppear
          if (this.showChild) {
            Child()
          }
          // this.showChild为false，删除Child子组件，执行Child aboutToDisappear
          Button('delete Child').onClick(() => {
            this.showChild = false;
          })
          // push到Page2页面，执行onPageHide
          Button('push to next page')
            .onClick(() => {
              router.pushUrl({ url: 'pages/Page2' });
            })
        }

      }
    }

    @Component
    struct Child {
      @State title: string = 'Hello World';
      // 组件生命周期
      aboutToDisappear() {
        console.info('[lifeCycle] Child aboutToDisappear')
      }
      // 组件生命周期
      aboutToAppear() {
        console.info('[lifeCycle] Child aboutToAppear')
      }

      build() {
        Text(this.title).fontSize(50).onClick(() => {
          this.title = 'Hello ArkUI';
        })
      }
    }

以上示例中，Index页面包含两个自定义组件，一个是被@Entry装饰的MyComponent，也是页面的入口组件，即页面的根节点；一个是Child，是MyComponent的子组件。只有@Entry装饰的节点才可以使页面级别的生命周期方法生效，所以MyComponent中声明了当前Index页面的页面生命周期函数。MyComponent和其子组件Child也同时也声明了组件的生命周期函数。

应用冷启动的初始化流程为：MyComponent aboutToAppear --> MyComponent build --> Child aboutToAppear --> Child build --> Child build执行完毕 --> MyComponent build执行完毕 --> Index onPageShow。
点击“delete Child”，if绑定的this.showChild变成false，删除Child组件，会执行Child aboutToDisappear方法。
点击“push to next page”，调用router.pushUrl接口，跳转到另外一个页面，当前Index页面隐藏，执行页面生命周期Index onPageHide。此处调用的是router.pushUrl接口，Index页面被隐藏，并没有销毁，所以只调用onPageHide。跳转到新页面后，执行初始化新页面的生命周期的流程。
如果调用的是router.replaceUrl，则当前Index页面被销毁，执行的生命周期流程将变为：Index onPageHide --> MyComponent aboutToDisappear --> Child aboutToDisappear。上文已经提到，组件的销毁是从组件树上直接摘下子树，所以先调用父组件的aboutToDisappear，再调用子组件的aboutToDisappear，然后执行初始化新页面的生命周期流程。
点击返回按钮，触发页面生命周期Index onBackPress，且触发返回一个页面后会导致当前Index页面被销毁。
最小化应用或者应用进入后台，触发Index onPageHide。当前Index页面没有被销毁，所以并不会执行组件的aboutToDisappear。应用回到前台，执行Index onPageShow。
退出应用，执行Index onPageHide --> MyComponent aboutToDisappear --> Child aboutToDisappear。

### 参数传递

> `$$`

> 默认为值传递, 当状态变量为值传递, 并且改变后, 不会触发UI更新, 需要使用引用传递

## Reference
+ [ArkTS](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/arkts-basics-0000001454809260-V2)
