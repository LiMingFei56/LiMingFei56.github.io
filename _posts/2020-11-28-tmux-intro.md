---
layout: post
title: "Tmux Intro"
categories: tools
tags: [tools]
date: 2020-11-28
excerpt: "Tmux Intro"
---

## Tmux Intro

### Tmux Session

    tmux new -s <session-name>
    tmux detach
    tmux ls
    tmux attach -t 0
    tmux attach -t <session-name>
    tmux switch -t 0
    tmux switch -t <session-name>
    tmux rename-session -t 0 <new-name>

    Ctrl+b d 分离当前会话
    Ctrl+b s 列出session
    Ctrl+b $ 重命名当前会话

### Tmux Windows

    tmux new-window

    # 新建一个指定名称的窗口
    $ tmux new-window -n <window-name>

    # 切换到指定编号的窗口
    $ tmux select-window -t <window-number>

    # 切换到指定名称的窗口
    $ tmux select-window -t <window-name>

    Ctrl+b c：创建一个新窗口，状态栏会显示多个窗口的信息。
    Ctrl+b p：切换到上一个窗口（按照状态栏上的顺序）。
    Ctrl+b n：切换到下一个窗口。
    Ctrl+b <number>：切换到指定编号的窗口，其中的<number>是状态栏上的窗口编号。
    Ctrl+b w：从列表中选择窗口。
    Ctrl+b ,：窗口重命名。

### Tmux Pane

    tmux split-window -h
    tmux split-window
    # 光标切换到上方窗格
    tmux select-pane -U
    # 光标切换到下方窗格
    tmux select-pane -D
    # 光标切换到左边窗格
    tmux select-pane -L
    # 光标切换到右边窗格
    tmux select-pane -R

    ctrl+b % 垂直分屏
    ctrl+b " 水平分屏

    ctrl+b o 依次切换当前窗口下的各个pane
    ctrl+b Up|Down|Left|Right 根据按箭方向选择切换到某个pane
    Ctrl+b ;：光标切换到上一个窗格
    Ctrl+b {：当前窗格与上一个窗格交换位置。
    Ctrl+b }：当前窗格与下一个窗格交换位置。
    Ctrl+b Ctrl+o：所有窗格向前移动一个位置，第一个窗格变成最后一个窗格。
    Ctrl+b Alt+o：所有窗格向后移动一个位置，最后一个窗格变成第一个窗格。

    ctrl+b Space 对当前窗口下的所有pane重新排列布局，每按一次，换一种样式
    ctrl+b z 最大化当前pane。再按一次后恢复
    Ctrl+b !：将当前窗格拆分为一个独立窗口。
    Ctrl+b Ctrl+<arrow key>：按箭头方向调整窗格大小。

    ctrl+b x 关闭当前使用中的pane

    Ctrl+b q：显示窗格编号。

### Tmux Other

    # 列出所有快捷键，及其对应的 Tmux 命令
    $ tmux list-keys

    # 列出所有 Tmux 命令及其参数
    $ tmux list-commands

    # 列出当前所有 Tmux 会话的信息
    $ tmux info

    # 重新加载当前的 Tmux 配置
    $ tmux source-file ~/.tmux.conf

### tmuxinator

   tmuxinator new [project]
   tmuxinator new --local [project]

### Reference
[tmux/tmux](https://github.com/tmux/tmux/)
[Tmux 使用教程](http://www.ruanyifeng.com/blog/2019/10/tmux.html)
[tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator)
