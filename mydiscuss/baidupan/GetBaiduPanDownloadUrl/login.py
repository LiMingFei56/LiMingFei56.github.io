import myhttp
import re
import json

def login(userfile, userinfo):
    with open(userfile, mode="r", encoding="utf-8") as f:
        for textline in f:
            equalsMarkIndex = textline.index("=")
            paramname = textline[:equalsMarkIndex].upper()
            paramvalue = textline[equalsMarkIndex + 1:].strip()

            if "BDUSS" == paramname:
                userinfo.cookieBduss = paramvalue
            elif "STOKEN" == paramname:
                userinfo.cookieStoken = paramvalue
            elif "BAIDUID" == paramname:
                userinfo.cookieBaidu = paramvalue
    return __baiduLogin(userinfo)
# ('Set-Cookie', 'PANPSC=5671587181432674772%3AcQu3KcN2CPfuwbI8A2ioIy%2BYkxcWdNAE2jmahp4aZjjXRqmDNNDr%2BXgXofrWESI4%2BcpcY4KTRVMyLJx7kL47EK1Sr93PEHDiy5m1O19tFWJ0uYcvQDeNMieKHrlyURG2vIcMCeE%2BEzPl0236xFtTr1QxIuFgE8LFzlMymqcoIUw%3D; expires=Fri, 19-Oct-2018 01:49:26 GMT; path=/; domain=pan.baidu.com; httponly')
# ('Set-Cookie', 'PANWEB=1; expires=Fri, 18-Oct-2019 01:49:26 GMT; path=/; domain=pan.baidu.com')
# ('Set-Cookie', 'BAIDUID=34875CA49C51FD433015DB461C11CAA3:FG=1; expires=Fri, 18-Oct-19 01:49:26 GMT; max-age=31536000; path=/; domain=.baidu.com; version=1')
def __baiduLogin(userinfo):
    response = myhttp.httpopen("https://pan.baidu.com/disk/home?", userinfo)
    newBaiduId = ""
    for head in response.getheaders():
        if "Set-Cookie" == head[0]:
            if len(newBaiduId) > 0:
                newBaiduId += "; "
            newBaiduId += head[1]
    userinfo.cookieBaidu = newBaiduId
    __parseResponse(response, userinfo)
    return userinfo

def __parseResponse(response, userinfo):
    responseContent = str(response.read(), encoding="utf-8").strip()
    responseContent = responseContent.replace(r"\n", "")
    m = re.search(r"var\s*context\s*=\s*({.*})", responseContent)
    if m :
        content = json.loads(m.group(1))
        userinfo.bdstoken = content["bdstoken"]
        userinfo.sign1 = content["sign1"]
        userinfo.sign2 = content["sign2"]
        userinfo.sign3 = content["sign3"]
    else:
        userinfo = None
    return __getappId(userinfo)
        
    
def __getappId(userinfo):
    response = myhttp.httpopen("https://pan.baidu.com/box-static/function-widget-1/pkg/async-all_a0efe61.js", userinfo)
    responseContent = str(response.read(), encoding="utf-8").strip()
    m = re.search(r'app_id=(.*)"', responseContent)
    if m :
        userinfo.appId = m.group(1)
    else:
        userinfo = None
    return userinfo
