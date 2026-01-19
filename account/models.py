from django.db import models
from django.contrib.auth.hashers import make_password, check_password
from django.db.models.signals import post_save
from django.dispatch import receiver
from users.models import CustomUser
from decimal import Decimal
import uuid
from django_country_kit.fields import CountryField

# Choices
ACCOUNT_STATUS = [
    ('active', 'Active'),
    ('pending', 'Pending'),
    ('inactive', 'Inactive')
]

GENDER = [
    ("male", "Male"),
    ("female", "Female"),
    ("other", "Other")
]

IDENTITY_TYPE = [
    ("national_id_card", "National ID Card"),
    ("drivers_license", "Driver's License"),
    ("international_passport", "International Passport")
]

WITHDRAWAL_STATUS = [
    ('pending', 'Pending'),
    ('successful', 'Successful'),
    ('rejected', 'Rejected'),
]

DEPOSIT_STATUS = [
    ('pending', 'Pending'),
    ('successful', 'Successful'),
    ('failed', 'Failed')
]

# File path helper
def user_directory_path(instance, filename):
    ext = filename.split(".")[-1]
    filename = f"{instance.id}_{ext}"
    return f"user_{instance.user.id}/{filename}"

# -------------------------------
# Account Model
# -------------------------------
class Account(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    
    capital = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    profit = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    accumulating_balance = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    bonus = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)

    account_status = models.CharField(max_length=20, choices=ACCOUNT_STATUS, default='inactive')
    kyc_confirmed = models.BooleanField(default=False)
    kyc_submitted = models.BooleanField(default=False)

    withdrawal_pin = models.CharField(max_length=128, null=True, blank=True)
    pin_set = models.BooleanField(default=False)

    date_joined = models.DateTimeField(auto_now_add=True)

    
    def set_withdrawal_pin(self, raw_pin):
        self.withdrawal_pin = make_password(raw_pin)
        self.pin_set = True
        self.save()

    def check_withdrawal_pin(self, raw_pin):
        return check_password(raw_pin, self.withdrawal_pin)
    

    def __str__(self):
        return f"{self.user.first_name}'s Account"
    
    # Compute the total account balance
    @property
    def total_account_balance(self):
        total_balance = self.capital + self.profit 
        return total_balance

# Auto-create Account when CustomUser is created
@receiver(post_save, sender=CustomUser)
def create_user_account(sender, instance, created, **kwargs):
    if created:
        Account.objects.create(user=instance)

# -------------------------------
# Deposit Model
# -------------------------------
class Deposit(models.Model):
    account = models.ForeignKey(Account, on_delete=models.CASCADE, related_name="deposits")
    amount = models.DecimalField(max_digits=20, decimal_places=2)
    asset = models.CharField(max_length=10)  # e.g., USD, BTC
    deposit_address = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(choices=DEPOSIT_STATUS, max_length=20, default='pending')
    

    def __str__(self):
        return f"{self.account.user.username} deposited {self.amount} {self.asset} to {self.deposit_address}"

# -------------------------------
# Withdraw Model
# -------------------------------
class Withdraw(models.Model):
    WITHDRAWAL_METHODS = [
        ('', 'Select Method'),
        ('BTC', 'Bitcoin'),
        ('ETH', 'Ethereum'),
        ('USDT', 'USDT'),
        ('Bank', 'Bank Transfer'),
        
    ]
    account = models.ForeignKey(Account, on_delete=models.CASCADE, related_name="withdrawals")
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    method = models.CharField(max_length=10, choices=WITHDRAWAL_METHODS, default='')
    withdraw_address = models.CharField(max_length=255, blank=True, null=True)
    status = models.CharField(choices=WITHDRAWAL_STATUS, max_length=20, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    verified = models.BooleanField(default=False)
    bank_name = models.CharField(max_length=100, blank=True, null=True)
    bank_account_number = models.CharField(max_length=10, blank=True, null=True)  
    bank_account_name = models.CharField(max_length=100, blank=True, null=True) 
    swift_code = models.CharField(max_length=10, blank=True, null=True)
    

    def __str__(self):
        if self.method == 'Bank':
            return f"{self.account.user.first_name} requested withdrawal of {self.amount} via {self.method} to {self.bank_account_name}"
        if self.method in ['BTC', 'ETH', 'USDT']:
            return f"{self.account.user.first_name} requested withdrawal of {self.amount} via {self.method} to {self.withdraw_address}"
        return f"{self.account.user.username} requested withdrawal of {self.amount} {self.method}"
    
 

 # ------------------------------
 # Signal Model
# -------------------------------
class SignalBot(models.Model):
    plan = models.CharField(max_length=30, null=False, blank=False)
    price = models.CharField(max_length=10, null=False, blank=False)
    date_created = models.DateTimeField(auto_now_add=True)
    time = models.CharField(max_length=30, null=True, blank=True)
    leverage = models.TextField(null=True, blank=True)
    features = models.TextField(null=True, blank=True)
    market_review = models.TextField(null=True, blank=True) 
    priority_market = models.TextField(null=True, blank=True)
    direct = models.TextField(null=True, blank=True)


    def __str__(self):
        return self.plan
    
# KYC Model
# -------------------------------
class KYC(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    account = models.ForeignKey(Account, on_delete=models.CASCADE, null=True, blank=True)

    first_name = models.CharField(max_length=100, null=False, blank=False, default='')
    last_name = models.CharField(max_length=100, null=False, blank=False, default='')
    gender = models.CharField(max_length=30, choices=GENDER)
    date_of_birth = models.DateField()

    identity_image = models.ImageField(upload_to='media', default='default.jpg')
    identity_type = models.CharField(max_length=142, choices=IDENTITY_TYPE)

    country = CountryField()
    state = models.CharField(max_length=100, null=False, blank=False)
    city = models.CharField(max_length=100, null=False, blank=False)

    mobile = models.CharField(max_length=100, blank=True, null=True)
    address = models.CharField(max_length=100, null=False, blank=False, default='') 


    date_submitted = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"KYC for {self.user.first_name}"

    class Meta:
        ordering = ['-date_submitted']


