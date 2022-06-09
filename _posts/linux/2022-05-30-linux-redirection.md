---
layout: post
title: "Linux Redirection"
categories: linux
tags: [linux]
date: 2022-05-30
---

## Linux Redirection

	|  type  | symbol | num | remark       |
	|--------|--------|-----|--------------|
	| output |   >    |  1  |  overwritten |
	| output |   >>   |  1  |  add more    |
	| input  |   <    |  0  |              |
	| errout |   >    |  2  |              |
	| errout |   >>   |  2  |              |


	ls Documents ABC> dirlist 2>&1


### Reference
[Input Output Redirection in Linux/Unix Examples](https://www.guru99.com/linux-redirection.html)  
