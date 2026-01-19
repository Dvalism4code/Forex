from django import forms
from account.models import Deposit, Withdraw
from django_country_kit.widgets import CountryWidget
from account.models import KYC



class UserDepositForm(forms.ModelForm):
    select_asset = [('', 'Choose Asset'), ('BTC', 'BTC'), ('USDT','USDT')]
    asset = forms.ChoiceField(choices=select_asset, widget=forms.Select(attrs={'id': 'select_input', 'placeholder': 'Select Asset'}))
    deposit_amount = forms.DecimalField(widget=forms.NumberInput(attrs={'id': 'input_amount', 'inputmode': 'decimal'}), max_digits=20, decimal_places=2)


    class Meta:
        model = Deposit
        fields = ['asset', 'deposit_amount']
    

class SetWithdrawalPINForm(forms.Form):
    new_pin = forms.CharField(widget=forms.PasswordInput(attrs={'id': 'pin', 'placeholder': 'Enter 4 digit number ',  'pattern': '\d{6}', 'inputmode': 'numeric'}), min_length=6, max_length=6)
    confirm_pin = forms.CharField(widget=forms.PasswordInput(attrs={'id': 'confirm_pin', 'placeholder': 'Enter 4 digit number',  'pattern': '\d{6}', 'inputmode': 'numeric'}), min_length=6, max_length=6)

    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data.get('new_pin') != cleaned_data.get('confirm_pin'):
            raise forms.ValidationError("PINs do not match")
        return cleaned_data




class WithdrawForm(forms.ModelForm):
    class Meta:
        model = Withdraw
        fields = ['amount', 'method', 'withdraw_address', 'bank_name', 
                  'bank_account_number', 'bank_account_name', 'swift_code']
        widgets = {
            'method': forms.Select(attrs={'id': 'withdrawal-method'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control'}),
            'withdraw_address': forms.TextInput(attrs={'class': 'form-control'}),
            'bank_name': forms.TextInput(attrs={'class': 'form-control'}),
            'bank_account_number': forms.TextInput(attrs={'class': 'form-control'}),
            'bank_account_name': forms.TextInput(attrs={'class': 'form-control'}),
            'swift_code': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def clean(self):
        cleaned_data = super().clean()
        method = cleaned_data.get('method')
        
        # Validate crypto withdrawals
        if method in ['BTC', 'ETH', 'USDT']:
            if not cleaned_data.get('withdraw_address'):
                raise forms.ValidationError('Wallet address is required for crypto withdrawals')
        
        # Validate bank withdrawals
        elif method == 'Bank':
            required_fields = ['bank_name', 'bank_account_number', 'bank_account_name', 'swift_code']
            for field in required_fields:
                if not cleaned_data.get(field):
                    raise forms.ValidationError(f'{field.replace("_", " ").title()} is required for bank transfers')
        
        return cleaned_data
    
# django formtools

# Step 1: Identity Information
class KYCIdentityForm(forms.Form):
    IDENTITY_TYPE = [
        ('passport', 'Passport'),
        ('driver_license', 'Driver License'),
        ('national_id', 'National ID'),
    ]
    
    identity_type = forms.ChoiceField(
        choices=IDENTITY_TYPE, 
        widget=forms.Select(attrs={'id': 'identity_type'})
    )
    identity_number = forms.CharField(
        max_length=142, 
        widget=forms.TextInput(attrs={'id': 'identity_number', 'placeholder': 'Enter Identity Number'})
    )
    identity_image = forms.ImageField(
        widget=forms.FileInput(attrs={'id': 'identity_image'})
    )

# Step 2: Personal Information
class KYCPersonalForm(forms.Form):
    GENDER = [('male', 'Male'), ('female', 'Female')]
    
    first_name = forms.CharField(
        max_length=100, 
        widget=forms.TextInput(attrs={'id': 'first_name', 'placeholder': 'Enter First Name'})
    )
    last_name = forms.CharField(
        max_length=100, 
        widget=forms.TextInput(attrs={'id': 'last_name', 'placeholder': 'Enter Last Name'})
    )
    gender = forms.ChoiceField(
        choices=GENDER, 
        widget=forms.Select(attrs={'id': 'gender'})
    )
    date_of_birth = forms.DateField(
        widget=forms.DateInput(attrs={'id': 'date_of_birth', 'type': 'date'})
    )

# Step 3: Address Information
class KYCAddressForm(forms.Form):
    country = forms.CharField(
        widget=CountryWidget(attrs={'id': 'country'})
    )
    state = forms.CharField(
        max_length=100, 
        widget=forms.TextInput(attrs={'id': 'state', 'placeholder': 'Enter State'})
    )
    city = forms.CharField(
        max_length=100, 
        widget=forms.TextInput(attrs={'id': 'city', 'placeholder': 'Enter City'})
    )
    address = forms.CharField(
        widget=forms.TextInput(attrs={'id': 'address', 'placeholder': 'Enter Address'})
    )
    mobile = forms.CharField(
        max_length=100, 
        widget=forms.TextInput(attrs={'id': 'mobile', 'placeholder': 'Enter Mobile Number'})
    )