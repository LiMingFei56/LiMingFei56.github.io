## 红外线传感器
source: `{{ page.path }}`

### 接线
> GPIO 接1, 6, 12

> 传感器 S向上
  1. OUT 对GPIO12
  2. 3V 对GPIO1
  3. GND 对GPIO6

> 红外线传感器一般有4条线, 电源(3v), 接地, 输出(txout), 输入(irin). 有些只有输出信号.
> 这里的输出信号为, 传感器接收到红外信息后, 使用输出线传送信号.


### LIRC模块

1. 安装

  sudo apt-get install lirc -y

2. /boot/config.txt

  # Uncomment this to enable infrared communication.
  #dtoverlay=lirc_rpi
  #dtoverlay=gpio-ir,gpio_pin=17
  #dtoverlay=gpio-ir-tx,gpio_pin=18

> 老版本内核中才有lirc_rpi模块
> 当前如果只有输出信息, 那么只用开gpio-ir. 如果也有输入信息, gpio-ir-tx也打开
> gpio_pin 对应传感器接入的值

3. /etc/lirc/hardware.conf

  LIRCD_ARGS="--uinput --listen"
  LOAD_MODULES=true
  DRIVER="default"
  DEVICE="/dev/lirc0"
  MODULES="lirc_rpi"

4. /etc/lirc/lirc_options.conf

  #driver         = devinput
  #device         = auto
  driver          = default
  device          = /dev/lirc0

### Remote Controller Registration

> 配置红外线遥控器

1. sudo irrecord -d /dev/lirc0 --disable-namespace   得到配置文件格式
2. sudo mode2 -m -d /dev/lirc0 > <remote_controller_name>.lircd.conf 得到按键的值

## Reference
[GPIO](https://www.raspberrypi.org/documentation/usage/gpio/)  
[\[Stretch/Buster\] Using LIRC with kernel 4.19.X and gpio-ir](https://www.raspberrypi.org/forums/viewtopic.php?t=235256)  
[RPI with IR Receiver  树莓派之红外接收器](https://www.kidscoding8.com/47208.html)  
[红外线遥控](https://item.taobao.com/item.htm?_u=i34it4925a1&id=528797815847)  
[树莓派红外遥控 (lirc、gpio-ir)](http://www.xiaoheidiannao.com/211340.html)  
[Easy Setup IR Remote Control Using LIRC for the Raspberry PI (RPi) - July 2019 [Part 1]](https://www.instructables.com/Setup-IR-Remote-Control-Using-LIRC-for-the-Raspber/)  
[Turning Raspberry PI into Remote Controller](https://devkimchi.com/2020/08/12/turning-raspberry-pi-into-remote-controller/)  
[树莓派 红外接收 RPi2 gpio chip not found lirc_rpi](https://blog.csdn.net/ohhpo/article/details/44354687)  
