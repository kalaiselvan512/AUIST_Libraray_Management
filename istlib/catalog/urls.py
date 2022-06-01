from django.urls import path, include

from . import views

urlpatterns = [
    # path('catalog/', include('catalog.urls')),
    path("signup/",views.signup,name="signup"),
    path("login/",views.login,name="login"),
    path("liblogin/",views.liblogin,name="liblogin"),
    path("books/",views.books,name="books"),
    path("createbooks/",views.createbooks,name="createbooks"),
    path("lendbooks/",views.lendbooks,name="lendbooks"),
    path("issuebooks/",views.issuebooks,name="issuebooks"),
    path("history/",views.history,name="history"),
    path("book/",views.book,name="book"),
    path("borrowbook/",views.borrowbook,name="borrowbook"),
]