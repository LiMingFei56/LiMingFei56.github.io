---
layout: post
title: mongodb stop old openration
categories: mongodb
tags: [mongodb]
date: 2024-08-05
---

## mongodb stop old openration

> 当客户端断开连接时, 如果是aggregations 和 find操作, 则会自动停止该操作; 如果是写操作, 那么会继续执行; 见[https://www.mongodb.com/docs/drivers/node/current/faq/#what-happens-to-running-operations-if-the-client-disconnects-]()
> 如果是前端取消操作, 或者重新开始新的操作在FastAPI中, 不会中止之前的操作, 所以不会中止之前的MongoDB操作;

### 手动停止MongoDB操作

> 使用`db.currentOp()`方法可以查看当前正在执行的MongoDB操作;
> 使用`db.killOp(<opId>)`方法可以手动停止MongoDB操作;

> 需要关注哪些查询操作需要手动停止, 当查询之前识别出该操作是否已经存在, 如果存在就停止该操作, 再重新开始.

问题1: 怎么识别出查询操作, 需要研究db.currentOp()返回, 看能不能对应特定的查询操作;
问题2: 怎么识别出不同用户可以有相同的查询操作;

+ [详情见](https://www.mongodb.com/docs/v3.0/tutorial/terminate-running-operations/)

### db.currentOp 返回

    {
      "inprog": [
        {
          "opid": 12345,
          "active": true,
          "secs_running": 45,
          "microsecs_running": 45000000,
          "op": "query",
          "ns": "mydb.mycollection",
          "command": {
            "find": "mycollection",
            "filter": {
              "status": "pending"
            }
          },
          "client": "192.168.0.1:56789",
          "clientMetadata": {
            "application": {
              "name": "myApp"
            },
            "driver": {
              "name": "nodejs",
              "version": "3.6.4"
            },
            "os": {
              "type": "Linux",
              "name": "Ubuntu",
              "architecture": "x64",
              "version": "18.04"
            }
          },
          "connectionId": 789,
          "waitingForLock": false,
          "numYields": 2,
          "locks": {},
          "lockStats": {
            "Global": {
              "acquireCount": {
                "r": 1
              }
            }
          },
          "planSummary": "COLLSCAN",
          "host": "myserver:27017",
          "desc": "conn",
          "threadId": "139692736116480",
          "lsid": {
            "id": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
          },
          "txnNumber": 1,
          "readConcern": {
            "level": "local"
          },
          "writeConcern": {
            "w": "majority"
          }
        }
      ]
    }

* opid：操作的唯一标识符，用于终止该操作。
* active：操作是否仍在活动中。
* secs_running：操作已运行的时间，以秒为单位。
* microsecs_running：操作已运行的时间，以微秒为单位。
* op：操作类型，例如 query 表示查询操作。
* ns：命名空间，即操作涉及的数据库和集合。
* command：操作的命令详细信息，例如 find 表示查询命令。
* client：客户端的 IP 地址和端口。
* clientMetadata：包含客户端的详细信息，例如应用程序名称、驱动程序名称和版本、操作系统类型和版本等。
* connectionId：客户端连接的唯一标识符。
* waitingForLock：操作是否在等待锁。
* numYields：操作在执行过程中释放锁的次数。
* locks：当前持有的锁信息。
* lockStats：锁统计信息，包括锁类型和锁持有时间。
* planSummary：操作的执行计划概要。
* host：服务器的主机名。
* desc：操作的描述信息。
* threadId：执行该操作的线程 ID。
* lsid：会话 ID。
* txnNumber：事务号。
* readConcern：操作的读关注级别。
* writeConcern：操作的写关注级别。

## Reference
