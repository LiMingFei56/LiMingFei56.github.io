---
layout: page
permalink: /android/build_arr
---

1. apply plugin: 'com.android.application'
	改成 apply plugin: 'com.android.library'

2. 删除android->defaultConfig->applicationId 行


    repositories {
        flatDir {
            dirs 'libs'
        }
    }


    compile(name:"TeamSunAppBasic-freeRelease-1.0",ext:"aar")

