---
layout: post
title: Android Source Code
categories: aosp
tags: [aosp]
date: 2022-09-23 
---

## Android Open Source Project

[OHA OPEN HANDSET ALLIANCE 开放手持联盟](https://baike.baidu.com/item/%E5%BC%80%E6%94%BE%E6%89%8B%E6%8C%81%E8%AE%BE%E5%A4%87%E8%81%94%E7%9B%9F/6082114?fr=aladdin)  

> 源代码可以用于任何合法用途, 但要加入Android生态圈提供设备, 那么需要加入Android兼容性计划.
> Android编译环境推荐 ubuntu x86
> macos m1 不推荐

### Android Software Management

#### AOSP 代码管理

1 在任何特定时刻，Android 平台都有一个当前最新版本。该版本通常作为树中的一个分支。
2 设备制造商和贡献者会以当前最新版本为基础来修复错误、发布新设备、试验新功能等。
3 与此同时，Google 会根据产品的需求和目标，在内部开发下一版 Android 平台和框架。我们会与设备合作伙伴就旗舰设备展开合作来开发下一个 Android 版本，该旗舰设备的规格旨在推动 Android 朝着我们认为它应该选择的方向发展。
4 当第 n+1 版准备就绪时，它就会发布到公开源代码树，成为新的最新版本。

#### 术语和注意事项

* 一个版本对应一个正式版 Android 平台（如 Android 1.5 或 Android 8.1）。平台的版本对应于 AndroidManifest.xml 文件的 SdkVersion 字段中的版本，并且在源代码树中的 frameworks/base/api 内定义。
* 上游项目是指 Android 堆栈从中提取代码的开源项目。除了 Linux 内核和 WebKit 等项目以外，我们会继续引入一些半自主性 Android 项目（如 ART、Android SDK 工具、Bionic）作为上游项目进行开发。一般情况下，这些项目完全是在公开树中开发的。对于某些上游项目，开发者直接为上游项目做出贡献。有关详情，请参阅上游项目。在这两种情况下，快照会定期纳入版本中。
* 在任何时候，版本代码流水线（可能由 Git 中的多个分支组成）都被视为给定 Android 平台版本的唯一规范源代码。OEM 和开发设备的其他组织应该仅从版本分支中提取源代码。
* 建立实验性代码流水线是为了收集社区贡献的更改，从而在保持稳定性的基础上反复进行改进。
* 被认定为稳定的更改最终会提取到版本分支中。这仅适用于 bug 修复、应用改进和不影响平台 API 的其他更改。
* 在必要时，更改将从上游项目（包括 Android 上游项目）提取到版本分支中。
* 第 n+1 版（即框架和平台 API 的下一个重大版本）由 Google 在内部开发而成。有关详情，请参阅不公开代码流水线。
* 在必要时，更改将从上游、版本和实验性分支提取到 Google 的不公开分支。
* 在下一版本的平台 API 实现稳定并经过全面测试后，Google 会定型下一个平台版本的发布版本（特别是新的 SdkVersion）。这个版本将对应于作为公开版本分支的内部代码流水线和新的当前平台代码流水线。
* 当某个新的平台版本定型时，Google 会同时创建相应的实验性代码流水线。

### [代号、标记和 build 号](https://source.android.com/docs/setup/about/build-numbers)

Android13   13    API      级别  33
Android12L  12    API      级别  32
Android12   12    API      级别  31
Android11   11    API      级别  30
Android10   10    API      级别  29
Pie         9     API      级别  28
Oreo        8.1.0 API      级别  27
Oreo        8.0.0 API      级别  26
Nougat      7.1   API      级别  25
Nougat      7.0   API      级别  24
Marshmallow 6.0   API      级别  23
Lollipop    5.1   API      级别  22
Lollipop    5.0   API      级别  21
KitKat      4.4   -        4.4.4 API     级别  19
Jelly       Bean  4.3.x    API   级别    18
Jelly       Bean  4.2.x    API   级别    17
Jelly       Bean  4.1.x    API   级别    16
Ice         Cream Sandwich 4.0.3 -       4.0.4 API    级别 15，NDK 8
Ice         Cream Sandwich 4.0.1 -       4.0.2 API    级别 14，NDK 7
Honeycomb   3.2.x API      级别  13
Honeycomb   3.1   API      级别  12，NDK 6
Honeycomb   3.0   API      级别  11
Gingerbread 2.3.3 -        2.3.7 API     级别  10
Gingerbread 2.3   -        2.3.2 API     级别  9，NDK 5
Froyo       2.2.x API      级别  8，NDK  4
Eclair      2.1   API      级别  7，NDK  3
Eclair      2.0.1 API      级别  6
Eclair      2.0   API      级别  5
Donut       1.6   API      级别  4，NDK  2
Cupcake     1.5   API      级别  3，NDK  1
（无代号）  1.1   API      级别  2
（无代号）  1.0   API      级别  1

### 配置环境

> 推荐ubuntu14.04系统, 72核心64G内存(全编译40分钟, 增量几分钟)
> 如果基于AOSP master 开发, 推荐使用ubuntu18.04
> 下面使用ubuntu18.04

    sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
    apt-get install git gnupg flex bison gperf build-essential zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386  libgl1-mesa-dev g++-multilib tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386 dpkg-dev
    apt-get install libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-dev g++-multilib
    apt-get install -y git flex bison gperf build-essential libncurses5-dev:i386      
    apt-get install tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386   
    apt-get install git-core gnupg flex bison gperf build-essential                   
    apt-get install zip curl zlib1g-dev gcc-multilib g++-multilib                     
    apt-get install libc6-dev-i386                                                    
    apt-get install lib32ncurses5-dev x11proto-core-dev libx11-dev                    
    apt-get install libgl1-mesa-dev libxml2-utils xsltproc unzip m4                   
    apt-get install lib32z-dev ccache                                                 
    apt-get install libssl-dev                                                          
    apt-get install ccache

    sudo apt-get install sysstat

    // 默认情况下，每次构建的输出都会存储在相应源代码树的 out/ 子目录下, 可以设置输出目录
    export OUT_DIR=out_mytarget

    // 安装jdk
    sudo apt install openjdk-8*  // openjdk

    // 14.04
    sudo apt-add-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer

    // 18.04 https://www.liquidweb.com/kb/install-oracle-java-ubuntu-18-04/
    // 18.04 https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html
    // 18.04 jdk 6 https://www.oracle.com/java/technologies/downloads/archive/
    bin文件加执行权限, 用`.`执行

    4.4.4 需要make3.82 oracle-jdk6

    // 安装repo
    sudo apt-get update
    sudo apt-get install repo // 不实用, 版本太老

    export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
    curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
    gpg --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
    gpg --keyserver keyserver.ubuntu.com --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
    curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo

    // 修改repo
    #!/usr/bin/env python => #!/usr/bin/env python3

    // 设置编译环境
    source ./build/envsetup.sh
    . ./build/envsetup.sh

    // 编译 android 7.0 前使用gmake, Android 层面变得缓慢、容易出错、无法扩展且难以测试
    make -j# // 编译整个系统
    m mm mmm mma // make的封装, 编译模块

    // 编译 android 7.0 及以后 使用Soong


> Andorid 8.0 后可以使用android-llvm 和 NDK编译, 之前使用GCC 4.9

### 支持旧版本

#### 构建最近的旧版本 Android 版本 8.0（Oreo 或 O）– 5.0（Lollipop 或 L）, 使用Dockerfile

The Dockerfile in this directory sets up an Ubuntu Trusty image ready to build a variety of Android branches (>= Lollipop). It‘s particulary useful to build older branches that required 14.04 if you’ve upgraded to something newer.

First, build the image:

    # Copy your host gitconfig, or create a stripped down version
    $ cp ~/.gitconfig gitconfig
    $ docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-trusty .

Then you can start up new instances with:

    $ docker run -it --rm -v $ANDROID_BUILD_TOP:/src android-build-trusty
    > cd /src; source build/envsetup.sh
    > lunch aosp_arm-eng
    > m -j50

#### 构建真正的旧版本（<= 4.4 KitKat）

    高于Android 4.1.x (Jelly Bean) 使用 GNU make (gmake) 3.82 
    Android 4.0.x（冰淇淋三明治）及更低版本 使用 GNU make (gmake) 3.81(3.82不能构建)

    3.82: http://ftp.gnu.org/gnu/make/make-3.82.tar.bz2
    3.81: http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2

编译源码:

    ./configure
    sh build.sh

问题解决:

1. undefined reference to `__alloca'

    // 修改glob.c 
    # if _GNU_GLOB_INTERFACE_VERSION == GLOB_INTERFACE_VERSION
    to
    # if _GNU_GLOB_INTERFACE_VERSION >= GLOB_INTERFACE_VERSION

### 使用指定分支

    repo init --depth=1 下载时只下载最近版本的代码，只保留最近的commit版本
    repo init android-4.4.4_r1
    repo sync -c -j8
    repo sync -c -f --no-tags --no-clone-bundle -j`nproc`

    // 回滚
    repo sync -d
    repo forall -c 'git reset --hard'    # Remove all working directory (and staged) changes.
    repo forall -c 'git clean -f -d'     # Clean untracked files

## 问题

### dalvik/CleanSpec.mk:47: *** missing separator.  Stop
    
    Please execute make operation in the new shell window, not in the same shell after configuring the model.

### Gun Make Segmentation fault (core dumped)

[GNU make 3.82 run time error on Ubuntu-20.04: Segmentation fault (core dumped)](https://stackoverflow.com/questions/73434446/gnu-make-3-82-run-time-error-on-ubuntu-20-04-segmentation-fault-core-dumped)  
[sailfishos](https://github.com/sailfishos/make)  

    gnu: make: Fix compatibility with glibc 2.27

    /* Similarly for lstat.  */ #if !defined(lstat) && !defined(WINDOWS32) || defined(VMS) # ifndef VMS
    #  ifndef HAVE_SYS_STAT_H
    int lstat (const char *path, struct stat *sbuf);
    #  endif
    # else
        /* We are done with the fake lstat.  Go back to the real lstat */
    #   ifdef lstat
    #     undef lstat
    #   endif
    # endif
    # define local_lstat lstat
    #elif defined(WINDOWS32)
    /* Windows doesn't support lstat().  */
    # define local_lstat local_stat
    #else
    static int
    local_lstat (const char *path, struct stat *buf)
    {
      int e;
      EINTRLOOP (e, lstat (path, buf));
      return e;
    }
    #endif

    void
    dir_setup_glob (glob_t *gl)
    {
      gl->gl_opendir = open_dirstream;
      gl->gl_readdir = read_dirstream;
      gl->gl_closedir = ansi_free;
      gl->gl_lstat = local_lstat;
      gl->gl_stat = local_lstat;
      /* We don't bother setting gl_lstat, since glob never calls it.
         The slot is only there for compatibility with 4.4 BSD.  */
    }

    void
    hash_init_directories (void)
    {
      hash_init (&directories, DIRECTORY_BUCKETS,
                 directory_hash_1, directory_hash_2, directory_hash_cmp);
      hash_init (&directory_contents, DIRECTORY_BUCKETS,
                 directory_contents_hash_1, directory_contents_hash_2,
                 directory_contents_hash_cmp);
    }

### MODULE.TARGET.SHARED_LIBRARIES.xxx already defined by xxx

    1. make clean && make clobber // 可能是有残留

    2. 删除多余的
    rm external/arm-trusted-firmware/lib/zlib/zlib/ -rf

## Reference
[Android Open Source Project](https://source.android.com/docs/setup)  
[Android Code Search](https://cs.android.com/android/platform/superproject/)  
[Android Compatibility Program Overview](https://source.android.com/docs/compatibility/overview)  

[AIDEGen](https://android.googlesource.com/platform/tools/asuite/+/refs/heads/master/aidegen/README.md)  
[Using AIDEGen for AOSP development](https://sx.ix5.org/info/post/using-aidegen-for-aosp-development/)  

[[GUIDE][COMPLETE] Android ROM Development From Source To End](https://forum.xda-developers.com/t/guide-complete-android-rom-development-from-source-to-end.2814763/)  
[[Guide][Video Tutorial] How to build Custom ROMs and Kernels![10,P,O,N,M,L]](https://forum.xda-developers.com/t/guide-video-tutorial-how-to-build-custom-roms-and-kernels-10-p-o-n-m-l.3814251/)  
[[ROM] [4.4.4] [AOSP] Paranoid Rastakat](https://forum.xda-developers.com/t/rom-4-4-4-aosp-paranoid-rastakat.2520202/)  
[Build AOSP KitKat 4.4](https://developer.sony.com/develop/open-devices/guides/aosp-build-instructions/build-aosp-kitkat-4-4#tutorial-step-1)  



