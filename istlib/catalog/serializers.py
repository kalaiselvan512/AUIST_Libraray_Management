from rest_framework import serializers
from .models import *

class LibUserSerializers(serializers.ModelSerializer):
    class Meta:
        model=LibUser
        fields='__all__'