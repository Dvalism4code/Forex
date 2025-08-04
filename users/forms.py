from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from users.models import CustomUser  # Assuming CustomUser is your user model
from django_countries.widgets import CountrySelectWidget
from django_countries.fields import CountryField
from phonenumber_field.formfields import PhoneNumberField


class UserRegistrationForm(UserCreationForm):
    username = forms.CharField(label='Username', max_length=150, required=True, min_length=3)
    full_name = forms.CharField(label='Full Name', max_length=150, required=True, min_length=5)
    email = forms.EmailField(label='Email', max_length=254, required=True)
    country = CountryField()
    phone_number = PhoneNumberField(label='Phone', required=True)
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'full_name', 'country', 'phone_number', 'password1', 'password2']
        widget = {
            'country': CountrySelectWidget(),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({'id': 'username', 'placeholder': ' username'})
        self.fields['email'].widget.attrs.update({'id': 'email', 'placeholder': ' email', 'autofocus': False})
        self.fields['password1'].widget.attrs.update({'id': 'password', 'placeholder': ' password'})
        self.fields['password2'].widget.attrs.update({'id': 'confirm_password', 'placeholder': ' confirm password'})
        self.fields['full_name'].widget.attrs.update({'id': 'full_name', 'placeholder': ' full name'})
        self.fields['country'].widget.attrs.update({'id': 'country', 'placeholder': ' select country'})
        self.fields['phone_number'].widget.attrs.update({'id': 'phone_number', 'placeholder': ' phone number'})

    

class UserLoginForm(AuthenticationForm):
    username = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({'id': 'username', 'placeholder': 'email'})
        self.fields['password'].widget.attrs.update({'id': 'password', 'placeholder': 'password'})