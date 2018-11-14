from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'path', views.path, name='path'),
    url(r'streamVideo', views.stream_video, name='stream_video'),
]
