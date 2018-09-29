---
layout: page
permalink: /linux/install_nvidia
---

## Install nvidia

### Debian
    [Debian Install Nvidia Doc](https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_9_.22Stretch.22)

    vim /etc/apt/sources.list

    deb http://httpredir.debian.org/debian stretch-backports main contrib non-free
    deb http://httpredir.debian.org/debian/ stretch main contrib non-free

    // 查看显示型号
    nvidia-detect

    // 安装头文件
    apt-get install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//')
    apt-get install -t stretch-backports linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//')

    // 安装驱动并重启
    apt-get install -t stretch-backports nvidia-driver 
    reboot

    // 配置xorg
    自动配置，安装nvidia-xconfig,并运行一下

    //安装CUDA
    安装apt-get install nvidia-cuda-dev nvidia-cuda-toolkit  nvidia-driver 


### Centos 

    // 禁用nouvean
    1)把驱动加入黑名单中: /etc/modprobe.d/blacklist.conf  在后面加入：
    blacklist nouveau
    2) 使用 dracut重新建立  initramfs image file :
    $ sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
    $ sudo dracut -v /boot/initramfs-$(uname -r).img $(uname -r)
    3) 重启系统至文本模式,init 3 这个可以修改/etc/inittab 文件 init 3是文本模式,
    
       init 5是图形界面模式.重启之后,进入文本模式，其实可以发现字体变大了,也就是说驱动没有被加载,成功禁用了Nouveau
    
    4)检查nouveau driver确保没有被加载！
    $ lsmod | grep nouveau
    5) 运行安装文件
    $ sudo ./NVIDIA-Linux-x86_64-195.36.15-pkg2.run
