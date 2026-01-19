from django.contrib import admin
from account.models import Withdraw,Deposit, Account, KYC, SignalBot
from users.models import CustomUser


class WithdrawAdmin(admin.ModelAdmin):
    list_display = ['account', 'amount', 'method', 'status', 'created_at']
    actions = ['approve_selected', 'reject_selected']

    def approve_selected(self, request, queryset):
        userwithdraws = queryset.filter(status='pending')
        for withdraw in userwithdraws:
            try:
                withdraw.account.withdraw(withdraw.amount)
                withdraw.status = 'successful'
                withdraw.verified = True
                withdraw.save()
            except ValueError as e:
                self.message_user(request, f"Error for {withdraw.account.user.username}: {str(e)}")

    def reject_selected(self, request, queryset):
        queryset.filter(status='pending').update(status='rejected')

    approve_selected.short_description = "Approve selected withdrawals"
    reject_selected.short_description = "Reject selected withdrawals"


class DepositAdmin(admin.ModelAdmin):
    list_display = ['account', 'amount', 'asset', 'status', 'created_at']

class KYCAdmin(admin.ModelAdmin):
    list_display = ['user', 'account', 'date_submitted', 'country']


class SignalBotAdmin(admin.ModelAdmin):
    list_display = ['plan', 'price', 'date_created']


class AccountAdmin(admin.ModelAdmin):
    list_display = ['user', 'capital', 'kyc_confirmed', 'date_joined']


admin.site.register(Account, AccountAdmin)
admin.site.register(Deposit, DepositAdmin)
admin.site.register(KYC, KYCAdmin)
admin.site.register(CustomUser)
admin.site.register(Withdraw, WithdrawAdmin)
admin.site.register(SignalBot, SignalBotAdmin)
admin.site.site_header = "FinnexGlobecon Admin"
admin.site.site_title = "Finnex Admin Portal"
admin.site.index_title = "Welcome to Finnex Admin Portal"