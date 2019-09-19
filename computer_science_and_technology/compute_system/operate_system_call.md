---
layout: page
permalink: ./technology-home/compute-system/operator-system-call
---

## Operator System Call

### macOS

[Apple Open Source](https://opensource.apple.com/release/macos-10145.html)
[Apple Darwin XNU](https://github.com/apple/darwin-xnu)

#### 1. 查看系统调用

/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk 1/usr/include/sys/syscall.h

定义所有的系统调用

#### 2. 查看系统调用原型
下载`XNU`源码, bsd/kern/syscalls.master中

#### 3. 调用系统函数
maxOS内核XNU分为BSD层和Mach-O层, 常用的系统调用在BSD层, BSD层位于Mach-O层上面, 
BSD层要从0x2000000开始, 那么系统调用就等于0x2000000 + 调用码.  因此: 调用SYS_exit 1

    movq    $0x2000001, %rax
    movq    $0, %rdi
    syscall

    等于
    int main() 
    {
        exit(0);
    }

---- return vs exit(0)

    int main()
    {
        return 0;
    }

    等于

    retq

/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk 1/usr/lib/crt1.o

    int rVal = main(argc, argv);
    exit(rVal);
