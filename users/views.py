from django.shortcuts import render, redirect
from users.forms import UserRegistrationForm, UserLoginForm
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages




def RegisterView(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            form.save()
            messages.success(request,f"Hello {first_name} {last_name} your account has been created!")
            return redirect('login')
        
    else:
        form = UserRegistrationForm()
    return render(request, 'users/pages/register.html', {'form': form, 'title': 'Register'})
           




def UserLoginView(request):
    if request.method == 'POST':
        form = UserLoginForm(request, data=request.POST)
        if form.is_valid():
            email = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=email, password=password)
            if user is not None:
                login(request, user)
                return redirect('dashboard')
            
    else:
        form = UserLoginForm()
    return render(request, 'users/pages/login.html', {'form': form, 'title': 'Login'})


def logout_view(request):
    logout(request)
    return redirect('login')









