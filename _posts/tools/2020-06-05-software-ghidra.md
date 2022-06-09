---
layout: post
title: "Tools Ghidra"
categories: tools
tags: [tools]
date: 2020-06-05
---

## Tools Ghidra

> IDA Pro 替代品, 美国国家安全局出的逆向工程工具.

管网: https://ghidra-sre.org/ (需要翻墙)
源码: https://github.com/NationalSecurityAgency/ghidra
      https://gitee.com/mirrors/Ghidra/blob/master/build.gradle
安装: https://github.com/NationalSecurityAgency/ghidra/blob/master/GhidraDocs/InstallationGuide.html

### 编译源码

* [Installing Ghidra - Take 1](https://re-ffs.com/install-ghidra/)

Install openjdk for java 11, left as exercise for the reader

    #!/bin/bash

    curl -s "https://get.sdkman.io" | bash
    source ~/.sdkman/bin/sdkman-init.sh
    sdk install gradle 5.0
    git clone https://github.com/NationalSecurityAgency/ghidra.git
    cd ghidra
    git checkout 633049d83bf6b21d72fde747cf79ff524b8044c1
    git checkout -b re-ffs-0.0.1
    gradle --init-script gradle/support/fetchDependencies.gradle init
    gradle buildGhidra
    gradle eclipse
    gradle buildNatives_linux64
    gradle sleighCompile
    gradle eclipse -PeclipsePDE
    gradle prepDev
    cd
    unzip ghidra/build/dist/ghidra_9.1_DEV_*_linux64.zip

