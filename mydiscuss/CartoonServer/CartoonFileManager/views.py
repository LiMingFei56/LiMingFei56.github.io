from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
import configparser
import os
import json
import re
import mimetypes
from wsgiref.util import FileWrapper

from django.http.response import StreamingHttpResponse

rootpath = ''

def getRootPath():
    global rootpath
    if(not rootpath):
        configDir = os.path.dirname(os.path.abspath("views.py"))
        conf = configparser.ConfigParser()
        conf.read(configDir + '/config.ini')
        rootpath = conf.get('global', 'rootpath')
    return rootpath

def path(request):
    global rootpath
    rootpath = getRootPath()
    requestPathStr = request.GET.get('path', rootpath)
    if (requestPathStr[0] != '/'):
        requestPathStr = '/' + requestPathStr
    requestPath = rootpath + requestPathStr

    childFileList = []
    if(os.path.exists(requestPath) or os.path.isdir(requestPath)):
        childFileList = list(filter(lambda x: x[0] != '.', os.listdir(requestPath)))

    return HttpResponse(json.dumps(childFileList), content_type='application/json')

class RangeFileWrapper(object):
    def __init__(self, filelike, blksize=8192, offset=0, length=None):
        self.filelike = filelike
        self.filelike.seek(offset, os.SEEK_SET)
        self.remaining = length
        self.blksize = blksize

    def close(self):
        if hasattr(self.filelike, 'close'):
            self.filelike.close()

    def __iter__(self):
        return self

    def __next__(self):
        if self.remaining is None:
            # If remaining is None, we're reading the entire file.
            data = self.filelike.read(self.blksize)
            if data:
                return data
            raise StopIteration()
        else:
            if self.remaining <= 0:
                raise StopIteration()
            data = self.filelike.read(min(self.remaining, self.blksize))
            if not data:
                raise StopIteration()
            self.remaining -= len(data)
            return data

def stream_video(request):
    global rootpath
    rootpath = getRootPath()
    requestPathStr = request.GET.get('path', rootpath)
    if (requestPathStr[0] != '/'):
        requestPathStr = '/' + requestPathStr
    path = '/Users/lmf/Downloads/小猪佩琪/S101 Muddy Puddles.mp4'

    range_header = request.META.get('HTTP_RANGE', '').strip()
    range_re = re.compile(r'bytes\s*=\s*(\d+)\s*-\s*(\d*)', re.I)
    range_match = range_re.match(range_header)
    size = os.path.getsize(path)
    content_type, encoding = mimetypes.guess_type(path)
    content_type = content_type or 'application/octet-stream'
    print(range_header)
    if range_match:
        first_byte, last_byte = range_match.groups()
        first_byte = int(first_byte) if first_byte else 0
        last_byte = int(last_byte) if last_byte else size - 1
        if last_byte >= size:
            last_byte = size - 1
        length = last_byte - first_byte + 1
        resp = StreamingHttpResponse(RangeFileWrapper(open(path, 'rb'), offset=first_byte, length=length), status=206, content_type=content_type)
        resp['Content-Length'] = str(length)
        resp['Content-Range'] = 'bytes %s-%s/%s' % (first_byte, last_byte, size)
    else:
        # 不是以视频流方式的获取时，以生成器方式返回整个文件，节省内存
        resp = StreamingHttpResponse(FileWrapper(open(path, 'rb')), content_type=content_type)
        resp['Content-Length'] = str(size)
    resp['Accept-Ranges'] = 'bytes'
    return resp
