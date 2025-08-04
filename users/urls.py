from . import views
from django.contrib.auth.views import LogoutView
from django.urls.conf import path


urlpatterns = [
    path('users/register/', views.RegisterView, name='register'),
    path('users/login/', views.UserLoginView, name='login'),
    path('users/logout/', views.logout_view, name='logout'),
]