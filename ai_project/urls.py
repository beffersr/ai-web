from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^ai_app/', ai_app.site.urls),
    url(r'^admin/', admin.site.urls),
]