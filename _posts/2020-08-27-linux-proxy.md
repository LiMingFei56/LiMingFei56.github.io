---
layout: post
title: "Unix proxy config"
categories: linux
tags: [proxy]
date: 2020-08-27
excerpt: "Unix proxy config"
---

## Unix proxy config

    # bash
    export http_proxy=http://127.0.0.1:your port
    export https_proxy=http://127.0.0.1:your port
    export no_proxy=127.0.0.1,localhost

    # fish
    set -Ux http_proxy http://127.0.0.1:your port
    set -Ux https_proxy http://127.0.0.1:your port
    set -Ux no_proxy 127.0.0.1,localhost

    # del evn
    export http=
    set -e ...


### Reference

