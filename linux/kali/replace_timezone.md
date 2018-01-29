## replace timezone
tzselect
vim .profile
add a line "export TZ='Asia/Shanghai'" 

function 2
dpkg-reconfigure tzdata
