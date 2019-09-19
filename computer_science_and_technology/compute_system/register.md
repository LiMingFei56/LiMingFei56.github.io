---
layout: page
permalink: ./technology-home/compute-system/register
---

## 寄存器
x86-64: 16个64位寄存器
x86-32:  8个32位寄存器
x86-16:  8个16位寄存器

### x86-64
x86-64 - rax, rbx, rcx, rdx, rdi, rsi, rbp, rsp, r8, r9, r10, r11, r12 r13, r14, r15
x86-32 - eax, ebx, ecx, edx, edi, esi, ebp, esp 
x86-16 -  ax,  bx,  cx,  dx,  di,  si,  bp,  sp

x86-64可以拆成32位使用: x86-32 + r8d, r9d, r10d, r11d, r12d, r13d, r14d, r15d

### 功能说明
ax - 累加器
cx - 计数器
bx, bp - 基址
si, di - 变址
sp - 段, 堆, 栈
