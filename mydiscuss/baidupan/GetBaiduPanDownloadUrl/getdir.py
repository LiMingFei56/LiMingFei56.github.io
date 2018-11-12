import myhttp
import json

def getdir(userinfo, path):
    response = myhttp.httpopen("https://pan.baidu.com/api/list?dir=" + path + "&bdstoken="+ userinfo.bdstoken +"&num=100&order=time&desc=1&clienttype=0&showempty=0&web=1&page=1&channel=chunlei&web=1&app_id=" + userinfo.appId, userinfo)
    responseContent = str(response.read(), encoding="utf-8")
    responseJson = json.loads(responseContent)
    return responseJson
