from django.contrib import admin

# Register your models here.

from .models import Book, BookInstance, LibUser, Librarian

"""Minimal registration of Models.
admin.site.register(Book)
admin.site.register(Author)
admin.site.register(BookInstance)
admin.site.register(Genre)
admin.site.register(Language)
"""

class LibraianInline(admin.TabularInline):
    model: Librarian
class LibrarianAdmin(admin.ModelAdmin):
    list_display = ('userid',)

admin.site.register(Librarian, LibrarianAdmin)
class LibUserInline(admin.TabularInline):
    model: LibUser

class LibUserAdmin(admin.ModelAdmin):
    list_display = ('userid','username','email')

admin.site.register(LibUser, LibUserAdmin)

# admin.site.register(Domain)



class BooksInline(admin.TabularInline):
    """Defines format of inline book insertion (used in AuthorAdmin)"""
    model = Book




class BooksInstanceInline(admin.TabularInline):
    """Defines format of inline book instance insertion (used in BookAdmin)"""
    model = BookInstance


class BookAdmin(admin.ModelAdmin):
    """Administration object for Book models.
    Defines:
     - fields to be displayed in list view (list_display)
     - adds inline addition of book instances in book view (inlines)
    """
    list_display = ('title', 'author1', 'domain')
    


admin.site.register(Book, BookAdmin)


@admin.register(BookInstance)
class BookInstanceAdmin(admin.ModelAdmin):
    """Administration object for BookInstance models.
    Defines:
     - fields to be displayed in list view (list_display)
     - filters that will be displayed in sidebar (list_filter)
     - grouping of fields into sections (fieldsets)
    """
    list_display = ('title', 'status', 'borrower', 'date', 'bookid')
    list_filter = ('status', 'date')

    fieldsets = (
        (None, {
            'fields': ('title', 'bookid')
        }),
        ('Availability', {
            'fields': ('status', 'date', 'borrower')
        }),
    )