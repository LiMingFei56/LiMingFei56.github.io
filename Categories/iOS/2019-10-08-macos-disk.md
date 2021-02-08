## 安装Xcode 11.1 提示Not enough disk space
source: `{{ page.path }}`

看App store Xcode 11.1的包是8G, 那么我的可用空间是20G应该够了. 但是安装程序不是这
么算的.  

* 下载包 -- 8G  
* 解压包 -- 12G左右 压缩比算2/3  
* 安装   -- 15G  
* 操作系统交换空间 -- 8 ~ 15G  
那么最少需要40 ~ 50G  

## 清理macOS
1. 使用命令du -sh  
2. 主要清理Users目录  
3. 缓存 ~/Library/Caches 和 ~/Library/Application Support 主要是浏览器及开发模拟器  
    占用大  
4. 磁盘管理(About this mac), 清理Time machine  
