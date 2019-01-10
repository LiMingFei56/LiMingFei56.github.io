---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/jni
---

## JNI

* [Introduction](./jni/introduction)
* [Design](./jni/design)
* [JNI Types and Data Structures](./jni/data)

库有两种, static lib 和 shared lib
static lib 会把所以依赖打到一个包里, 不依赖其他包运行
shared lib 不会把依赖包打到一起, 运行时依赖其他包运行

链接方式有两种, 
一种静态链接生成静态包
一种动态链接生成共享包

jni需要把包的方法注册到Java函数上, 有两种方式:
1. 自动注册

    Step 1: Write a Java Class HelloJNI.java that uses C Codes
    static {
      System.loadLibrary("hello"); // Load native library hello.dll (Windows) or libhello.so (Unixes)
                                   //  at runtime
                                   // This library contains a native method called sayHello()
    }
    private native void sayHello();    

    Step 2: Compile the Java Program HelloJNI.java & Generate the C/C++ Header File HelloJNI.h
    javac -h . HelloJNI.java // jdk 8.0
    javac HelloJNI.java // jdk 8.0 after
    javah HelloJNI

    Step 3: Implementing the C Program HelloJNI.c
    通过本地代码方法名来查找对应的函数
    JNIEXPORT void JNICALL Java_HelloJNI_


    Step 4: Compile the C program HelloJNI.c

    函数名字长, 不能修改

2. 手动注册
    在JNI_OnLoad方法中调用RegisterNatives方法,手动注册

    static JNINativeMethod methods[] = {
        {"getNativeString", "()Ljava/lang/String;", reinterpret_cast<void*>(getString)}
    };

    JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved)
{
    JNIEnv* env;
    if (JNI_OK != vm->GetEnv(reinterpret_cast<void**> (&env),JNI_VERSION_1_4)) {
        LOGW("JNI_OnLoad could not get JNI env");
        return JNI_ERR;
    }

    g_jvm = vm; //用于后面获取JNIEnv
    jclass clazz = env->FindClass("com/example/myndkproj/NativeLib");  //获取Java NativeLib类

	//注册Native方法
    if (env->RegisterNatives(clazz, methods, sizeof(methods)/sizeof((methods)[0])) < 0) {
        LOGW("RegisterNatives error");
        return JNI_ERR;
    }

    return JNI_VERSION_1_4;
}


