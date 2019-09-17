#include <stdio.h>

/**
判断文件结尾
1. 操作系统使用Ctrl+Z来标志文件结尾
2. 操作系统存储文件大小的信息

C语言在stdio.h中定义了EOF

#define EOF (-1)

键盘输入会使用行缓冲输入, 按回车键时就把输入的字符串传给程序, 需要注意处理换行符
*/
int main (void)
{
    int ch;
    while((ch = getchar()) != EOF)
        putchar(ch);

    return 0;
}
