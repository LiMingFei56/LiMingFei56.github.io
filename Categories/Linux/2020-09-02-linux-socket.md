## Unix Socket
source: `{{ page.path }}`

### 引用头
    
    #include <arpa/inet.h> definitions for internet operations
    #include <netinet/in.h> Internet address family
    #include <sys/socket.h> main sockets header

### IP Address

<sys/socket.h>中定义

`struct sockaddr` 16个字节, socket函数使用
`struct sockaddr_storage` 128个字节, 定义长的特定的协议地址结构

    struct sockaddr { 
     sa_family_t sa_family;       /* Address family */
     char sa_data[14];            /* protocol-specific address */
    };

    /* Structure large enough to hold any socket address 
      (with the historical exception of AF_UNIX). 128 bytes reserved.  */
 
      #if ULONG_MAX > 0xffffffff
      # define __ss_aligntype __uint64_t
      #else
      # define __ss_aligntype __uint32_t
      #endif
      #define _SS_SIZE        128
     #define _SS_PADSIZE     (_SS_SIZE - (2 * sizeof (__ss_aligntype)))
 
     struct sockaddr_storage
     {
         sa_family_t ss_family;      /* Address family */
         __ss_aligntype __ss_align;  /* Force desired alignment.  */
         char __ss_padding[_SS_PADSIZE];
    };

`sa_family_t`取值:
    * `AF_INET` Internet domain sockets for use with IPv4 addresses.
    * `AF_INET6` Internet domain sockets for use with IPv6 addresses.
    * `AF_UNIX` UNIX domain sockets.
    * `AF_UNSPEC` Unspecified

使用sockaddr 定义地址不方便, 因此有<netinet/in.h>中`sockaddr_in`和`sockaddr_in6`

    struct sockaddr_in {
        sa_family_t sin_family;             /* AF_INET */
        in_port_t sin_port;                 /* Port number.  */
        struct in_addr sin_addr;            /* Internet address.  */

        /* Pad to size of `struct sockaddr'.  */
        unsigned char sin_zero[sizeof (struct sockaddr) -
                              sizeof (sa_family_t) -
                              sizeof (in_port_t) -
                             sizeof (struct in_addr)];
    };
    typedef uint32_t in_addr_t;
    struct in_addr  {
         in_addr_t s_addr;                    /* IPv4 address */
    };

    struct sockaddr_in6 {
        sa_family_t sin6_family;    /* AF_INET6 */
        in_port_t sin6_port;        /* Transport layer port # */
        uint32_t sin6_flowinfo;     /* IPv6 flow information */
        struct in6_addr sin6_addr;  /* IPv6 address */
        uint32_t sin6_scope_id;     /* IPv6 scope-id */
    };
    struct in6_addr {
        union {
         uint8_t u6_addr8[16];
         uint16_t u6_addr16[8];
         uint32_t u6_addr32[4];
        } in6_u;

        #define s6_addr                 in6_u.u6_addr8
        #define s6_addr16               in6_u.u6_addr16
        #define s6_addr32               in6_u.u6_addr32
    };

    sockaddr_un  // AF_UNIX使用

创建`sockaddr_in toaddr`
    
    struct sockaddr_in toAddr;
    memset(&toAddr, 0, sizeof(toAddr));
	toAddr.sin_family = AF_INET;
	toAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
	toAddr.sin_port = htons(4000);

特殊地址:
    * `INADDR_ANY` - 表示所以网卡
    * `INADDR_BROADCAST` - 表示广播地址

特殊端口:
    * 0 - 操作系统选择一个可用的端口

### 网络字节顺序
网络传输需要注意字节顺序, int发送与接收需要使用对应函数统一字节顺序

    <arpa/inet.h>
    uint64_t htonll(uint64_t);
    uint32_t htonl(uint32_t);
    uint16_t htons(uint16_t);

    uint64_t ntohll(uint64_t);
    uint32_t ntohl(uint32_t);
    uint16_t ntohs(uint16_t);

该头文件还包含其他有用的转换函数:
`inet_addr` - 将一个点分十进制的IP转换成一个长整数型数
`inet_ntoa` - 将一个十进制网络字节序转换为点分十进制IP格式的字符串
`inet_ntop` - 支持IPv4 IPv6, “点分十进制”和“二进制整数”之间转换
`inet_pton` - 支持IPv4 IPv6, “点分十进制”和“二进制整数”之间转换

### sockopt
`int setsockopt(int socket, int level, int option_name,
       const void *option_value, socklen_t option_len);`
`int getsockopt(int socket, int level, int option_name,
       void *restrict option_value, socklen_t *restrict option_len);`

socket：指向一个打开的套接字描述符
level：`选项定义的层次；支持SOL_SOCKET、IPPROTO_TCP、IPPROTO_IP和IPPROTO_IPV6`
`option_name`：选项名字
`option_value`：指向某个变量的指针，setsockopt从`option_value`中取得选项待设置的新值，getsockopt把已获取的选项当前值存放在`option_value`中。
`option_len`: `option_value` 长度

设置socket 选项

    SO_ACCEPTCONN
        Socket is accepting connections.
    SO_BROADCAST
        Transmission of broadcast messages is supported.
    SO_DEBUG
        Debugging information is being recorded.
    SO_DONTROUTE
        Bypass normal routing.
    SO_ERROR
        Socket error status.
    SO_KEEPALIVE
        Connections are kept alive with periodic messages.
    SO_LINGER
        Socket lingers on close.
    SO_OOBINLINE
        Out-of-band data is transmitted in line.
    SO_RCVBUF
        Receive buffer size.
    SO_RCVLOWAT
        Receive ``low water mark''.
    SO_RCVTIMEO
        Receive timeout.
    SO_REUSEADDR
        Reuse of local addresses is supported.
    SO_SNDBUF
        Send buffer size.
    SO_SNDLOWAT
        Send ``low water mark''.
    SO_SNDTIMEO
        Send timeout.
    SO_TYPE
        Socket type.

### Socket
<sys/socket.h>

1. `int socket(int domain, int type, int protocol);`
domain - 同`sa_family_t`取值, 设定协议族
type - 
    * `SOCK_STREAM` tcp
    * `SOCK_DGRAM` udp
    * `SOCK_SEQPACKET` 
protocol - 一般填0, 使用默认协议
    * `IPPROTO_IP` Internet protocol.
    * `IPPROTO_IPV6` Internet Protocol Version 6
    * `IPPROTO_ICMP` Control message protocol.
    * `IPPROTO_RAW`  Raw IP Packets Protocol.
    * `IPPROTO_TCP` Transmission control protocol.
    * `IPPROTO_UDP` User datagram protocol.

return - 当返回大于0, 就是socket fd; 小于等于0, 为失败

2. `int bind(int socket, const struct sockaddr *address,
       socklen_t address_len);`
socket - socket fd
address - 地址
`address_len` - 地址长度

return - 大于等于0成功, 小于0失败

3. `int listen(int socket, int backlog);`
socket - socket fd
backlog - 等待最大连接数

return - 大于等于0成功, 小于0失败

4. `int accept(int socket, struct sockaddr *restrict address,
       socklen_t *restrict address_len);`
socket - socket fd
address - 地址
`address_len` - 地址长度

return - 大于等于0成功, 小于0失败

5. `int connect(int socket, const struct sockaddr *address,
       socklen_t address_len);`
socket - socket fd
address - 地址
`address_len` - 地址长度

return - 大于等于0成功, 小于0失败

** 读和写 **
写
1. `ssize_t send(int socket, const void *buffer, size_t length, int flags);`
2. `ssize_t sendto(int socket, const void *message, size_t length,
       int flags, const struct sockaddr *dest_addr,
       socklen_t dest_len);`
3. `ssize_t sendmsg(int socket, const struct msghdr *message, int flags);`

读
1. `ssize_t recv(int socket, void *buffer, size_t length, int flags);`
2. `ssize_t recvfrom(int socket, void *restrict buffer, size_t length,
       int flags, struct sockaddr *restrict address,
       socklen_t *restrict address_len);`
3. `ssize_t recvmsg(int socket, struct msghdr *message, int flags);`

send rece : 一般使用有连接的Socket, 不允许检索数据源地址
sendto recvfrom: 一般使用无连接的Socket
sendmsg recvmsg: 一般使用无连接的Socket

flag - 一般传0
    MSG_CTRUNC
        Control data truncated.
    MSG_DONTROUTE
        Send without using routing tables.
    MSG_EOR
        Terminates a record (if supported by the protocol).
    MSG_OOB
        Out-of-band data.
    MSG_NOSIGNAL
        No SIGPIPE generated when an attempt to send is made on a stream-oriented socket that is no longer connected.
    MSG_PEEK
        Leave received data in queue.
    MSG_TRUNC
        Normal data truncated.
    MSG_WAITALL
        Attempt to fill the read buffer.

**  关闭连接 **
1. `int shutdown(int socket, int how);` tcp 需要先shutdown
how - 
    * `SHUT_RD` Disables further receive operations.
    * `SHUT_WR` Disables further send operations.
    * `SHUT_RDWR` Disables further send and receive operations.

2. `<unistd.h> int close(int fildes);` 关闭 socket fd



### Reference
[arpa/inet.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/arpa_inet.h.html#tag_13_02)  
[netinet/in.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/netinet_in.h.html)  
[sys/socket.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_socket.h.html#tag_13_60)  
[unistd.h](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/unistd.h.html#tag_13_77)  
[套接字选项入门](https://zhuanlan.zhihu.com/p/59712124)  
