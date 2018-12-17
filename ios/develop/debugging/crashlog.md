---
layout: page
permalink: /ios/develop/debugging/crashlog
---

## Crash Log

### dSYM文件
Crash日志一般记录的是调用堆栈的地址信息,为了方便阅读,需要用地址信息定位到代码中.
每次应用编译后会生成dSYM文件,该文件保存地址和函数的映射表,通过这个表可以定位到代码.

### dSYM文件UUID
因为应用每次编译后都会生成新的dSYM文件,每个文件有不同的UUID.我们需要比对dSYM文件和Crash日志
文件的UUID是否一样, 如果一样才能定位.

* 查看dSYM文件UUID

    Xcode -> Window -> organizer -> 右键选择对应的版本Show in Finder -> 右键Show package Content ->
        dSYMs文件夹下就是dSYM文件.

    dwarfdump --uuid AppName.app.dSYM/
    UUID: 7DC709D2-4AC8-347C-8AA1-3AB7B4BA5B5D (armv7) 便民通.app.dSYM/Contents/Resources/DWARF/便民通
    UUID: 94ED1EBC-9000-32E9-BE18-4350DEB55C1D (arm64) 便民通.app.dSYM/Contents/Resources/DWARF/便民通
           {UUID}                            {对应的设备}

* 查看CrashLog的UUID

    Binary Images下面一行就有UUID

    Binary Images:
    0x1000ac000 - 0x100c13fff Example arm64 <e86bcc8875b230279c962186b80b466d> /var/containers/Bundle/Applic
                                                    {UUID}

### 分析CrashLog
    需要symbolicatecrash工具, 在~目录下执行

    find /Applications/Xcode.app -name symbolicatecrash -type f

    /Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash

    把crash日志,symbolicatecrash工具,dSYM文件放到一个目录里

    export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
    symbolicatecrash xxx.crash xxx.app.dSYM > test.txt

### 为什么 crash log 内 Exception Backtrace 部分的地址（stack address）不能从 dsym 文件中查出对应的代码？
为了防止缓冲区攻击,编译时实现了ASLR(Address space layout randomization), 每次启动都不一样
symbol address = stach address - slide;

* 运行时获取slide

    dyld_get_image_vmaddr_slide()  

    void calculate(void) {
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        if (_dyld_get_image_header(i)->filetype == MH_EXECUTE) {
             long slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    }

* binary image和ELF文件的load command计算

    slide = (运行时)load address - (链接时)load address;

    获取ELF(运行时映射文件), 查看segment _TEXT 这个段是代码段

    otool -l AppName.app/AppName // .app文件同dSYM文件获取, 只是在product目录下, 还要对应UUID下

    segname __TEXT  
    vmaddr 0x0000000100000000  
    vmsize 0x000000000000c000  
    fileoff 0  
    filesize 49152

没有 ASLR机制时：

    加载时 装载器会将此 ELF 文件的 前 49152 （offset 0 ，filesize 49152）个字节（因为 offset 0 ，filesize 49152）映射到 进程空间以  0x0000000100000000 开始的一块虚拟内存空间里. 

有ASLR 机制时：

    加载时 装载器会将此 ELF 文件的 前 49152 （offset 0 ，filesize 49152）个字节（因为 offset 0 ，filesize 49152）映射到 进程空间以  0x0000000100000000 （+slide）开始的一块虚拟内存空间里. 

    所以 ： 如果没有 ASLR 机制，那么运行时的内存布局 就和  Load command 中指定的布局一致，也就意味着stack address和 symbol address 一致有 ASLR 的情况也不复杂，只是 加了一个 随意的偏移量 slide 


    binary image:
    Binary Images:
    0x10003c000 - 0x100f7bfff MedicalRecordsFolder arm64  <b5ae3570a013386688c7007ee2e73978> /var/.../MedicalRecordsFolder
    0x12007c000 - 0x1200a3fff dyld arm64  <628da833271c3f9bb8d44c34060f55e0> /usr/lib/dyld
        {虚拟地址空间区块}   {映射文件}     {uuid}                              {映射文件路径}

    0x10003c000 - 0x100f7bfff 起始地址为0x10003c000
    vmaddr 0x0000000100000000 实际地址为0x0000000100000000
    slide =  0x10003c000 - 0x100000000 = 0x3c000;
    symbol address = stack address - slide;
    stack address 在crash log 中已经找到了

    dwarfdump --arch arm64 --lookup 0x00123 MedicalRecordsFolder.app.dSYM/  // 就可以定位代码了

地址说明:

    * Stack Address               Crash File, Exception Backtrace
    * Load  Address               Crash File, Exception Backtrace
    * dSYM(Symbol File)UUID       Crash File, Binary Images(See "Verifying Your Symbols File")
    * Binary Architecture(Compiled for) Crash File, Binary Images
    * Slide Value                 dSym File(See "Getting the Slide Value")
    * Symbol Offset               Crash File, Exception Backtrace
    * File Address                Derived: file address = stack address - load address + slide
                                  or     : file address = symbol offset + slide

    Crash文件
    12  便民通                              0x00000001006e1090 0x10063c000 + 675984
    Stack Address（栈地址）         0x00000001006e1090
    Load Address（首地址）          0x10063c000
    Symbol Offset（偏移量）         675984


atos -arch \<architecture\> -o \<binary filename\> -l \<load address\> \<stack address 1\> \<stack address 2\> ...
