---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/jni/data
---

## JNI Types and Data Structures
Java和C的类型映射

### Primitive Types

Java    Type	   Native Type	Description
boolean	jboolean	unsigned 8 bits
byte	jbyte	    signed 8 bits
char	jchar	    unsigned 16 bits
short	jshort	    signed 16 bits
int	    jint	    signed 32 bits
long	jlong	    signed 64 bits
float	jfloat	    32 bits
double	jdouble	    64 bits
void	void	    not applicable

#define JNI_FALSE  0
#define JNI_TRUE   1

typedef jint jsize; // 描述基数及大小

### Reference Types

jobject
    jclass (java.lang.Class objects)
    jstring (java.lang.String objects)
    jarray (arrays)
        jobjectArray (object arrays)
        jbooleanArray (boolean arrays)
        jbyteArray (byte arrays)
        jcharArray (char arrays)
        jshortArray (short arrays)
        jintArray (int arrays)
        jlongArray (long arrays)
        jfloatArray (float arrays)
        jdoubleArray (double arrays)
    jthrowable (java.lang.Throwable objects)

typedef jobject jclass; // 其他的类型

// c++虚拟类 子类型关系
class _jobject {};
class _jclass : public _jobject {};
// ...
typedef _jobject *jobject;
typedef _jclass *jclass;

### Field and Method IDs
    struct _jfieldID;              /* opaque structure */
    typedef struct _jfieldID *jfieldID;   /* field IDs */

    struct _jmethodID;              /* opaque structure */
    typedef struct _jmethodID *jmethodID; /* method IDs */

### The Value Type
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

### Type Signatures
    Type Signature	Java Type
    Z	boolean
    B	byte
    C	char
    S	short
    I	int
    J	long
    F	float
    D	double
    L fully-qualified-class ;	fully-qualified-class
    [ type	type[]
    ( arg-types ) ret-type	method type

long f (int n, String s, int[] arr);
(ILjava/lang/String;[I)J

## Modified UTF-8 Strings
使用修改后的UTF-8 , 与JavaVM使用的字符串相同

0xxxxxxx

x: 110xxxxx
y: 10yyyyyy
((x & 0x1f) << 6) + (y & 0x3f)

x: 1110xxxx
y: 10yyyyyy
z: 10zzzzzz
((x & 0xf) << 12) + ((y & 0x3f) << 6) + (z & 0x3f)

u: 11101101
v: 1010vvvv
w: 10wwwwww
x: 11101101
y: 1011yyyy
z: 10zzzzzz
0x10000+((v&0x0f)<<16)+((w&0x3f)<<10)+(y&0x0f)<<6)+(z&0x3f)

big-endian存储

与标准UTF-8有两点不同:
    * 空字符（char）0使用双字节格式而不是单字节格式进行编码。
    * 仅使用标准UTF-8的单字节，双字节和三字节格式。 Java VM无法识别标准UTF-8的四字节格式;它使用自己的两倍三字节格式代替


