from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
     path('', views.home, name='home'),
     path('about/', views.about, name='about'),
     path('contact/', views.contact, name='contact'),
     path('services/', views.services, name='services'),
     path('faq/', views.faq, name='faq'),
    
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)