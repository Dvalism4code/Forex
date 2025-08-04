from django.db import models
from django.contrib.auth.models import AbstractUser
from django_countries.fields import CountryField
from phonenumber_field.modelfields import PhoneNumberField

class CustomUser(AbstractUser):
    username = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    full_name = models.CharField(max_length=255, blank=False, null=True)
    country = CountryField(blank_label='Select Country', blank=False, null=False)
    phone_number = PhoneNumberField(blank=True, null=False)
    date_joined = models.DateTimeField(auto_now_add=True)
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.username