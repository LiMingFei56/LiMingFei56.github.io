---
layout: post
title: "Linux Net Tools"
categories: linux
tags: [linux]
date: 2022-01-28
---

## Linux Net Tools

### 测试网络连通性

    telnet 127.0.0.1 8080
    ssh -v 127.0.0.1 8080
    echo > /dev/tcp/127.0.0.1/8080


    netstat -anp | grep :27017 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
    sudo iftop -i ens192

    sar -n DEV 5
    sar -d 5


    yum install -y epel-release
    yum install -y iftop
    yum install -y sysstat
    yum install -y iperf3

    测试步骤
        在机器 A 上启动 iperf 服务器：

        bash
        Copy code
        iperf3 -s
        在机器 B 上运行 iperf 客户端：

        bash
        Copy code
        iperf3 -c <机器A的IP地址>
        结果解析

        Bandwidth 字段表示两台机器之间的网络带宽（如 Mbps 或 Gbps）。
        默认是 TCP 测试，可以通过 -u 参数切换到 UDP 测试：
        bash
        Copy code
        iperf3 -c <机器A的IP地址> -u



### Reference
[Check network usage per process in Linux](https://linuxhint.com/network_usage_per_process/)  
[How to Test Network Speed in Linux via CLI](https://phoenixnap.com/kb/linux-network-speed-test)  
