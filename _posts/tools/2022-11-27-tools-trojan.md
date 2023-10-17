---
layout: post
title: Trojan
categories: tools
tags: [tools]
date: 2022-11-27
---

## Trojan

### 域名

+ [freenom](www.freenom.com/)

    mingfeili.ml.intlzwj8fn

#### 手动延期

> 域名有效期最多为1年, 要到期时需要手动延期

    1. 登陆freenom网站
    2. Services -> My Domains 可以查看当前域名有效期
    3. Services -> Renew Domains 可以延期当前域名


    mingfeili.ml 2022-11-26 2024-02-26

### DNS

+ [cloudflare](https://dash.cloudflare.com/)

    mingfeili.ml.intlzwj8cf!


### SSL/TLS 证书

> 查看证书信息

    openssl x509 -in fullchain.pem -noout -text 

+ [acme](https://github.com/acmesh-official/acme.sh)

> acme可以用来快速创建免费的证书, 它会使用cloudfare api来创建证书, 当前已不支持
> You cannot use this API for domains with a .cf, .ga, .gq, .ml, or .tk TLD

#### 1. 手动调用cloudfare

    + [Tunnel setup with .tk TLD](https://community.cloudflare.com/t/tunnel-setup-with-tk-tld/428889)
    + [Set up a tunnel locally](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/local/)

#### 2. 使用域名别名

    + [DNS alias mode](https://github.com/acmesh-official/acme.sh/wiki/DNS-alias-mode)

#### 3. 使用cerbot
    
    + [Unable to update DDNS using API for some TLDs](https://community.cloudflare.com/t/unable-to-update-ddns-using-api-for-some-tlds/167228/63)
    + [LetsEncrypt Wildcard Zertifikat erstellen (DNS-Challenge)](https://www.youtube.com/watch?v=pOfcYqzR7qw)

    Found the solution here: LetsEncrypt Wildcard Zertifikat erstellen (DNS-Challenge) - YouTube 180 and adapted it to Cloudflare

    On your linux box:
    certbot certonly --manual --preferred-challenge dns -d “domain.com 4” -d “*.domain.com”

    Then certbot tells you to create a txt record with the name _acme-challenge.domain.com

    Now go to the Cloudflare Dashboard: dns → add record → select txt
    Name is _acme-challenge
    Paste the provided string from certbot into the content box → save

    The you can press enter in your certbot window and voila. You’ve got yourself a brand new certificate!!

    function i_certbot() {
      apt install -y python3 python3-venv libaugeas0
      python3 -m venv /opt/certbot/
      /opt/certbot/bin/pip install --upgrade pip
      /opt/certbot/bin/pip install certbot certbot-nginx
      ln -s /opt/certbot/bin/certbot /usr/bin/certbot

      mkdir -p /home/acme/letsencrypt/configdir
      chown -R acme:acme /home/acme/letsencrypt/configdir 
      mkdir -p /home/acme/letsencrypt/workdir 
      chown -R acme:acme /home/acme/letsencrypt/workdir 
      mkdir -p /home/acme/letsencrypt/logsdir
      chown -R acme:acme /home/acme/letsencrypt/logsdir

      runuser -l acme -c "certbot certonly --manual --preferred-challenge dns -d \"mingfeili.ml\" -d \"*.mingfeili.ml\" --config-dir=/home/acme/letsencrypt/configdir --work-dir=/home/acme/letsencrypt/workdir --logs-dir=/home/acme/letsencrypt/logsdir"
    }

    1. Enter email address (used for urgent renewal and security notices) 
        输入邮箱
    2. Y Y 同意条款

    3. Please deploy a DNS TXT record under the name:
        _acme-challenge.mingfeili.ml.
        with the following value:
        9nT8LOnXlVLkPhBNF0Xu3lUoHBEhYaJ0KS21IogLcpQ

        cloudfare -> dns -> records -> add record
        type 选择txt
        name  _acme-challenge
        content 9nT8LOnXlVLkPhBNF0Xu3lUoHBEhYaJ0KS21IogLcpQ

    4. cloudfare中配置完成后, 需要应用生效, 生效后cerbot再继续, 不然会生成失败

    This certificate expires on 2023-05-26.


#### nginx

            server {
                listen              6005 ssl;                    # 设置监听端口为443

                ssl_protocols       TLSv1.2 TLSv1.3;      # 设置使用的SSL协议版本

                ssl_certificate     /opt/certbot/output/configdir/live/mymikelmf56.win/fullchain.pem; # 证书地址
                ssl_certificate_key /opt/certbot/output/configdir/live/mymikelmf56.win/privkey.pem; # 秘钥地址
                ssl_session_cache   shared:SSL:10m;             # SSL TCP会话缓存设置共享内存区域名为
                                                                # SSL，区域大小为10MB
                ssl_session_timeout 10m;                        # SSL TCP会话缓存超时时间为10分钟
                proxy_protocol      on; # 开启proxy_protocol获取真实ip
                proxy_pass          127.0.0.1:6006; # 后端Trojan监听端口
        }

        server {
                listen              6005;
                server_name mymikelmf56.win;
                return 301 https://mymikelmf56.win$request_url;

        }

        server {
                listen 127.0.0.1:80 default_server;
                server_name mymikelmf56.win;

                location / {
                        proxy_pass https://www.ietf.org;
                }

        }

        server {
                listen 127.0.0.1:80;

                server_name <10.10.10.10>;

                return 301 https://mymikelmf56.win$request_uri;
        }

        server {
                listen 0.0.0.0:80;
                listen [::]:80;

                server_name _;

                return 301 https://$host$request_uri;
        }


## Reference
+ [Trojan](https://trojan-gfw.github.io/trojan/)  
+ [科学上网新姿势-Trojan小白搭建完全图文教程](https://www.4spaces.org/935.html)  
+ [Trojan 搭建记录](https://blog.starryvoid.com/archives/461.html)  
+ [Trojan 共用 443 端口方案](https://www.chengxiaobai.com/trouble-maker/trojan-shared-443-port-scheme)  
+ [Nginx+https+Trojan](https://blog.csdn.net/weixin_42831646/article/details/106874746)  
+ [Nginx+Trojan暂时滴神！](https://xrayr-project.github.io/XrayR-doc/za-xiang/nginx+trojan-zan-shi-di-shen.html)
