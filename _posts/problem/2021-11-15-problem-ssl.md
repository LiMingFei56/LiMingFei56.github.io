---
layout: post
title: "SSL error: dh key is too small"
categories: problem
tags: [problem]
date: 2021-11-15
---

## SSL error: dh key is too small

		# 允许使用短dh key
		sudo update-crypto-policies --set LEGACY

### Reference
[SSL error 'dh key is too small', when connecting to SQL Server using ODBC 17 and Laravel on Centos 8](https://stackoverflow.com/questions/60676042/ssl-error-dh-key-is-too-small-when-connecting-to-sql-server-using-odbc-17-and)
