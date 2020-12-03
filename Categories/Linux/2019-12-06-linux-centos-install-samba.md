## Centos8 安装Samba
source: `{{ page.path }}`

查看centos版本

    rpm -q centos-release

安装Samba

    sudo yum install samba samba-client

开机启动

    sudo systemctl enable --now {smb,nmb}

### 1. 配置firewall

    sudo firewall-cmd --info-service samba
    sudo firewall-cmd --permanent --add-service=samba
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-services

### 2. 配置用户

    sudo adduser -M sambauser -s /sbin/nologin
    sudo smbpasswd -a sambauser

### 3. 配置samba

    [heijunma]
        comment = heijunma guest share  #共享描述
        path = /home/heijunma       #共享目录
        public = yes                #允许guest用户访问
        writable = yes              #允许在heijunma目录下写入
        directory mask = 0775       #默认创建目录权限 rwxrwxr_x
        create mask = 0775          #默认创建文件权限 rwxrwxr_x
        valid users = heijunma,root  #允许访问该共享的用户
        write list = heijunma,root  #可写入共享的用户列表
        browseable = yes             #该指定共享目录可浏览
        available = yes              #该指定共享资源可使用


### 4. 配置SELinux

    sudo chcon -R -t samba_share_t /mnt/shared
    sudo semanage fcontext -a -t samba_share_t "/mnt/shared(/.*)?"
    sudo semanage fcontext -l | grep /mnt/shared

    sudo semanage boolean -l|grep samba
    sudo setsebool samba_enable_home_dirs=1

### 5. 问题

### 6. 参考文献

    [How to install and configure samba on RHEL 8 / CentOS 8](https://linuxconfig.org/install-samba-on-redhat-8)
    [SAMBA 伺服器](http://linux.vbird.org/linux_server/0370samba.php#server_security)
    [Linux samba的配置和使用](https://blog.csdn.net/weixin_40806910/article/details/81917077)
