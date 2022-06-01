from tkinter import CASCADE
from django.db import models
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
    username = models.CharField(max_length=100)
    email = models.CharField(max_length=100,null=True)
    designation = models.CharField(max_length=100)
    contact = models.CharField(max_length=10,null=True)
    password = models.CharField(max_length=50)

    class Meta:
        ordering = ['-userid']

    def get_absolute_url(self):
        return reverse('model-detail-view', args=[str(self.userid)])

    def __str__(self):
        return self.userid

# class Domain(models.Model):
    
#     name = models.CharField(
#         max_length=200,
#         help_text="Enter a book domain (e.g. Machine Learning, Data Science etc.)"
#         )

#     def __str__(self):
#         return self.name

class Book(models.Model):
    """Model representing a book (but not a specific copy of a book)."""
    bookid = models.CharField(max_length=20,primary_key=True)
    title = models.CharField(max_length=200)
    secondary_title = models.CharField(max_length=200)
    edition = models.CharField(max_length=20)
    author1 = models.CharField(max_length=200)
    author2 = models.CharField(max_length=200)
    author3 = models.CharField(max_length=200)
    domain = models.CharField(max_length=100)
    # LOAN_STATUS = (
    #     # ('d', 'Maintenance'),
    #     ('o', 'On loan'),
    #     ('a', 'Available'),
    #     # ('r', 'Reserved'),
    # )
    status = models.CharField(
        max_length=10,
        choices=(
        
        ('Available','Available'),('On loan','On loan')
        
    ),
        blank=True,
        default='Available',
        help_text='Book availability')
    
    rack = models.CharField(max_length=5)
    image = models.URLField(max_length=1000)
    
    
    class Meta:
        ordering = ['title', 'author1']

    # def display_domain(self):
    #     """Creates a string for the Genre. This is required to display genre in Admin."""
    #     return ', '.join([domain.name for domain in self.domain.all()[:3]])

    # display_domain.short_description = 'Domain'

    def get_absolute_url(self):
        """Returns the url to access a particular book instance."""
        return reverse('book-detail', args=[str(self.bookid)])

    def __str__(self):
        """String for representing the Model object."""
        return self.title


class BookInstance(models.Model):
    """Model representing a specific copy of a book (i.e. that can be borrowed from the library)."""
    bookid = models.CharField(max_length=20)
    title = models.CharField(max_length=200)
    date = models.DateField(null=True, blank=True)
    borrower = models.CharField(max_length=20)

    # @property
    # def is_overdue(self):
    #     if self.due_back and date.today() > self.due_back:
    #         return True
    #     return False

    # LOAN_STATUS = (
    #     # ('d', 'Maintenance'),
    #     ('o', 'On loan'),
    #     ('a', 'Available'),
    #     # ('r', 'Reserved'),
    # )
    

    status = models.CharField(
        max_length=10,
        choices=( ('Available','Available'), ('On loan','On loan')),
        blank=True,
        )

    class Meta:
        ordering = ['date']
        permissions = (("can_mark_returned", "Set book as returned"),)

    def __str__(self):
        """String for representing the Model object."""
        return '{0} ({1})'.format(self.bookid, self.title)


