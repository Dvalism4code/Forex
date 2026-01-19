from django.shortcuts import render
from django.contrib.auth.decorators import login_required

def home(request):
    return render(request, 'broker/pages/base.html', {'title': 'Home'})


def about(request):
    return render(request, 'broker/pages/about.html', {'title': 'About Us'})


def services(request):
    return render(request, 'broker/pages/services.html', {'title': 'Our Services'})


def faq(request):
    return render(request, 'broker/pages/faq.html', {'title': 'FAQ'})


def contact(request):
    return render(request, 'broker/pages/contact.html', {'title': 'Contact Us'})

def withdrawal_pin_success(request):
    return render(request, 'account/users/withdrawal_pin_success.html', {'title': 'Withdrawal PIN Set Successfully'})   

def withdrawal_success(request):
    return render(request, 'account/users/withdrawal_success.html', {'title': 'Withdrawal Successful'}) 


