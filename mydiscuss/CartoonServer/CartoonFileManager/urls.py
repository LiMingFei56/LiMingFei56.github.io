from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'path', views.path, name='path'),
    url(r'video', views.video, name='video'),
]
