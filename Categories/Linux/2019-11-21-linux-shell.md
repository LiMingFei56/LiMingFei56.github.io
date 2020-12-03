# Kali linux 脚本执行报 ---  [: 11: y: unexpected operator
source: `{{ page.path }}`

debian系的发行版本默认使用dash, 跟bash是不兼容的, 所以导致报错

使用bash ***\*.sh 来执行, 如果正常就是dash的原因

使用`sudo dpkg-reconfigure dash` 选择no, 设置成bash

