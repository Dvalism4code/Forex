from django.contrib import admin
from account.models import Account, Deposit, Withdraw
from users.models import CustomUser 



admin.site.register(Account)
admin.site.register(Deposit)
admin.site.register(CustomUser)
admin.site.register(Withdraw)