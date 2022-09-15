---
layout: post
title: Jetpack
categories: android
tags: [android]
date: 2022-08-23
---

## Jetpack

### 集成

1. 添加google仓库

    dependencyResolutionManagement {
        repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
        repositories {
            google()
            jcenter()
        }
    }

2. 添加依赖

    dependencies {
        def lifecycle_version = "2.2.0"

        implementation "androidx.lifecycle:lifecycle-livedata-ktx:$lifecycle_version"
        implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:$lifecycle_version"
        ...
    }

Android Architecture Component, AAC

### Jetpack 库

> Jetpack 库可以单独使用，也可以组合使用，以满足应用的不同需求。

 


## Reference
[Android Jetpack](https://developer.android.com/jetpack)  
[Google's Maven Repository](https://maven.google.com/web/index.html)  
[按类型探索 Jetpack 库](https://developer.android.google.cn/jetpack/androidx/explorer)  
