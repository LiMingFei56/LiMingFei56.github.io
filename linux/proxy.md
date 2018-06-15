---
layout: page
permalink: /linux/proxy
---

## Proxy

### Shadowsocks

#### 安装

    sudo apt-get install python
    sudo apt-get install python-pip 
    sudo pip install shadowsocks

#### 配置

    { 
        “server”: “111.111.111.111”, 
        “server_port”: 443, 
        “local_port”: 1080, 
        “password”: “111111”, 
        “timeout”: 600, 
        “method”: “rc4-md5” 
    }

#### 启动
    
    sudo sslocal -c shawdowsocks.json -d start

#### 报错

1. shadowsocks2.8.2启动报undefined symbol: EVP_CIPHER_CTX_cleanup

    这个问题是由于在openssl1.1.0版本中，废弃了EVP_CIPHER_CTX_cleanup函数

    vim /usr/local/lib/python2.7/dist-packages/shadowsocks/crypto/openssl.py

    修改1: libcrypto.EVP_CIPHER_CTX_cleanup.argtypes = (c_void_p,) 
           libcrypto.EVP_CIPHER_CTX_reset.argtypes = (c_void_p,)

    修改2: libcrypto.EVP_CIPHER_CTX_cleanup(self._ctx) 
           libcrypto.EVP_CIPHER_CTX_reset(self._ctx)

### Privoxy
    因为Privoxy是Socks5代理，所以要把socks5转换成http,https

#### 安装

    apt-get install privoxy

#### 配置

    vi /usr/local/etc/privoxy/config
    :783: 找到 783行，去掉前面的注释符号，端口可以随便改
    listen-address 127.0.0.1:8118
    :1336: 找到 1336行，去掉前面的注释符号，后面的1080端口要对应ss服务里面的配置，要一致
    forward-socks5t / 127.0.0.1:1080

    8118端口走http协议，1080走socks5协议，socks5会经过http，这样间接的ss也能支持http协议了

#### 让终端走代理

    vi /ect/profile
    vi ~/.bash_profile
    vi ~/.bashrc
    
    export https_proxy=http://127.0.0.1:8118
    export http_proxy=http://127.0.0.1:8118
    export ftp_proxy=http://127.0.0.1:8118

### Polipo
    同Privoxy

#### 安装

    sudo apt-get install polipo  

#### 配置

    /etc/polipo/config

    logSyslog = true
    logFile = /var/log/polipo/polipo.log
    
    proxyAddress = "0.0.0.0"
    
    socksParentProxy = "127.0.0.1:1080"
    socksProxyType = socks5
    
    chunkHighMark = 50331648
    objectHighMark = 16384
    
    serverMaxSlots = 64
    serverSlots = 16
    serverSlots1 = 3

    sudo service polipo restart  重启服务

    export http_proxy="http://127.0.0.1:8123"  
    export https_proxy="https://127.0.0.1:8123" 


