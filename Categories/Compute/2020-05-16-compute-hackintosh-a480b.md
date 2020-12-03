## Hackintosh-A480B-i7GD1
source: `{{ page.path }}`

### 准备

1. macOS.dmg 镜像, 黑果小兵那下载
2. balenaEtcher-Setup-1.5.45.exe 镜像刻录到U盘
3. DiskGenius 分区
4. A480B-master 配置好的A480BEFI

### 配置bios

> 按照网上教程配置自己的bios， a480b的bios没有可以配置的项

### 安装

> 刻录好后直接U盘启动， 发现Clover乱码， 把上面A480B里的EFI替换进入后正常。

> 第一次进入只有一个盘符， 选择后先分区再安装， 分区选择GUID, 格式选择APFS。 
> 我选择的是macOS 10.15.4 19E2269, 安装时会自动把硬盘格式化成APFS。

> 安装macOS时会重启多次， 这是正常的， 第二次进入会多一个盘符， 选择多的盘符，
> 继续安装macOS。 我这边安装第二次后， 第二个盘符不见了， 进入分区管理发现硬盘格式
> 为APFS, 使用小兵的EFI发现可以识别第二个盘符。 以此判断A480B的efi不识别APFS。
> 但是drivers64UEFT目录里也有`apfs.efi`和`ApfsDriverLoader.efi`

老主板： clover 需要drivers和drivers64目录
新主板： clover 需要drivers64UEFI

> 我把A480B中的drivers64UEFI目录复制一份， 改名为drivers64， 解决上面问题




### Reference
[黑果小兵](https://blog.daliansky.net/)
[wklxd/A480B](https://github.com/wklxd/A480B)
