from django.contrib import admin

# Register your models here.

from .models import Domain, Book, BookInstance, LibUser

"""Minimal registration of Models.
admin.site.register(Book)
admin.site.register(Author)
admin.site.register(BookInstance)
admin.site.register(Genre)
admin.site.register(Language)
"""

class LibUserInline(admin.TabularInline):
    model: LibUser

class LibUserAdmin(admin.ModelAdmin):
    list_display = ('userid','username','email')

admin.site.register(LibUser, LibUserAdmin)

admin.site.register(Domain)



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
    list_display = ('title', 'author1', 'display_domain')
    inlines = [BooksInstanceInline]


admin.site.register(Book, BookAdmin)


@admin.register(BookInstance)
class BookInstanceAdmin(admin.ModelAdmin):
    """Administration object for BookInstance models.
    Defines:
     - fields to be displayed in list view (list_display)
     - filters that will be displayed in sidebar (list_filter)
     - grouping of fields into sections (fieldsets)
    """
    list_display = ('title', 'status', 'borrower', 'due_back', 'bookid')
    list_filter = ('status', 'due_back')

    fieldsets = (
        (None, {
            'fields': ('title', 'imprint', 'bookid')
        }),
        ('Availability', {
            'fields': ('status', 'due_back', 'borrower')
        }),
    )