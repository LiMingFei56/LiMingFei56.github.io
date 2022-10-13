---
layout: post
title: macos install 2.7
categories: macos
tags: [macos]
date: 2022-10-09
---

## macos install 2.7

    brew install openssl openssl@1.1 readline sqlite3 xz zlib pyenv
    export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
    pyenv install 2.7.18


## Reference
