---
layout: page
permalink: ./technology-home/platform/flutter/package/
---

## Package

![Pub](https://www.dartlang.org/tools/pub/dependencies#caret-syntax)

### 使用包
* `pubspec.yaml`添加依赖
* flutter packages get(upgrade) 下载更新包
* import
* restart app

### 管理包依赖

#### 1. 包版本
any - 允许所有版本
1.2.3 - 具体版本
(>= > <= <)1.2.3 - 比较
('>1 <2')1.2.3 - 范围
^1.2.3 - 范围，保证向后兼容

#### 2. 对未发布的包依赖

    dependencies:
    plugin1:
        path: ../plugin1/

    dependencies:
    package1:
        git:
        url: git://github.com/flutter/packages.git
        path: packages/package1

#### 3. 开发包



### State Manager
* [scoped_model](./scoped-model)

### Serializtion
* [convert](./convert)