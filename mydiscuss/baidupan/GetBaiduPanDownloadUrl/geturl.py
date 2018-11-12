#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import pickle
import login
import getdir

class BaiduInfo:
    cookieBaidu = "" # cookie BAIDUID
    cookieBduss = "" # cookie BDUSS
    cookieStoken= "" # cookie Stoken
    bdstoken    = "" # 登陆token
    appId       = "" # 登陆appId
    sign1       = "" # 登陆sign1
    sign2       = "" # 登陆sign2
    sign3       = "" # 登陆sign3

    def save(self):
        with open("data", mode="wb") as f:
            pickle.dump(self, f)

    def read(self):
        with open("data", mode="rb") as f:
            newread = pickle.load(f)
            self.cookieBaidu = newread.cookieBaidu
            self.cookieBduss = newread.cookieBduss
            self.cookieStoken= newread.cookieStoken
            self.bdstoken = newread.bdstoken
            self.appId = newread.appId
            self.sign1 = newread.sign1
            self.sign2 = newread.sign2
            self.sign3 = newread.sign3

command = str(sys.argv[1]) # 命令

if "login" == command:
    if len(sys.argv) > 2:
        baiduinfo = login.login(sys.argv[2], BaiduInfo())
        if baiduinfo or baiduinfo.appId != "":
            baiduinfo.save()
            print("登陆成功")
        else:
            print("登陆失败")
    else:
        print("userfile 为空")
elif "list" == command:
    baiduinfo = BaiduInfo()
    baiduinfo.read()
    if not baiduinfo or baiduinfo.appId == "":
        print("请先登陆")
    else:
        path = str(sys.argv[2]) if len(sys.argv) > 2 else "/"
        responseJson = getdir.getdir(baiduinfo, path)
        print(responseJson)
        if responseJson and responseJson["errno"] == 0:
            fileList = responseJson["list"]
                
            for fileobj in fileList:
                print("a")
        else:
            print("登陆失效或者请求错误")

elif "get" == command:
    print("get")
else:
    print("------------------------------------------")
    print("|                                        |")
    print("|               文档                     |")
    print("|                                        |")
    print("| login <userfile> 登陆，userfile包含Bdus|")
    print("|                  s和stoken的文件       |")
    print("| list  <PATH>   显示文件列表，PATH为路径|")
    print("|                ，默认为根目录          |")
    print("| get   <PATH>   得到直连, PATH为文件路径|")
    print("------------------------------------------")

