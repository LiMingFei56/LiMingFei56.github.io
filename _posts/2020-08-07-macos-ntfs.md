---
layout: post
title: "macOS 使用NTFS 或者 ext格式硬盘"
categories: macos
tags: [macos]
date: 2020-08-07
excerpt: "macOS 使用NTFS 或者 ext格式硬盘"
---

## macOS 使用NTFS 或者 ext格式硬盘

1. install osxfuse
2. install ntfs-3g ext2fuse ext4fuse
3. reboot
4. disable system integrity protection    `csrutil disable`

sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk3s1 ~/ntfs-volume


### Reference
[Write to NTFS on macOS Sierra (osxfuse + ntfs-3g)](https://gist.github.com/takeit/9fa83840f3b2065e204dc9d52cef3693)
[How to enable NTFS 3G?](https://apple.stackexchange.com/questions/266132/how-to-enable-ntfs-3g)
