from dataclasses import fields
from rest_framework import serializers
from faculty import models

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = '__all__'
        model = models.User
        