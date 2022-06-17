import datetime
from xmlrpc.client import DateTime
from django.db import models
from tkinter import CASCADE
from django.urls import reverse
from datetime import date
# Create your models here.

class Librarian(models.Model):
    userid = models.CharField(max_length=20,primary_key=True)
    password = models.CharField(max_length=50)

    def __str__(self):
        return self.userid


class LibUser(models.Model):
    userid = models.CharField(max_length=20,primary_key=True)
    username = models.CharField(max_length=100,null=False)
    email = models.CharField(max_length=100,null=False)
    designation = models.CharField(max_length=100,null=False)
    contact = models.CharField(max_length=10,null=False)
    password = models.CharField(max_length=50,null=False)

    class Meta:
        ordering = ['-userid']

    def get_absolute_url(self):
        return reverse('model-detail-view', args=[str(self.userid)])

    def __str__(self):
        return self.userid



class Book(models.Model):
    """Model representing a book (but not a specific copy of a book)."""
    bookid = models.CharField(max_length=20,primary_key=True)
    title = models.CharField(max_length=200,null=False)
    author1 = models.CharField(max_length=200,null=False)
    author2 = models.CharField(max_length=200,null=False)
    author3 = models.CharField(max_length=200,null=False)
    edition = models.CharField(max_length=100,null=False)
    publisher = models.CharField(max_length=100,null=False)
    domain = models.CharField(max_length=100,null=False) 
    status = models.CharField(
        max_length=20,
        null=False,
        choices=(
        
        ('Available','Available'),('Not Available','Not Available')
        
    ),
        
        default='Available',
        help_text='Book availability')
    
    rack = models.CharField(max_length=5,null=False)
    
    
    
    class Meta:
        ordering = ['title']

    

    def get_absolute_url(self):
        """Returns the url to access a particular book instance."""
        return reverse('book-detail', args=[str(self.bookid)])

    def __str__(self):
        """String for representing the Model object."""
        return self.title


class BookInstance(models.Model):
    """Model representing a specific copy of a book (i.e. that can be borrowed from the library)."""
    bookid = models.CharField(max_length=20,null=False)
    title = models.CharField(max_length=200,null=False)
    date = models.DateField()
    borrower = models.CharField(max_length=20,null=False)
    status = models.CharField(
        max_length=20,
        null=False,
        choices=( ('Available','Available'), ('Not Available','Not Available')),
        )
    # return_date = models.DateField()

    class Meta:
        ordering = ['date']
        

    def __str__(self):
        """String for representing the Model object."""
        return '{0} ({1})'.format(self.bookid, self.title)

class Renewal(models.Model):
    bookid = models.CharField(max_length=20,null=False,primary_key=True)
    title = models.CharField(max_length=200,null=False)
    date = models.DateField()
    borrower = models.CharField(max_length=20,null=False)
    status = models.CharField(
        max_length=20,
        null=False,
        choices=( ('Available','Available'), ('Not Available','Not Available')),
        )
    return_date = models.DateField()

    class Meta:
        ordering = ['date']
        

    def __str__(self):
        """String for representing the Model object."""
        return '{0} ({1})'.format(self.bookid, self.title)

