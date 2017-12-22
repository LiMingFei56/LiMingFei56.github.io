---
layout: page
permalink: /operate-system/like-unix/common-command
---

Common Command

#### 遍历目录下的所有文件，指定替换文件内容

grep -i "default" -r . |awk -F : '{print $1}' | sort | uniq | xargs sed -i 's/default/c/g'

因为在MacOS和Linux平台下 Sed的i选项实现不一样，MacOS要求提供备份文件名，如果不需要在MacOS上可以这样

grep -i "default" -r . |awk -F : '{print $1}' | sort | uniq | xargs sed -i '' 's/default/c/g'
