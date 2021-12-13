---
layout: post
title: "redis-cli"
categories: tools
tags: [tools]
date: 2021-12-08
---

## redis-cli

### index

		brew install redis

### 连接

		redis-cli -h 123.56.22.107 -a "Equick1234qwerXP." -p 6379

		# select Index
		select 12
		# list keys
		keys *
		# 查看类型
		type "speedex-token-catchexpire"
		# 查看值
		get "speedex-token-catchexpire"
		# 删除值
		del "speedex-catch-token"

### Reference

