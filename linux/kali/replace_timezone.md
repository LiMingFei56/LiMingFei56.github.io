---
layout: page
permalink: /linux/kali/replace_timezone
---
## replace timezone
tzselect
vim .profile
add a line "export TZ='Asia/Shanghai'" 

function 2
dpkg-reconfigure tzdata
