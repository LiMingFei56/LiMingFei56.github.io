## mount swap

Use "mkswap" Setting swap
	mkswap /dev/sda5

Use "swapon" Wakeup swap
	swapon /dev/sda5

Auto mount
	vim /etc/fstab
	/dev/sda5 swap swap defaults 0 0
