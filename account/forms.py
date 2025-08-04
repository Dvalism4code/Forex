from django import forms
from account.models import Deposit, Withdraw




class UserDepositForm(forms.ModelForm):
    select_asset = [('', 'Choose Asset'), ('BTC', 'BTC'), ('USDT','USDT')]
    asset = forms.ChoiceField(choices=select_asset, widget=forms.Select(attrs={'id': 'select_input'}))
    deposit_amount = forms.CharField(widget=forms.TextInput(attrs={'id': 'input_amount'}))


    class Meta:
        model = Deposit
        fields = ['asset', 'deposit_amount']
    

class SetWithdrawalPINForm(forms.Form):
    new_pin = forms.CharField(widget=forms.PasswordInput(attrs={'id': 'pin', 'placeholder': 'Enter 4 digit number ',  'pattern': '\d{4}', 'inputmode': 'numeric'}), min_length=4, max_length=4)
    confirm_pin = forms.CharField(widget=forms.PasswordInput(attrs={'id': 'confirm_pin', 'placeholder': 'Enter 4 digit number',  'pattern': '\d{4}', 'inputmode': 'numeric'}), min_length=4, max_length=4)

    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data.get('new_pin') != cleaned_data.get('confirm_pin'):
            raise forms.ValidationError("PINs do not match")
        return cleaned_data
    


class WithdrawalForm(forms.ModelForm):
    withdrawal_type = [('', 'Withdrawal Method'), ('BTC', 'Bitcoin'), ('ETH', 'Etherum'), ('Bank', 'Bank'), ('Paypal', 'Paypal'), 'CashApp', 'CashApp']
    pin = forms.CharField(widget=forms.PasswordInput(attrs={'id': 'pin'}), min_length=4, max_length=4)
    withdraw_amount = forms.CharField(widget=forms.TextInput(attrs={'id': 'amount'}))
    selected_withdrawal_type = forms.ChoiceField(choices=withdrawal_type, widget=forms.Select(attrs={'id': 'select_input'}))
    withdraw_address = forms.CharField(widget=forms.TextInput(attrs={'id': 'address'}), max_length=256)

    class Meta:
        model = Withdraw
        fields = ['pin', 'withdraw_amount', 'selected_withdrawal_type', 'withdraw_address']
    
