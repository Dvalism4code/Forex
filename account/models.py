from django.db import models
from users.models import CustomUser
from django.contrib.auth.hashers import make_password, check_password
from django.db.models.signals import post_save
import uuid

ACCOUNT_STATUS = [
    ('active', 'Active'),
    ('pending', 'Pending'),
    ('in-active', 'In-active')
]

GENDER = [("male", "Male"), ("female", "Female"), ("other", "Other")]


IDENTITY_TYPE = [
    ("national_id_card", "National ID Card"),
    ("drivers_license", "Drivers License"),
    ("international_passport", "International Passport")
]

WITHDRAWAL_STATUS = [('Pending', 'Pending'), ('Successul', 'Successful')]

# path to save user documents and image

def user_directory_path(instance, filename):
    ext = filename.spilt(".")[-1]
    filename = "%s_%s" % (instance.id, ext)
    return "user_{0}/{1}".format(*args, instance.User.id, filename)

# Custom User Account Model


class Account(models.Model):
    id = models.UUIDField(primary_key=True, unique=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    acount_balance = models.DecimalField(max_digits=20, default=0.00, decimal_places=2)
    profit = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    accumulating_balance = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    bonus = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
    account_status = models.CharField(max_length=100, choices=ACCOUNT_STATUS, default='in-active')
    kyc_confirmed = models.BooleanField(default=False)
    kyc_submitted = models.BooleanField(default=False)
    date_join = models.DateTimeField(auto_now_add=True)
    withdrawal_pin = models.CharField(max_length=128, blank=True, null=True)
    pin_set = models.BooleanField(default=False)  # Add this field

    def set_withdrawal_pin(self, raw_pin):
        self.withdrawal_pin = make_password(raw_pin)
        self.pin_set = True
        self.save()

    def check_withdrawal_pin(self, raw_pin):
        return check_password(raw_pin, self.withdrawal_pin)

    def __str__(self):
        return f"{self.user}"
    


def create_account(sender, instance, created, **kwrgs):
    if created:
        Account.objects.create(user=instance)

def save_account(sender, instance, **kwargs):
    instance.account.save()

post_save.connect(create_account, sender=CustomUser)


class Deposit(models.Model):
    account = models.ForeignKey(Account, on_delete=models.CASCADE)
    amount = models.CharField(max_length=100)
    asset = models.CharField(max_length=5)
    deposit_address = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.account.user.username} deposited {self.amount} USD to this wallet address {self.deposit_address}"
    


class Withdraw(models.Model):
    account = models.ForeignKey(Account, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=20, decimal_places=8)  # Changed to Decimal
    asset = models.CharField(max_length=20)
    withdraw_address = models.CharField(max_length=255)
    status = models.CharField(choices=WITHDRAWAL_STATUS, default='Pending', max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)  # Add timestamp
    verified = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.account.user.username} withdrawal of {self.amount} {self.asset}"



class KYC(models.Model):

    id = models.UUIDField(primary_key=True, unique=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    account = models.OneToOneField(Account, on_delete=models.CASCADE, null=True, blank=True)
    full_name = models.CharField(max_length=100)
    image = models.ImageField(upload_to='kyc', default='default.jpg')
    gender = models.CharField(choices=GENDER, max_length=30)
    date_of_birth = models.DateTimeField(auto_now_add=False)
    identity_image = models.ImageField(upload_to='kyc', default='default.jpg')
    identity_type = models.CharField(max_length=142, choices=IDENTITY_TYPE)

    #Address

    country = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    city = models.CharField(max_length=100)

    mobile = models.CharField(max_length=100)
    fax = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user}"
    
    class Meta:
        ordering = ['-date']