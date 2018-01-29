## network config

### 1. put on wlan0 interfaces config
	vim /etc/network/interfaces

### 2. add line
    auto wlan0
	allow-hotplug wlan0
	iface wlan0 inet dhcp
	
	wpa-ssid "lmf413zwj" 
    wpa-psk "Zwj$!#lmF56"

### 3. get network config
	wpa_passphrase "lmf413zwj" "Zwj$!#lmF56"

### 4. config wpa-supplicant 
	vim /etc/wpa_supplicant/wpa_supplicant.conf

	network={
		ssid="lmf413zwj"
		#psk="Zwj#lmF56"
		psk=5a6fc788dfc0428e31409f59b1b583c2524c4a2aee8ce5cd5dfc4e0257ad4365
		scan_ssid=1
		priority=1
		id_str="homeOne"
	}

