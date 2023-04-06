---
layout: post
title: ubuntu 18.04 install oracle dbms
categories: linux
tags: [linux]
date: 2023-03-03
---

## 查询

    select name from v$database;
    select instance_name from v$instance;
    show parameter serive_name;
    show parameter serive_names; // 集群
    show parameter name;

* 查看所有表大小
    select segment_name, bytesfrom user_segmentswhere segment_type = 'TABLE';

* 查看表所在的表空间
    analyze table test01 compute statistics;

* 查看所有表空间
    select * from user_tablespaces
* 查看表空间剩余空间
    select tablespace_name,sum(nvl(bytes,0)) from dba_free_space group by tablespace_name；

    select tablespace_name,sum(bytes) from dba_data_files group by tablespace_name;

    select tablespace_name,contents,extent_management from dba_tablespaces;

    // 表大小
    select segment_name  --表名
          ,bytes  --分配空间大小(字节)
          ,bytes/1024/1024  --分配空间大小(M)
      from user_segments
     where segment_type = 'TABLE';

    // 表实际大小
     select table_name  --表名
      ,(num_rows * avg_row_len)/1024/1024 --实际存储空间大小
      from user_tables ;

    // 表空间大小
    select tablespace_name  --表空间名称
      ,sum(bytes)/1024/1024  --表空间大小
      from dba_segments 
     group by tablespace_name ;

    // 查看表空间大小及使用率
    
    select a.a1 表空间名称
    　　   ,c.c2 类型
    　　   ,c.c3 区管理
    　　   ,b.b2/1024/1024 表空间大小M
    　　   ,(b.b2-a.a2)/1024/1024 已使用M
    　　   ,substr((b.b2-a.a2)/b.b2*100,1,5) 利用率
      from (select tablespace_name a1, sum(nvl(bytes,0)) a2 from dba_free_space group by tablespace_name) a,
    　　    (select tablespace_name b1,sum(bytes) b2 from dba_data_files group by tablespace_name) b,
    　　    (select tablespace_name c1,contents c2,extent_management c3 from dba_tablespaces) c
     where a.a1=b.b1 and c.c1=b.b1 ;



## ubuntu 18.04 install oracle dbms

    docker search oracle
    docker pull registry.cn-hangzhou.aliyuncs.com/qida/oracle-xe-11g
    docker images
    docker images registry.cn-hangzhou.aliyuncs.com/qida/oracle-xe-11g

    <!-- docker volume create oracle-xe-vol -->
    <!-- docker run -d -p 1521:1521 --privileged=true --name oracle11-xe -v 'oracle-xe-vol:/u01/app/oracle/oradata' -e ORACLE_ALLOW_REMOTE=true registry.cn-hangzhou.aliyuncs.com/qida/oracle-xe-11g -->

    docker run -d -p 1521:1521 --name oracle11-xe registry.cn-hangzhou.aliyuncs.com/qida/oracle-xe-11g


    docker exec -it oracle11-xe /bin/bash
    su - oracle
    sqlplus /nolog;
    conn / as sysdba;

    create tablespace testhbga datafile '/u01/app/oracle/oradata/XE/testhbga.dbf' size 100m autoextend on next 10m;
    create temporary tablespace testhbga_temp tempfile '/u01/app/oracle/oradata/XE/testhbgatemp.dbf' size 50m autoextend on next 10m maxsize 20480m extent management local;
    create user testhbga identified by t1e2s3t4hbga default tablespace testhbga;

    grant connect,resource,dba to testhbga;

    conn testhbga/t1e2s3t4hbga@127.0.0.1:1521/XE


    select * from nls_database_parameters where parameter in ('NLS_LANGUAGE','NLS_TERRITORY','NLS_CHARACTERSET','NLS_NCHAR_CHARACTERSET');
    select * from nls_database_parameters;

    ALTER SYSTEM ENABLE RESTRICTED SESSION;
    ALTER DATABASE character set INTERNAL_USE ZHS16GBK;

    shutdown immediate;
    startup mount;
    --限制session
    alter system enable restricted session;
    --查询相关参数并修改（防止有任务自动启动执行，一般不做也没关系）
    show parameter job_queue_processes; -- 记下这个值
    show parameter aq_tm_processes; -- 记下这个值
    alter system set job_queue_processes=0;
    alter system set aq_tm_processes=0;
     
    -- 按需修改nls_characterset，其中INTERNAL_USE表示跳过字符集检查
    alter database character set internal_use AL32UTF8;
    -- 按需修改nls_nchar_characterset
    ALTER DATABASE NATIONAL CHARACTER SET INTERNAL_USE UTF8;
    -- 查看修改后字符集
    select * from nls_database_parameters;
     
    shutdown immediate;
    startup mount;
    --将相关参数改回原来的值
    alter system set job_queue_processes=5;
    alter system set aq_tm_processes=1;
    Alter database open;

    create tablespace testlj datafile '/u01/app/oracle/oradata/XE/testlj.dbf' size 100m autoextend on next 10m;
    create temporary tablespace testlj_temp tempfile '/u01/app/oracle/oradata/XE/testljtemp.dbf' size 50m autoextend on next 10m maxsize 20480m extent management local;
    create user testlj identified by testlj#098 default tablespace testlj;

    grant connect,resource,dba to testlj;

    create tablespace ZHENGWU_DATA datafile '/u01/app/oracle/oradata/XE/ZHENGWU.dbf' size 100m autoextend on next 10m;
    create temporary tablespace ZHENGWU_temp tempfile '/u01/app/oracle/oradata/XE/ZHENGWUtemp.dbf' size 50m autoextend on next 10m maxsize 20480m extent management local;
    create user zhengwu identified by Zhengwu#456 default tablespace ZHENGWU_DATA;

    grant connect,resource,dba to zhengwu;

### 账号

account: sys as sysdba
password: sysdba


### apparmor failed to apply profile: write /proc/self/attr/exec: invalid argument: unknown.

    apt install apparmor

    + [docker: Error response from daemon: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"apply apparmor profile: apparmor failed to apply profile: write /proc/self/attr/exec: permission denied\""](https://github.com/docker/for-linux/issues/1129)
    + [apparmor failed to apply profile: write /proc/self/attr/exec: invalid argument: unknown.](https://github.com/docker/for-linux/issues/1199)

### ORA-12720: operation requires database is in EXCLUSIVE mode

    show parameter cluster_database;
    alter system set cluster_database=FALSE scope=spfile sid=’*’;
    <!-- shutdown abort; -->
    exit;

    srvctl status database -d testdb

    select userenv('language') from dual;


### ORA-29701: unable to connect to Cluster Synchronization Service

    $GRID crsctl 命令在这个
    
    spfile文件在asm中, asm是oracle配置信息数据库, asmcmd在oracle下
    asmcmd 
    startup
    ls
    show parameter spfile;
    /DATA/{dbname}/PARAMETERFILE/spfile
    cp /DATA/{dbname}/PARAMETERFILE/spfile /tmp/spfile
    create pfile='/tmp/pfile' from spfile

    ps -ef |grep crsd.bin 

    crsctl stat res -t -init
    crsctl start res ora.crsd -init

    crsctl enable has / by root

    ./crsctl check crs
    	
    ps -fea |grep crsd.bin
    crsctl start res ora.crsd -init

### CRS-4639: Could not contact Oracle High Availability Services

    [root@b1 grid]# cd /u01/app/11.2.0/grid/crs/install
    [root@b1 install]#  ./roothas.pl -deconfig -force -verbose

    [root@b1 install]# cd /u01/app/11.2.0/grid/
    [root@b1 grid]# ./root.sh

    crsctl check css
    crsctl check has
    crsctl stat res -t [-init]
    crsctl disable has
    crsctl enable has
    crsctl modify resource "ora.cssd" -attr "AUTO_START=1"
    crsctl modify resource "ora.diskmon" -attr "AUTO_START=1"


    启动ASM 实例

    [grid@ node1 ~]$echo $ORACLE_SID
    +ASM

    [grid@ node1~]$ sqlplus / as sysasm

    SQL>  startup;

    SQL>  select instance_name,status from v$instance;

### ORA-39082对象创建时出现编译错误

+ [11GR2中的Oracle导入错误,ORA-39082对象创建时出现编译错误](https://qa.1r1g.com/sf/ask/767154601/)
+ [oracle的39082,ORA-39082 导入数据遇到的问题](https://blog.csdn.net/weixin_30253289/article/details/116478436)

    ORA-39082: Object type PROCEDURE: "ZHENGAU", "PROC_DATA_SYNC_SHANGHAI" created with compilation warnings ORA-39082: Object type PROCEDURE: "ZHENGWU". "PROC_DATA_SYNC_SHANGHAII" created with compilation warnings ORA-39082: Object type PROCEDURE: "ZHENGWU", "PROC_DATA_SYNC_SHANGHAI_OLD" created with compilation warnings ORA-39082: Object type PROCEDURE: "ZHENGWU". "PROC_DATA SYNC_SHANGHAI" created with compilation warnings ORA-39082: Object type PROCEDURE: "ZHENGAL". "PROC_DATA SYNC_SHANGHATI" created with compilation warnings ORd-39082: Object type PROCEDURE: "ZHENGWU", "PROC_DATA_SYNC_SHANGHAI_OLD" created with compilation warnings
Job "ZHENGNU", "SYS_IMPORT_FULL_O1" completed

    ORA-39082: Object type ALTER_PROCEDURE:"CONTA"."PROC_CONTA_BALANCE_FZHKH" created with compilation warnings

    view：    alter view view_name compile;
    function:    alter function function_name compile;
    procedure:   alter procedure procedure_name compile;

    show error procedure procedure_name;

### ORA-28040: No matching authentication protocol


    需要更新ojdbc
    或者oracle修改配置  $ORACLE_HOME/network/admin/sqlnet.ora SQLNET.ALLOWED_LOGON_VERSION_SERVER=10


## Reference
+ [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
+ [在Ubuntu18.04的Docker中安装Oracle镜像及简单使用](https://www.shuzhiduo.com/A/LPdo1KWOJ3/)
+ [write /proc/self/attr/apparmor/exec: no such file or directory: unknown](https://github.com/docker/for-linux/issues/1199)
+ [镜像部署Oracle-xe-11g（仅供开发）](https://blog.csdn.net/weixin_44133019/article/details/125930897)

