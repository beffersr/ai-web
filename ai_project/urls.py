from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^ai_app/', include('/ai_app.urls')),
    url(r'^admin/', admin.site.urls),
]