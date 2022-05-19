from django.contrib import admin

# Register your models here.
from .models import UserSignUp
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

@admin.register(UserSignUp)
class UserAdmin(BaseUserAdmin):
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields' : ('username','email','password1','password2'),
        }),
    )