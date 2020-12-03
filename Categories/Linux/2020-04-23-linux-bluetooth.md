## Kali 连接蓝牙设备
source: `{{ page.path }}`

### 1. 启动蓝牙服务

    1. 查看蓝牙服务是否开启
    systemctl status bluetooth
    2. 开启蓝牙服务
    systemctl start bluetooth
    3. 开机启动蓝牙服务
    systemctl enable bluetooth

### 2. 连接蓝牙设备(bluetoothctl)

    1. bluetoothctl
    2. power on
    3. agent on
    4. scan on  // 查询到自己的设备
    5. scan off
    6. pair 设备uuid
    7. 开启设备配对模式
    8. connect 设备uuid
