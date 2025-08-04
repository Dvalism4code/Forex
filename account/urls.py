from django.urls import path
from account import views



urlpatterns = [
    path('account/users/dashboard/', views.dashboard, name='dashboard'),
    path('account/users/deposit/', views.deposit, name='deposit'),
    path('account/users/withdrawal/', views.withdraw_funds, name='withdraw'),
    path('account/users/set_withdrawal_pin/', views.set_withdrawal_pin, name='set_withdrawal_pin'),
]