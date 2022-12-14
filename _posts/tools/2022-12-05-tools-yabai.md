---
layout: post
title: Yabai Tiling Window Manager
categories: tools
tags: [tools]
date: 2022-12-05
---

## Yabai Tiling Window Manager

### 1. Disabling System Integrity Protection

    1. 闭机
    2. 常按开机键
    3. Continue until you see Utilities in the menu bar
    4. Select Terminal

    #
    # APPLE SILICON
    #
    
    # If you're on Apple Silicon macOS 12.x.x
    # Requires Filesystem Protections, Debugging Restrictions and NVRAM Protection to be disabled
    # (printed warning can be safely ignored)
    csrutil disable --with kext --with dtrace --with basesystem
    
    #
    # INTEL
    #
    
    # If you're on Intel macOS 12.x.x or Intel macOS 11.x.x
    # Requires Filesystem Protections and Debugging Restrictions to be disabled (workaround because --without debug does not work)
    # (printed warning can be safely ignored)
    csrutil disable --with kext --with dtrace --with nvram --with basesystem

    csrutil disable


    sudo nvram boot-args=-arm64e_preview_abi

+ [Disabling System Integrity Protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

### install yabai

    1. brew install koekeishiya/formulae/Yabai
    2. brew services start yabai
    3. sudo visudo -f /private/etc/sudoers.d/yabai
    
    # input the line below into the file you are editing.
    #  replace <yabai> with the path to the yabai binary (output of: which yabai).
    #  replace <user> with your username (output of: whoami). 
    #  replace <hash> with the sha256 hash of the yabai binary (output of: shasum -a 256 $(which yabai)).
    #   this hash must be updated manually after running brew upgrade.
    
    <user> ALL=(root) NOPASSWD: sha256:<hash> <yabai> --load-sa

    4. # for this to work you must configure sudo such that
    # it will be able to run the command without password

    yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    sudo yabai --load-sa

    

### update yabai

    1. brew services stop yabai
    2. brew upgrade Yabai
    3. brew services start yabai

### install skhd

    1. brew install koekeishiya/formulae/skhd
    2. brew edit skhd

    # 让skhd使用bash, 不然会慢[Adding helper for Karabiner-Elements bindings](https://github.com/koekeishiya/yabai/issues/267)
    3. in the daemon plist declaration

        <key>SHELL</key>
        <string>/bin/dash</string>

    4. brew reinstall skhd

### start services

    chmod +x ~/.config/yabai/yabairc
    chmod +x ~/.config/skhd/skhdrc
    brew services start skhd
    brew services start yabai

## Reference
+ [Install a Tiling Window Manager on Your Mac (Yabai)](https://blog.dsubachev.com/install-a-tiling-window-manager-on-your-mac/)
+ [ julian-heng / yabai-config Public](https://github.com/julian-heng/yabai-config/blob/master/yabairc)
