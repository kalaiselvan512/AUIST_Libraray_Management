from rest_framework import serializers
from .models import *

class LibUserSerializers(serializers.ModelSerializer):
    class Meta:
        model=LibUser
        fields='__all__'

class LibraianSerializers(serializers.ModelSerializer):
    class Meta:
        model=Librarian
        fields='__all__'

class BookSerializers(serializers.ModelSerializer):
    class Meta:
        model=Book
        fields='__all__'

class BookInstanceSerializers(serializers.ModelSerializer):
    class Meta:
        model=BookInstance
        fields='__all__'

class RenewalSerializers(serializers.ModelSerializer):
    class Meta:
        model=Renewal
        fields='__all__'