## Centos 配置静态IP
source: `{{ page.path }}`

配置文件在/etc/sysconfig/network-scripts, 该目录下找到网卡对应的配置文件, ifcfg-enp2s0

  BOOTPROTO="dhcp" 动态IP
  BOOTPROTO="static" 静态IP

  IPADDR="192.168.3.30"
  GATEWAY="192.168.3.1"
  NETMASK="255.255.255.0"
  DNS1="192.168.3.1"
  DNS2="8.8.8.8"
  ZONE="public"

## 使用路由器绑定IP

  使用路由器提供的`静态IP地址绑定`功能

## 静态IP设置后, 需要手动设置DNS

  静态IP设置后, DNS就不能自动获取了


