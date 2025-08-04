from django.shortcuts import render, redirect
from account.models import Account, Deposit, Withdraw
from account.forms import UserDepositForm, WithdrawalForm, SetWithdrawalPINForm
from django.contrib import messages




def dashboard(request):
    if request.user.is_authenticated:
        account = Account.objects.get(user=request.user)
        return render(request, 'account/users/dashboard.html', {'account': account})
    
    else:
        if not request.user.is_authenticated:

            return redirect('login')
    

def deposit(request):
    if request.user.is_authenticated:
        user = Account.objects.get(user=request.user)
        address = 'bc1qpf7ahqktjv7vw67k98ejukp7ew0ml3prclauw4'

        if request.method == 'POST':
            form = UserDepositForm(request.POST)
            if form.is_valid():
                asset = form.cleaned_data.get('asset')
                deposit_amount = form.cleaned_data.get('deposit_amount')
                deposit_fund = Deposit.objects.create(asset=asset, amount=deposit_amount, deposit_address=address, account=user)
                deposit_fund.save()
                return redirect('home')
        
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


def set_withdrawal_pin(request):
    if request.user.is_authenticated:
        account = Account.objects.get(user=request.user)
        if request.method == 'POST':
            form = SetWithdrawalPINForm(request.POST)
            if form.is_valid():
                print(form.errors)
                user_pin = form.cleaned_data.get('new_pin')
                user_confirm_pin = form.cleaned_data.get('confirm_pin')
                account.set_withdrawal_pin(form.cleaned_data['new_pin'])
                messages.success(request, f"your withdrawal pin has been set")
                return redirect('withdraw')

        elif account.pin_set:
            return redirect('dashboard')

    else:
        form = SetWithdrawalPINForm()
    return render(request, 'account/users/set_withdrawal_pin.html', {'form': form})
    



def withdraw_funds(request):
    if request.user.is_authenticated:
        account = Account.objects.get(user=request.user)
        if not account.pin_set:
            return redirect('set_withdrawal_pin')
        
        if request.method == 'POST':
            form = WithdrawalForm(request.POST)
            if form.is_valid():
                pin = form.cleaned_data.get('pin')
                withdraw_amount = form.cleaned_data.get('withdraw_amount')
                selected_withdrwal_type = form.cleaned_data.get('selected_withdrawal_type')
                withdraw_address = form.cleaned_data.get('withdraw_address')

                # verify PIN first
                if not account.check_withdrawal_pin(form.cleaned_data[pin]):
                    form.add_error('pin', 'Invalid PIN')

                else:
                    withdrawal = form.save()
                    withdrawal.account = account
                    amount = form.clean_data[withdraw_amount]
                    if amount > account.acount_balance:
                        form.add_error('amount', 'Insufficient funds')
                    else:
                        # Deduct from account balance
                        account.acount_balance -= amount
                        account.save()

                        # Save withdrawal record
                        withdrawal.amount = str(amount)
                        withdrawal.status = 'pending'
                        withdrawal.save() 
            else:
                form = WithdrawalForm()        
            return render(request, 'account/users/withdrawal.html', {'form': form })
    else:
        return redirect('login')