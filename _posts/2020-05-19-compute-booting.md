---
layout: post
title: "计算机引导"
categories: compute
tags: [booting]
date: 2020-05-19
excerpt: "计算机引导"
---

## 计算机引导

> 计算机通电后会运行主板上的特定程序(老主板BIOS, 新主板UEFI). 该程序会通电自检, 并
> 且读取基本设置项, 完成后会找到用户配置的主引导项(bootloader), 并且启动它.
>
> BIOS已经过时, Intel决定在2020年前使用UEFI全部替换BIOS.

BIOS启动:
BIOS->MBR->DPT->PBR->Bootloader->操作系统

UEFI
UEFI->ESP分区->bootloader->操作系统

### BIOS

> BIOS是`Basic Input-Output system`的简写, 保存在主板的只读内存芯片里(可以使用
> 特殊方式刷新BIOS程序).
> 
> BIOS一般使用ROM或NVRAM作为芯片, ROM又分为ROM(只读, 不可擦除), EPROM(电可编程只
> 读存储器), EEPROM(电可擦只读存储器). NVRAM(非易失性随机访问存储器)分为nor flash和
> nand flash. 演进过程:
> ROM->PROM->EPROM->EEPROM->nor flash->nand flash
> 主要是从擦除方式, 擦除速度, 次数, 读取速度和方式来优化的.
> 
> 开机启动可以按功能键(Esc, F2, F10, Delete)进入BIOS设置界面, 设置后可以保存内容到
> 主板内存, 下次启动会自动加载. BIOS设置是保存在`CMOS(Complementary Metal Oxide Semiconductor)`
> 中, 是一个随机存储器RAM, 一般集成到主板的南桥芯片组里, 需要一直供电, 不然数据会
> 丢失. 主板上的电池就是为它供电的, 现代主板使用EEPROM取代.

BIOS主要有四大功能:

1. POST(Power-On Self Test),  通电自检, 会检查硬件是否正常, 不正常时使用不同报警声
    来表示错误. 因为自检在加载显卡驱动之前, 所以不能在显示器上显示错误信息.

2. Boot Sequence. 根据CMOS配置的启动顺序查找第一个发现的MBR分区, 512个字节, 最后
    为0x55和0xAA为MBR

3. CMOS设置程序. 配置CMOS, 重新BIOS后, CMOS需要重新配置.

4. 硬件I/O和中断服务. 简单的与硬件交互, 检查或者简单的驱动硬件

BIOS淘汰的原因:
1. 使用16位实模式CPU指令集, 1MB的内存空间, 前640K为基本内存, 后面384K内存留给开机必要硬
    件和各类BIOS本身使用. 启动慢, 功能小, 限制了自身的发展

2. 只支持MBR分区, MBR最大只支持4个主分区, 2TB大小. 当前已经不够用了.

### UEFI

> Intel为了改进BIOS, 在1998年出了EFI(Extensible Firmware Interface), Apple在2006年从
> PowerPC换成Intel时, 选择了EFI, 但是其他公司没有跟随. 直到2007年, Intel把EFI公布
> 出来后, 其他的公司加入, 制作出UEFI(Unified Extensible Firmware Interface)标准, 才
> 流行起来.
>
> UEFI有BIOS支持的所有功能, 并且向后兼容. 老主板只能使用BIOS+MBR, GPT分区硬盘只能
> 作为数据盘, 不能作为引导盘. 新主板支持UEFI+ GPT, 新主板如果开启Legacy BIOS
> , 那么也支持BIOS+MBR. 

主要优点:

1. 可以使用GPT分区, 硬盘容量和分区个数更大.

2. 使用32位和64位指令, 开机可以更快, 更多的驱动硬件设备, 显示更清晰的引导画面.

3. UEFI就像一个微型操作系统, 可以有自己的驱动程序, 是顺序驱动的. 驱动过程有(Secure Boot)
    模式, 驱动过程会检查程序是否被篡改, 不然不允许加载(黑苹果为了模拟白苹果硬件平台, 
    需要篡改硬件的相关信息, 所以要关闭Secure Boot)

4. UEFI先会检查CPU和内存, 如果这两个部件有问题, 不会报警, 屏幕也不会亮, 可以根据主板
    上的指示灯大致判断.

### 分区

#### MBR

> MBR(Master boot record, 主引导记录), 一共只有512个字节.

1. 第1~446字节: 调用操作系统的机器码.
2. 第447-510字节: 分区表(Partition table).
3. 第511~512字节: 主引导记录签名(0x55和0xAA).

分区表(`DPT`)64个字节, 分为4项, 每项16字节(所以最多只能有4个主分区):

1. 第1字节: 0x80表示激活
2. 第2~4字节: 分区第一个扇区的物理地址
3. 第5字节: 主分区类型
4. 第6~8字节: 分区最后一个扇区的物理地址
5. 第9-12字节: 分区第一个扇区的逻辑地址
6. 第13-16字节: 分区扇区总数

> 其中分区扇区总数记录为32位, 最多只能有2^32个扇区, 每个扇区规定大小512B, 那么最大
> 支持为 2^32 * 512 = 2TB. 但是现代512B读取效率不高, 开发了每个扇区4K, 如果不数据
> 不对齐, 那么一次读取写入会跨物理扇区, 所以有个4K对齐,  空出数个扇区, 让每次读4K
> 时在一个扇区里.
>
> 当4个主分区不够时可以使用逻辑分区, 就是在主分区的头部再使用扩展分区表(Extended
> boot record，缩写为EBR). 64字节的分区表最多只有两项, 可以创建2个逻辑分区, 逻辑上
> 可以无限递归下去, 但是没有人会这么做.

* 硬盘启动:

> MBR主分区中只能有一个激活状态的分区, 这个激活状态的分区的第一个扇区叫作`引导
> 记录(VBR OR PBR)`, 指定操作系统第一个启动程序的位置.
>
> 如果操作系统不在主分区, 或者有多个操作系统, 需要修改主引导记录的机器码, 用来
> 指向`启动管理器(Boot loader)`, 如Grub, 由用户选择启动哪一个操作系统.

#### GPT

GPT(全局唯一标识分区表（GUIDPartition Table), 是EFI中定义的新式分区.

优点:
1. 支持更大的硬盘, 更多分区, 更大分区大小.
2. 分区表自带备份, 首尾部分分别保存一份相同的分区表.

> 保护MBR, 为了使不支持GPT分区的操作系统, 错误操作破坏硬盘中的数据, 分区表最开头
> 还是保存了MBR区域, 只是这个区域会保存第一阶段的启动码, 并且标识为0xEE的分区, 以
> 此来表示这块硬盘使用GPT分区表. 不支持GPT分区表的读取这个标识, 为未知分区类型, 不
> 会进一步错误处理.
>
> MBR/GPT混合分区表, 里面保存GPT前4个分区, 可以以MBR启动, 但是只能操作MBR分区表中
> 的分区. 如Boot Camp就是使用这种方式启动Windows.

* 硬盘启动

> 保护MBR中指向bootloader程序, 因此必须通过bootloader程序引用操作系统.

### U盘启动

1. USB-HDD: (占用1个扇区, DOS显示C盘)硬盘仿真模式, 模拟硬盘MBR->DPT->PBR->引导
    , 兼容性好, 但是在只支持USB-ZIP的电脑则无效.
2. USB-HDD+: (占用1个扇区, DOS显示C盘)增强的USB-HDD模式, 提高了兼容性, 但还是
    不能用于USB-ZIP
3. USB-ZIP: (DOS显示A盘), 支持老设备, 新设备支持不好, 大容量支持不好
4. USB-ZIP+: (占用1个扇区, DOS显示C或A盘)增强USB-ZIP, 支持USB-HDD/USB-ZIP双模式, 
    兼容性好, 但是老设备有可能以USB-ZIP启动, 出问题.
5. USB-FDD: 把U盘模拟成软驱, DOS显示A盘
6. USB-CDROM: 光盘仿真模式, DOS不占盘符, 兼容性高
7. FBINST: (占用64个扇区), 在MBR的每个扇区都写入引导代码, 并在每个扇区记录扇区号, 
    这样无论U盘被识别为何种格式, 都可以正常启动



## References

[Eeprom和Flash的区别](https://www.cnblogs.com/Pual623548198/p/7085319.html)
[MBR和EFI启动过程](https://www.cnblogs.com/focus-g/p/11355298.html)
[Intel to Remove Legacy BIOS Support from UEFI by 2020](https://www.anandtech.com/show/12068/intel-to-remove-bios-support-from-uefi-by-2020)
[What Is UEFI, and How Is It Different from BIOS?](https://www.howtogeek.com/56958/htg-explains-how-uefi-will-replace-the-bios/)
[计算机是如何启动的？](http://www.ruanyifeng.com/blog/2013/02/booting.html)
[IT之家学院：浅谈BIOS和CMOS](https://www.ithome.com/html/digi/317426.htm)
[BIOS、EFI与UEFI详解](https://blog.csdn.net/ZhangSong051052/article/details/80670970)
