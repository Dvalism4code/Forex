from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from users.models import CustomUser  



class UserRegistrationForm(UserCreationForm):
    first_name = forms.CharField(label='First Name', max_length=150, required=True, min_length=5)
    last_name = forms.CharField(label='Last Name', max_length=150, required=True)
    email = forms.EmailField(label='Email', max_length=254, required=True)
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = CustomUser
        fields = [ 'first_name', 'last_name', 'email', 'password1', 'password2']
        
     
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['email'].widget.attrs.update({'id': 'email', 'placeholder': ' email', 'autofocus': False})
        self.fields['password1'].widget.attrs.update({'id': 'password', 'placeholder': ' password'})
        self.fields['password2'].widget.attrs.update({'id': 'confirm_password', 'placeholder': ' confirm password'})
        self.fields['first_name'].widget.attrs.update({'id': 'first_name', 'placeholder': ' first name'})
        self.fields['last_name'].widget.attrs.update({'id': 'last_name', 'placeholder': ' last name'})
        
       
    

class UserLoginForm(AuthenticationForm):
    username= forms.EmailField(max_length=254, required=True)
    password = forms.CharField(widget=forms.PasswordInput)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({'id': 'email', 'placeholder': 'email'})
        self.fields['password'].widget.attrs.update({'id': 'password', 'placeholder': 'password'})