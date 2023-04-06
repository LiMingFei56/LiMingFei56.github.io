---
layout: post
title: Oracle 数据导入导出
categories: db
tags: [db]
date: 2023-03-08
---

## Oracle 数据导入导出

> 按用户导出可以导出索引, 序列, 存储过程, 分区等等

### EXP

    // EXP导出整个数据库
    exp full=y file=wholedb.dmp
    
    // EXP导出全库，不包括数据
    exp full=y rows=n file=wholedb_without_data.dmp

    // EXP指令导出特定的表
    exp tables=scott.emp,scott.dept file=scott.dmp

    // EXP指令导出当前用户的表
    exp scott/scott tables=dept,emp file=current_user_data.dmp

    // EXP指令导出指定的用户
    exp owner=scott file=scott.dmp

    // EXP导出指定的表空间
    exp tablespaces=users file=user_ts.dmp

### IMP

需要按照顺序导入:
    1、创建表结构
    2、导入表数据
    3、创建索引
    4、导入触发器
    5、对导入的表启用完整性约束
    6、建立索引


    //帮助 imp help=y

    // 恢复特定的表
    imp tables=emp fromuser=scott touser=scott file=scott.dmp

    // IMP指令恢复指定的用户
    imp ignore=y fromuser=scott touser=scott file=scott.dmp

### 导出优化

    // 使用直接路径及设置缓存
    direct=y recordlength=65535

一些限制如下：
·    直接路径不能使用在tablespace-mode
·    直接路径不支持query参数。query只能在conventional path模式下使用。
·    如果exp版本小于8.1.5，不能使用exp导入有lob字段的表。 不过现在很少有有8版本的数据库了。这点可以忽略掉了。
·    buffer选项只对conventional path exp（传统路径）有效。对于直接路径没有影响。对于直接路径，应该设置RECORDLENGTH参数。
·    对于直接路径下， RECORDLENGTH参数建议设成64k（65535）。这个值对性能提高比较大。

### 导入优化

> Oracle Import进程需要花比Export进程数倍的时间将数据导入数据库

    commit=y feedback=10000 buffer=10240000

如果想导入的用户已经存在:
1. 导出用户 expdp user1/pass1 directory=dumpdir dumpfile=user1.dmp
2. 导入用户 impdp user2/pass2 directory=dumpdir dumpfile=user1.dmp REMAP_SCHEMA=user1:user2 EXCLUDE=USER

如果想导入的用户不存在:
1. 导出用户 expdp user1/pass1 directory=dumpdir dumpfile=user1.dmp
2. 导入用户 impdp system/passsystem directory=dumpdir dumpfile=user1.dmp REMAP_SCHEMA=user1:user2
3. user2会自动建立，其权限和使用的表空间与user1相同，但此时用user2无法登录，必须修改user2的密码

### 工作目录

    SELECT * FROM dba_directories;

    SYS                            DATA_PUMP_DIR
/u01/app/oracle/admin/XE/dpdump/

/u01/app/oracle/12c/rdbms/log



## Reference
+ [优化exp/imp导入导出速度大全](https://blog.csdn.net/demonson/article/details/103728324)
