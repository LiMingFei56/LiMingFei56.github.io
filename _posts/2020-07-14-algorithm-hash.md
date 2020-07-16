---
layout: post
title: "Hash算法"
categories: algorithm
tags: [hash]
date: 2020-07-14
excerpt: "Hash算法"
---

## Hash算法

Hash算法: 把任意长度的输入通过Hash算法变换成固定长度的输出.
Hash冲突: 多个输入通过Hash算法得到同一个Hash值.

Hash table(ht): Hash列表, 一般使用顺序表存储
Hash table length(htlen): Hash列表长度

Hash slot: Hash槽, 表示ht中的一个位置

Hash loadFactor: 装填多少进行括容, java中默认0.75


### Hash函数

#### 1. 除余法

    // htlen 为Hash列表长度
    hash(key) = key mod htlen

#### 2. 乘余取整法

    // 先让关键码key乘上一个常数A (0< A < 1)，提取乘积的小数部分。
    // 然后，再用整数n乘以这个值，对结果向下取整，把它做为散列的地址
    hash(key) = _LOW(n * (A * key % 1))

#### 3. 平方取中法
    
    // 先通过求关键码的平方值，从而扩大相近数的差别
    // 然后根据表长度取中间的几位数（往往取二进制的比特位）作为散列函数值
    hash(key) = _CENTER(key ^ 2)

#### 4. 数字分析法

    // 1. 需要给定key的集合, 和htlen
    // 2. 分析所有key, 使之不失一般性
    // 3. 实现复杂

#### 5. 基数转换法

    // 1. 将关键码值看成另一种进制的数再转换成原来进制的数
    // 2. 然后选其中几位作为散列地址

#### 6. 折叠法

    // 1. 关键码分割成位数相同的几部分（最后一部分的位数可以不同）
    // 2. 然后取这几部分的叠加和（舍去进位）作为散列地址
    
    移位叠加：将分割后的几部分低位对齐相加。
    边界叠加:从一端沿分割界来回折叠，然后对齐相加。

### Java中的Hash函数

#### String.hashCode()

    int h = hash;
    if (h == 0 && value.length > 0) {
        char val[] = value;

        for (int i = 0; i < value.length; i++) {
            h = 31 * h + val[i];
        }
        hash = h;
    }
    return h;

1. hash = s[0] * 31^(n-1) + s[1]*31(n-2) + ... + s[n-1] `O(a^n)`
2. hash = (...(s[0] * 31 + s[1]) * 31 + s[2]) * 31 +...) + s[n−1] `O(n)`

3. 因为hash会溢出, 所以会有hash冲突

#### Integer.hashCode()

    public int hashCode() {
        return Integer.hashCode(value);
    }

    public static int hashCode(int value) {
        return value;
    }

1. int型hashCode是自身


#### Long.hashCode()

    public int hashCode() {
        return Long.hashCode(value);
    }

    public static int hashCode(long value) {
        return (int)(value ^ (value >>> 32));
    }

1. long是64位, 高32位和低32位 做 位或操作作为 hashcode
2. 忽略符号位


#### Double.hashCode()

    public int hashCode() {
        return Double.hashCode(value);
    }


    public static int hashCode(double value) {
        long bits = doubleToLongBits(value);
        return (int)(bits ^ (bits >>> 32));
    }

1. 把double转为long型
2. 求long的hashCode


### 解决冲突

冲突解决技术可以分为两类:
* open hashing, separate chaining
* closed hashing, open addressing

#### 1. separate chaining

1. 每个slot定义为链表表头, 每个node保存key, value, next, hash
2. hash值相同, 就添加到对应链表的表尾
3. 查找时需要遍历对应链表

#### 2. open addressing

1. 使用Hash(key) 生成一个基地址序列(home position)
2. 依次在基地址序列中寻找空位置, 找到了就放入, 不然就报错
3. 对key的增删改查, 都需要遍历key的home position

生成home position方法:
* 线性探测法
* 二次探查法
* 随机探查法
* 双散列探查法

### Reference
[Hash](https://baike.baidu.com/item/Hash/390310?fr=aladdin)
[hash算法原理详解](https://www.jianshu.com/p/f9239c9377c5)
[jdk1.7和1.8前后的HashMap，HashTable和ConcurrentHashMap的比较](https://blog.csdn.net/qq_33296156/article/details/82428026)
[HashMap的loadFactor为什么是0.75？](https://www.jianshu.com/p/64f6de3ffcc1)
