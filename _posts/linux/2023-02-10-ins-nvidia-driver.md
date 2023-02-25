---
layout: post
title: Install Nvidia Linux Driver
categories: linux
tags: [linux]
date: 2023-02-10
---

## Install Nvidia Linux Driver

### disable nouveau

> Create a file
    sudo nano /etc/modprobe.d/blacklist-nouveau.conf
> With the following contents:
    blacklist nouveau
    options nouveau modeset=0
> Regenerate the kernel initramfs:
    sudo update-initramfs -u
> Finally, reboot:
    sudo reboot



    

## Reference
+ [Install NVIDIA drivers on Ubuntu 18.04](https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux)
+ [Install the Latest Nvidia Linux Driver](https://linuxconfig.org/install-the-latest-nvidia-linux-driver)
+ [NVIDIA developer zone](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#pre-installation-actions)
