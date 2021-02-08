## Crontab
source: `{{ page.path }}`

### Crontab 环境说明

* 服务地址: /usr/lib/systemd/system/crond.service
* 命令: /usr/bin/crontab
* 配置: /etc/crontab; /var/spool/(不能删除); cron.d/; cron.daily/; cron.hourly/; cron.monthly/; cron.weekly/
* 日志: /var/log/cron

### Crontab -e 编辑

f1 f2 f3 f4 f5 program

* 其中 f1 是表示分钟，f2 表示小时，f3 表示一个月份中的第几日，f4 表示月份，f5 表示一个星期中的第几天。program 表示要执行的程序。
* 当 f1 为 \* 时表示每分钟都要执行 program，f2 为 * 时表示每小时都要执行程序，其馀类推
* 当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其馀类推
* 当 f1 为 \*/n 时表示每 n 分钟个时间间隔执行一次，f2 为 \*/n 表示每 n 小时个时间间隔执行一次，其馀类推
* 当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其馀类推
* 当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其馀类推

* f1: 分钟 (0 - 59)
* f2: 小时 (0 - 23)
* f3: 一个月中的第几天 (1 - 31)
* f4: 月份 (1 - 12) 
* f5: 星期中星期几 (0 - 7) (星期天 为0)

### Crontab 注意事项

1. 命令最好使用shell脚本
2. shell脚本中最好配置好环境
3. shell脚本中最好使用全路劲

在 /etc/crontab 中添加环境变量，在可执行命令之前添加命令 . /etc/profile;/bin/sh，使得环境变量生效，例如：

    20 03 * * * . /etc/profile;/bin/sh /var/www/runoob/test.sh

### Crontab 例子

    SHELL=/bin/bash
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root
    HOME=/
    # For details see man 4 crontabs
    # Example of job definition:
    # .---------------- minute (0 - 59)
    # | .------------- hour (0 - 23)
    # | | .---------- day of month (1 - 31)
    # | | | .------- month (1 - 12) OR jan,feb,mar,apr ...
    # | | | | .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # | | | | |
    # * * * * * user-name command to be executed

## Reference
[crontab(1) - Linux man page](https://linux.die.net/man/1/crontab)  
