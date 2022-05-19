from typing_extensions import Required
from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
# Create your models here.

class UserSignUp(UserCreationForm):

    userid=models.UUIDField(max_length=100,primary_key=True,unique=True)
    # name=models.CharField(max_length=200,blank=False)
    email=models.EmailField(max_length=100,unique=True,Required=True)
    designation=models.CharField(max_length=100,Required=True)
    phone = models.CharField(max_length=100,Required=True)
    # password=models.CharField(max_length=100)

# from django.contrib.auth import get_user_model
# from django.contrib.auth.backends import ModelBackend

# class EmailBackend (ModelBackend):
#     def authenticate(self, request, name=None, password=None, **kwargs):
#         UserModel = get_user_model()
#         try:
#             user = UserModel.objects.get(name=name)
#         except UserModel.DoesNotExist:
#              UserModel().set_password(password)
#         else:
#             if user.check_password(password) and self.user_can_authenticate:
#                 return user
        
        