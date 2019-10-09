---
layout: page
permalink: ./technology-home/compute-system/link
---

## Link

### C语言内嵌汇编

        asm volatile(可选, 编译器不优化) ( assembler template         /* 汇编语句 */
            : output operands                  /* 输出 */
            : input operands                   /* 输入 */
            : list of clobbered registers     
            );

         asm volatile (
                "movl %1, %0\n" // 通过占位符指定交互的变量
                : "=r"(result)      // 输出变量，与汇编交互
                : "r"(input)            // 输出变量，与汇编交互
        // 这里的r指示编译器自动将通用寄存器关联到变量
                );


常用限制符说明
r   通用寄存器
a   eax, ax, al
b   ebx, bx, bl
c   ecx, cx, cl
d   edx, dx, dl
S   esi, si
D   edi, di
q   寄存器a, b, c, d
m   使用合法内存代表参数
g   任意寄存器, 内存, 立即数

使用系统服务完成打印

        asm volatile(
            "movl $4, %%eax\n"      //
            "movl $1, %%ebx\n"
            "movl %0, %%ecx\n"
            "movl %1, %%edx\n"
            "int $0x80     \n"
            :
            : "r"(s), "r"(l)
            : "eax", "ebx", "ecx", "edx"
        );

注意：
1.内嵌汇编时，除汇编模板外，其余参数都可以省略
2.当省略的参数在中间时，对应分隔符":"不可省略
3.当省略保留列表时，对应得到分隔符":"可以省略
4.当省略可选参数时，寄存器前使用单个%作为前缀
当存在可选参数时，寄存器前使用两个%%作为前缀



### macOS
动态链接, as默认使用动态链接

使用otool查看动态链接库 otool -L xxx.dylib or app

macOS动态库为.dylib, 系统调用 为libSystem.dylib 软链接到/usr/lib/libSystem.B.dylib


linux 下头文件一般都在：
* /usr/include
* /usr/local/include
* /usr/lib/gcc-lib/xxx/xxx/include


macOS 下头文件和开发库都被Xcode接管了, 所以安装Xcode后才有:
* /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
* /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
