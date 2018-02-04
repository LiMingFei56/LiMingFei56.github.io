---
layout: page
permalink: /linux/kali/sound
---

### Not Sound
（1）在终端执行命令：systemctl --user enable pulseaudio 
（2）在/etc/default/目录下，创建一个文件，命名为pulseaudio，并添加以下内容：

    PULSEAUDIO_SYSTEM_START=1 
    DISALLOW_MODULE_LOADING=0

