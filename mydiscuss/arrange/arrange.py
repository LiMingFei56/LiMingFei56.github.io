#!/bin/env python3

import sys
import os
import shutil
import re

def extractFile(rootpath, arrpath): 
    dirs = os.listdir(arrpath)
    for filename in dirs:
        if filename[0] == '.':
            continue

        filepath = os.path.join(arrpath, filename)
        isdir = os.path.isdir(filepath)        
        if isdir:
            extractFile(rootpath, filepath)
        elif rootpath != arrpath:
            filesize = os.path.getsize(filepath)
            if filesize >= 100: # 104857600:
                shutil.move(filepath, os.path.join(rootpath, repeatFile(rootpath, filename)))    
        
def repeatFile(path, name):
    filename = name
    index = 1
    while os.path.exists(os.path.join(path, filename)):
        filename = '{} ({})'.format(name, index)
        index += 1
    return filename
    
def ruleFile(path):
    dirs = os.listdir(path)
    for filename in dirs:
        if filename[0] == '.':
            continue

        match = re.match(r'.*?([0-9]*?[A-Z|a-z]+)-?([0-9]+).*?(\..+)', filename)
        if match:
            newfilename = '{}-{}{}'.format(match.group(1).upper(), match.group(2), match.group(3))
            shutil.move(os.path.join(path, filename), os.path.join(path, newfilename))

def deleteNameChar(path, char):
    dirs = os.listdir(path)
    for filename in dirs:
        if filename[0] == '.':
            continue

        if filename.rfind(char) != -1:
            newfilename = filename.replace(char, '')
            shutil.move(os.path.join(path, filename), os.path.join(path, newfilename))
        
    

paramLen = len(sys.argv)

if paramLen < 2 :
    print("请输入参数")
else :
    command = sys.argv[1]
    if '-e' == command:
        print("提取文件")
        extractFile(sys.argv[2], sys.argv[2])
    elif '-r' == command:
        print("规则文件名")
        ruleFile(sys.argv[2])
    elif '-d' == command:
        print("删除字符")
        deleteNameChar(sys.argv[2], sys.argv[3])
    else:
        print("-e 整理 -r 规则 -d 删除")
