from django.shortcuts import render
from django.contrib.auth.decorators import login_required

def home(request):
    return render(request, 'broker/pages/base.html')


def about(request):
    return render(request, 'broker/pages/about.html')


def services(request):
    return render(request, 'broker/pages/services.html')


def faq(request):
    return render(request, 'broker/pages/faq.html')


def contact(request):
    return render(request, 'broker/pages/contact.html')


