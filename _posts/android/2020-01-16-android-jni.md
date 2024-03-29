---
layout: post
title: "Android JNI"
categories: android
tags: [android]
date: 2020-01-16
---

## Android JNI

Java Native Interface(JNI), 使Java可用调用C, C++, Assembly. 这是一个规范, 不依赖
Java VM具体实现.

下面的示例说明了当您需要使用Java本机方法时：

  * 标准Java类库不支持应用程序所需的依赖于平台的特征。
  * 您已经有了用另一种语言编写的库，并且希望通过JNI访问Java代码。
  * 您希望在低级语言（如汇编）中实现一小部分时间关键代码。

通过JNI编程，可以使用本机方法来：

  * 创建、检查和更新Java对象（包括数组和字符串）。
  * 调用Java方法。
  * 捕获和抛出异常。
  * 加载类并获取类信息。
  * 执行运行时类型检查。

JNI备选方案:

  * JDK 1.0 native method interface
  * Netscape’s Java Runtime Interface
  * Microsoft’s Raw Native Interface and Java/COM interface

*注: 从各方面考虑, 最后选择JRI*

## 设计
> 本地代码通过一个接口指针访问JNI方法(JNIEnv), 进尔调用Java VM特性. JNI方法是以函数表的
> 形式提供的, 因为JNI方法与Java VM代码分离, 并且可以提供多套JNI方法.

> Java VM是支持多线程的, 所以本地库编译应该可以实别多线程, D\_REENTRANT OR D\_POSIX\_C\_SOURCE

> 当Java方法调用本地方法时, VM会创建一个本地引用的表, 传递给本地方法的引用和本地方法返回的
> 引用, 都会在这个表里. 本地方法返回后会删除这张表, 进而垃圾回收. JNI提供一组丰富的方法
> 访问全局和本地引用, 所以这跟VM无关

> 本地方法访问原始数据和字符串在JNI中是很低效的, 1. 如果只访问数据中的少部分数据时,
> 使用JNIEnv中提供的方法. 2. 使用另一组函数去访问(copying or pinning). JNI应该支持
> 多线程访问数组.

> 本地方法使用名称和签名来标识JAVA字段和方法

> JNI不会检查任何异常, 因此不要把非法引用传递给本地方法, 这样可能导致任意后果和VM crash.
> JNI可以抛出JAVA异常和处理JAVA异常, 没有处理的JAVA异常会返回到VM中. '处理异步异常' 



### 1. 加载本地库

  System.loadLibrary("lib_name")加载本地库

lib_name: 会根据平台不一样, 转换不同的库名称, 如Solaris(pkg_Cls to libpkg_Cls.so)
  win32(pkg_Cls to pkg_Cls.dll)

> ClassLoader会维护本地库加载列表, 程序员来控制库名称冲突情况. 如果平台不支持动态库, 
> 那么所有的地址方法需要预链接VM, 这种情况就不用调用System.loadLibrary().

### 2. 解析本地方法名称
需要让VM知道本地库提供哪些方法, 注册本地方法有两种方式:
  * 静态注册
  * 动态注册

#### 2.1 动态注册
> 在调用 System.loadLibrary 加载库文件时，系统回调 JNI_OnLoad() 函数。
> 可以在 JNI_OnLoad 中做一些初始化操作，可以用 RegisterNatives 方法注册 Java native 方法。
使用RegisterNatives(), 静态注册本地方法

    static JNINativeMethod gMethods[] = {
        {"helloworld", "()Ljava/lang/String;", (void*)Jni_helloworld}};

    static int registerNativeMethods(JNIEnv* env)
    {
        jclass clazz;
        clazz = env->FindClass("com/example/test/MainActivity");
        if (clazz == NULL) {
            return JNI_FALSE;
        }
        if (env->RegisterNatives(clazz, gMethods, sizeof(gMethods) / sizeof(gMethods[0])) < 0) {
            return JNI_FALSE;
        }

        return JNI_TRUE;
    }

#### 2.2 静态注册
会根据Java方法签名来匹配本地方法, 1. VM匹配不带参数的方法签名; 2. VM匹配带参数的
签名; 只有当本地方法重载时, 才使用匹配带参数的签名. 可以使用`javah`生成符合规定的
方法.

Java方法匹配本地方法:
  * the prefix Java_
  * a mangled fully-qualified class name
  * an underscore (“_”) separator
  * a mangled method name
  * for overloaded native methods, two underscores (“__”) followed by the mangled argument signature

并且Java方法匹配到本地方法时, 会把unicode代码转成本地代码, 转义:

  _0XXXX unicode代码
  _1 the character “_”
  _2 the character “;” in signatures
  _3 the character “[“ in signatures

  native double f(int i, String s); 
  jdouble Java_pkg_Cls_f__ILjava_lang_String_2 (
     JNIEnv *env,        /* interface pointer */
     jobject obj,        /* "this" pointer */
     jint i,             /* argument #1 */
     jstring s)          /* argument #2 */
  {

> 第一个参数为JNI方法指针
> 第二个参数根据Java调用方法是否是静态而不同, 静态为类的对象, 非静态为对象
> 后面为Java方法传递的参数

### 3. 内存管理
Java和本地方法相互传递的数据, 垃圾回收器应该要知道什么时候回收, 什么时候不应该回收.

Java和本地方法传递的都是本地引用, JNI把引用分为两种(本地和全局), 本地只在方法调用中有效, 
全局引用需要显示的释放. JNI可以随时把本地引用转成全局引用. 有时本地引用也应该手动调用
释放. JNI允许释放本地引用, 然而不允许创建本地引用. 本地引用只在当前线程有效

### 4. 访问JAVA字段和方法
jmethodID mid =      env->GetMethodID(cls, “f”, “(ILjava/lang/String;)D”);
jdouble result = env->CallDoubleMethod(obj, mid, 10, str);

处理JAVA异常:
> 当JAVA方法调用失败后, 该方法会返回一个非正常值, 如(NULL), 检查这个值并调用
> ` ExceptionOccurred()`获取异常对象. 异常产生后需要调用`ExceptionClear()`后才能调用Java方法

当异常产生后, 下面方法可以安全执行:
  ExceptionOccurred()
  ExceptionDescribe()
  ExceptionClear()
  ExceptionCheck()
  ReleaseStringChars()
  ReleaseStringUTFChars()
  ReleaseStringCritical()
  Release<Type>ArrayElements()
  ReleasePrimitiveArrayCritical()
  DeleteLocalRef()
  DeleteGlobalRef()
  DeleteWeakGlobalRef()
  MonitorExit()
  PushLocalFrame()
  PopLocalFrame()

### 5. 类型与数据结构

Java类型对应JNI类型
| Java Type | Native Type | Description      |
|-----------|-------------|------------------|
| boolean   | jboolean    | unsigned 8 bits  |
| byte      | jbyte       | signed 8 bits    |
| char      | jchar       | unsigned 16 bits |
| short     | jshort      | signed 16 bits   |
| int       | jint        | signed 32 bits   |
| long      | jlong       | signed 64 bits   |
| float     | jfloat      | 32 bits          |
| double    | jdouble     | 64 bits          |
| void      | void        | N/A              |
|-----------|-------------|------------------|

引用:
jobject
  jclass
  jstring
  jarray
    jobjectArray
    jbooleanArray
    jbyteArray
    jcharArray
    jshortArray
    jintArray
    jlongArray
    jfloatArray
    jdoubleArray
  jthrowable

JNI定义的值:

  #define JNI_FALSE  0 
  #define JNI_TRUE   1
  typedef jint jsize;
  struct \_jfieldID;              /* opaque structure */ 
  typedef struct \_jfieldID \*jfieldID;   /* field IDs */ 
   
  struct \_jmethodID;              /* opaque structure */ 
  typedef struct \_jmethodID \*jmethodID; /* method IDs */

  typedef union jvalue { 
    jboolean z; 
    jbyte    b; 
    jchar    c; 
    jshort   s; 
    jint     i; 
    jlong    j; 
    jfloat   f; 
    jdouble  d; 
    jobject  l; 
  } jvalue;
  // C
  typedef jobject jclass;
  // C++
  class \_jobject {}; 
  class \_jclass : public \_jobject {}; 
  ... 
  typedef \_jobject \*jobject; 
  typedef \_jclass \*jclass;

类型签名
| Type Signature           | Java Type             |
|--------------------------|-----------------------|
| Z                        | boolean               |
| B                        | byte                  |
| C                        | char                  |
| S                        | short                 |
| I                        | int                   |
| J                        | long                  |
| F                        | float                 |
| D                        | double                |
| L fully-qualified-class; | fully-qualified-class |
| [ type                   | type[]                |
| ( arg-types ) ret-type   | method type           |
|--------------------------|-----------------------|

  long f (int n, String s, int[] arr); // 类型签名
  (ILjava/lang/String;\[I)J

### 5. JNI方法
[JNI Functions](https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/functions.html#wp23717)


## Reference

  * [Java Native Interface Specification—Contents](https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/jniTOC.html)


### Android jni

### JavaVM 和 JNIEnv
> JNI的关键两个数据结构, 是一个函数表的指针(C++中是类), JavaVM可以创建, 销毁虚拟机.
> 理论上一个进程可以有多个虚拟机, 但是Android, 一个进程只能有一个虚拟机

> JNIEnv是线程本地的, 如果一个线程没有自己的JNIEnv, 那么需要使用JavaVM, GetEnv函数
> 获取

> JavaVM和JNIEnv在C和C++中的实现不一样, 所以不要在头文件中引用`JNIEnv`, 不然需要
> 使用`#ifdef __cplusplus`在一些额外的处理

### 线程
> Thread.start(), 创建的线程是Linux线程, 由kernel调度. 本地方法可以使用pthread_create
> 或者std:thread创建新线程, 但是这种创建的线程没有`JNIEnv`.

> 可以使用`AttachCurrentThread()`和`AttachCurrentThreadAsDaemon()`在本地线程绑定到
> JavaVM中. JavaVM会把绑定的线程添加到线程组中, 并且可以显示调度信息.

> Android不会停止执行本地代码, 当在进程中垃圾回收或者有个Debug请求时, Android会
> 在下次JNI函数调用时暂停

> 绑定的本地线程需要在退出前调用`DetachCurrentThread()`. 可以使用`pthread_key_create()`
> 时传递的析构函数, 来调用这个解绑函数.

### jclass, jmethodID, and jfieldID
* FindClass
* GetFieldID
* GetIntField

> 执行函数, 或者读取字段, 都需要对象的引用和函数或字段的ID. ID是Java对象在本地代码中
> 呈现的数据结构的指针, 在查找上会耗费一些性能. 

> 缓存ID来提供性能, 因为Android中只有一个JavaVM, 因此类在虚拟机中是静态不变的. 但
> 为了保证类不会从Classloader中卸载, 需要让jclass引用成全局引用, 使用`NewGlobalRef`.

> 如果要让类卸载后重新加载时, 重新获取缓存ID, 那么本地需要实现`nativeClassInit`, 当类
> 初始化时只执行一次.

    companion object {
      /*
       * We use a static class initializer to allow the native code to cache some
       * field offsets. This native function looks up and caches interesting
       * class/field/method IDs. Throws on failure.
       */
      private external fun nativeInit()

      init {
          nativeInit()
      }
    }


### Local and global references
* local references: 只在当前函数, 当前线程有效. 如果对象在函数返回后依然存在
  , 引用也是无效的
* global references: 在当前线程有效, 需要手动删除.

> 所有本地方法参数和JNI函数的返回, 都是本地引用

> 本地引用只有调用`NewGlobalRef`和`NewWeakGlobalRef`创建全局引用, 全局引用需要
> 调用`DeleteGlobalRef`来释放自己.

> 每次调用`NewGlobalRef`返回的值是不一样的, 需要使用`IsSameObject`函数来判断是不是
> 同一个对象. 而且不能假定引用的值是唯一的32位数

> 如果本地引用过多的话, 也需要手动释放. 因为虚拟机只有在本地方法返回后释放本地引用.
> Android实现最多只能有16个引用, 如果想要更多, 需要手动删除引用, 或者使用`EnsureLocalCapacity`
> 和`PushLocalFrame`创建更多的引用.

> jfieldIDs 和 jmethodIDs 不是对象的引用, 是不透明对象, 在线程之间有效

> `AttachCurrentThread`的线程运行中, 不会自动删除本地引用, 所以最好在绑定线程和循环创建
> 引用时, 手动删除本地引用.

### UTF-8 and UTF-16 String
> Java是使用UTF-16编码, JNI使用的是修改后的UTF-8, 好处是可以使用`\0`结尾的字符串, 坏处
> 是utf-8字符串不能好好的工作. 推荐使用UTF-16

> JNI中Get字符串是C指针, 不是本地引用, 所以需要手动释放`Release`. 传递给NewStringUTF应用是
> mUTF-8, 需要过滤掉不支持的字符.

### 访问数组
> 使用`Get<PrimitiveType>ArrayElements`获取指向数据的指针(1. 返回实际数据的指针
> 需要固化数组对象, 2. 返回复制后地址的指针), 需要手动释放`Release`. 如果Get数组失败
> , 应该避免释放空指针

> `isCopy`函数可以判断数组是否是复制的.

数组`Release`有个mode参数, 有三个值:
  
  * 0 : 数组对象没有固化, 把副本复制到原处, 并释放副本.
  * JNI_COMMIT : 把副本复制到原处, 不释放副本, 需要使用其他标志再释放一次副本.
  * JNI_ABORT : 数组没有固化, 释放副本, 丢弃修改.

> `Get<Type>ArrayRegion` 和 `Set<Type>ArrayRegion`, `GetStringRegion` 和 `GetStringUTFRegion`
> 会读取一个数组的一部分, 并且释放原数组

    env->GetByteArrayRegion(array, 0, len, buffer);
    等效
    jbyte* data = env->GetByteArrayElements(array, NULL);
    if (data != NULL) {
        memcpy(buffer, data, len);
        env->ReleaseByteArrayElements(array, data, JNI_ABORT);
    }


### 扩展检查
在调用`JavaVM`和`JNIEnv`函数会先执行一系列检查, CheckJNI.

  * 数组：尝试分配负数大小的数组。
  * 错误的指针：将错误的jarray / jclass / jobject / jstring传递给JNI调用，或者将NULL指针传递给具有非空参数的JNI调用。
  * 类名：将类名的“ java / lang / String”样式以外的任何内容传递给JNI调用。
  * 关键调用：在“关键”获取及其对应的版本之间进行JNI调用。
  * Direct ByteBuffers：将错误的参数传递给NewDirectByteBuffer。
  * 例外：有待处理的例外时拨打JNI电话。
  * JNIEnv * s：从错误的线程使用JNIEnv *。
  * jfieldIDs：使用NULL jfieldID，或使用jfieldID将字段设置为错误类型的值（例如，尝试将StringBuilder分配给String字段），或将jfieldID用作静态字段以设置实例字段或 反之亦然，或者将一个类的jfieldID与另一个类的实例一起使用。
  * jmethodID：在进行Call * Method JNI调用时使用了错误的jmethodID类型：错误的返回类型，静态/非静态不匹配，“ this”的类型错误（对于非静态调用）或类（错误的静态调用）。
  * 参考：在错误的参考类型上使用DeleteGlobalRef / DeleteLocalRef。
  * 释放模式：将错误的释放模式传递给释放调用（0，JNI_ABORT或JNI_COMMIT以外的其他值）。
  * 类型安全：从您的本机方法返回不兼容的类型（例如，从声明为返回String的方法中返回StringBuilder）。
  * UTF-8：将无效的修改后的UTF-8字节序列传递给JNI调用。

> 虚拟机自动打开
> root设备使用: adb shell stop; adb shell setprop dalvik.vm.checkjni true; adb shell start
> 常规设备使用: adb shell setprop debug.checkjni 1
> 只使用当前应用: android:debuggable

### 加载动态库
`System.loadLibrary`, 老版本有问题, 需要使用`ReLinker.loadLibrary`.

    companion object {
        init {
            System.loadLibrary("fubar")
        }
    }

    JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved) {
        JNIEnv* env;
        if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
            return JNI_ERR;
        }

        // Find your class. JNI_OnLoad is called from the correct class loader context for this to work.
        jclass c = env->FindClass("com/example/app/package/MyClass");
        if (c == nullptr) return JNI_ERR;

        // Register your class' native methods.
        static const JNINativeMethod methods[] = {
            {"nativeFoo", "()V", reinterpret_cast(nativeFoo)},
            {"nativeBar", "(Ljava/lang/String;I)Z", reinterpret_cast(nativeBar)},
        };
        int rc = env->RegisterNatives(c, methods, sizeof(methods)/sizeof(JNINativeMethod));
        if (rc != JNI_OK) return rc;

        return JNI_VERSION_1_6;
    }

### Java与本地方式间共享数据
1. 使用byte[] java快, 本地慢
2. 使用java.nio.ByteBuffer.allocateDirect AND JNI NewDirectByteBuffer 本地快, java慢

选择哪一个:
  1. 由数据处理端决定, 哪端处理数据多就使用哪个
  2. 由最终数据格式决定(如果最终byte[], 那么就不要使用allocateDirect)



### 支持64位
使用long来表示指针

### Android 不支持的JNI特性
  * DefineClass, Android不使用Java字节码, 所以不能传递类的二进制数据

### 主要问题

#### FAQ: Why do I get UnsatisfiedLinkError?

  java.lang.UnsatisfiedLinkError: Library foo not found

库没有找到, 或者不能打开. 

  * 使用 adb shell ls -l <path> 查看库是否存在, 是否能访问
  * 不是使用NDK构建的, 有可能有问题

W/dalvikvm(  880): No implementation found for native LFoo;.myfunc ()V

  没有找到匹配的函数:
    * 该库没有加载
    * 名称不正确或者签名不匹配

需要正确的使用extern "C" (表示这部分代码使用C规则编译), 推荐使用javah来生成jni.h



### Reference

