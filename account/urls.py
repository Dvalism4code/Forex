from django.urls import path
from account import views



urlpatterns = [
    path('account/users/dashboard/', views.dashboard, name='dashboard'),
    path('account/users/deposit/', views.deposit, name='deposit'),
    path('account/users/withdraw/', views.withdrawal_request, name='withdraw'),
    path('account/users/set_withdrawal_pin/', views.set_withdrawal_pin, name='set_withdrawal_pin'),
    path('account/users/withdraw-success/', views.withdraw_success, name='withdrawal-success'),
    path('account/users/signal/', views.signal_view, name='signal'),
    path('account/users/kyc/', views.kyc_view, name='kyc'),
    path('account/users/kyc-wizard/', views.KYCWizard.as_view(), name='kyc-wizard'),
]