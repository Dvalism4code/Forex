from django.shortcuts import render, redirect
from users.forms import UserRegistrationForm, UserLoginForm
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages




def RegisterView(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data['username']
            messages.success(request,f"Hello {username} your account has been creates!")
            return redirect('login')
        
    else:
        form = UserRegistrationForm()
    return render(request, 'users/pages/register.html', {'form': form})
           




def UserLoginView(request):
    if request.user.is_authenticated:
        
        if request.method == 'POST':
            form = UserLoginForm(request, data=request.POST)
            if form.is_valid():
                username = form.cleaned_data.get('username')
                password = form.cleaned_data.get('password')
                # Authenticate user
                user = authenticate(request, username=username, password=password)

                # login the user
                if user is not None:
                    login(request, user)
                    return redirect('dashboard')
        
        else:
            form = UserLoginForm()
        return render(request, 'users/pages/login.html', {'form': form})



def logout_view(request):
    logout(request)
    return redirect('login')









