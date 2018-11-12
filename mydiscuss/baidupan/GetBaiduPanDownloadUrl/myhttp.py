import urllib.request

def httpopen(url, baiduinfo):
    myrequest = urllib.request.Request(url)
    myrequest.method = "GET"
    myrequest.add_header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
    myrequest.add_header("Accept-Encoding", "deflate, br")
    myrequest.add_header("Accept-Language", "en-US,en;q=0.9,zh;q=0.8,zh-CN;q=0.7,zh-TW;q=0.6")
    myrequest.add_header("Cache-Control", "max-age=0")
    myrequest.add_header("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36")
    print(baiduinfo)
    if baiduinfo:
        myrequest.add_header("Cookie", baiduinfo.cookieBaidu + "; BDUSS=" + baiduinfo.cookieBduss + "; STOKEN=" + baiduinfo.cookieStoken)
    return urllib.request.urlopen(myrequest)
