from django.shortcuts import render, redirect
from account.models import Account, Deposit, Withdraw, SignalBot
from account.forms import UserDepositForm, WithdrawForm, SetWithdrawalPINForm
from django.contrib import messages
from django.db import transaction
from django.core.files.storage import FileSystemStorage
from .forms import KYCAddressForm, KYC, KYCIdentityForm, KYCPersonalForm
from formtools.wizard.views import SessionWizardView
import os
from CORE import settings
from decimal import Decimal




def dashboard(request):
    if request.user.is_authenticated:
        account = Account.objects.get(user=request.user)
        # update total account balance
        total_balance = account.total_account_balance
        context = {
            'total_balance': total_balance,
            'account': account,
        }

        return render(request, 'account/users/dashboard.html', context)
    
    else:
        if not request.user.is_authenticated:

            return redirect('login')
    

def deposit(request):
    if request.user.is_authenticated:
        user = Account.objects.get(user=request.user)
        address = {
            'bitcoin': 'bc1q6nvmc3qh9625xl3ds0dfh4envpnuftf0kczpj2',
            'usdt': '0xe79d89a4074A69f28d3d22290aA2e260FE97d352',
        }

        if request.method == 'POST':
            form = UserDepositForm(request.POST)
            if form.is_valid():
                asset = form.cleaned_data.get('asset')
                deposit_amount = form.cleaned_data.get('deposit_amount')
                if asset == 'BTC':
                    btc_address = address['bitcoin']
                    deposit_fund = Deposit.objects.create(asset=asset, amount=deposit_amount, deposit_address=btc_address, account=user)
                    deposit_fund.save()
                    return redirect('dashboard')
                elif asset == 'USDT':
                    usdt_address = address['usdt']
                deposit_fund = Deposit.objects.create(asset=asset, amount=deposit_amount, deposit_address=usdt_address, account=user)
                deposit_fund.save()
                return redirect('dashboard')
                
        
        else:
            form = UserDepositForm()
            context = {
                'form': form,
                'address': address,
            }
            print(form)
        return render(request, 'account/users/deposit.html', context)
    
    else:
        if not request.user.is_authenticated:

            return redirect('login')




# Withdrawal View
def withdrawal_request(request):
    if not request.user.is_authenticated:
       return redirect('login')
    account = Account.objects.get(user=request.user)
   

   
    if request.method == 'POST':
        form = WithdrawForm(request.POST)
        if form.is_valid():
            amount = form.cleaned_data.get('amount')
            withdrawal = form.save(commit=False)
            withdrawal.account = request.user.account  # Adjust based on your user-account relationship
            withdrawal.save()

            
            if amount > account.capital and amount > account.profit:
                messages.error(request, "Insufficient balance")
                return redirect('withdraw')
            if amount <= 0:
                messages.error(request, "Invalid withdrawal amount")
                return redirect('withdraw')
            else:   
                return redirect('withdrawal-success')
    else:
        form = WithdrawForm()
    
    return render(request, 'account/users/withdraw-form.html', {'form': form})

# Withdraw Success View
def withdraw_success(request):
    return render(request, 'account/users/withdraw-success.html')



# Set Withdrawal PIN View
def set_withdrawal_pin(request):
    if not request.user.is_authenticated:
        return redirect('set_withdrawal_pin')
    
    account = Account.objects.get(user=request.user)
    
    if request.method == 'POST':
        form = SetWithdrawalPINForm(request.POST)
        if form.is_valid():
            new_pin = form.cleaned_data.get('new_pin')
            confirm_pin = form.cleaned_data.get('confirm_pin')
            if new_pin != confirm_pin:
                messages.error(request, "PINs do not match")
                return redirect('set_withdrawal_pin')
            account.set_withdrawal_pin(new_pin)
            messages.success(request, "Withdrawal PIN set successfully")
            return redirect('withdrawal_pin_success')
    else:
        form = SetWithdrawalPINForm()

    return render(request, 'account/users/set_withdraw_pin.html', {'form': form})


# Trade Signal / Manara Robot View

def signal_view(request):
    if not request.user.is_authenticated:
        return redirect('login')
    signals = SignalBot.objects.all()
    signal_address = {
        'btc_address': 'bc1qwuz273973jyu74d3my5fdkxwnts306mkq7e7q2',
        'eth_address': '0x1A04aa563602F175df51013F6CA98706fb1A0fA4',
    }

    context = {
        'signals': signals,
        'address': signal_address,
    }
    return render(request, 'account/users/signal.html', context)


# KYC View
def kyc_view(request):
    if not request.user.is_authenticated:
        return redirect('login')
    return render(request, 'account/users/kyc.html')


# KYC Form View


class KYCWizard(SessionWizardView):
    template_name = 'account/users/kyc-wizard.html'
    file_storage = FileSystemStorage(location=os.path.join(settings.MEDIA_ROOT, 'kyc_temp'))
    form_list = [
        ('personal', KYCPersonalForm),
        ('address', KYCAddressForm),
        ('identity', KYCIdentityForm),
    ]

    def get_context_data(self, form, **kwargs):
        context = super().get_context_data(form=form, **kwargs)
        step_titles = {
            'identity': 'Identity Information',
            'personal': 'Personal Information',
            'address': 'Address Information',
        }
        context['step_title'] = step_titles.get(self.steps.current, '')
        return context
    

    def done(self, form_list, **kwargs):
        # Process and save the KYC data
        kyc_data = {}
        for form in form_list:
            kyc_data.update(form.cleaned_data)
            user = Account.objects.get(user=self.request.user)
            if user.kyc_submitted and not user.kyc_confirmed:
                kyc = KYC.objects.filter(user=user).delete()
                kyc.objects.create(
                    user=self.request.user,
                    **kyc_data
                )
            else:
                kyc = KYC.objects.create(
                    user=user,
                    **kyc_data
                )
            user.kyc_submitted = True
            kyc.save()
        return redirect('kyc-success')