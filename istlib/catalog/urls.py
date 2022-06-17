from django.urls import path, include

from . import views

urlpatterns = [
    # path('catalog/', include('catalog.urls')),
    path("signup/",views.signup,name="signup"),
    path("login/",views.login,name="login"),
    path("liblogin/",views.liblogin,name="liblogin"),
    path("books/",views.books,name="books"),
    path("createbooks/",views.createbooks,name="createbooks"),
    path("updatebooks/",views.updatebooks,name="updatebooks"),
    path("deletebook/",views.deletebook,name="deletebook"),
    path("lendbooks/",views.lendbooks,name="lendbooks"),
    path("returnbook/",views.returnbook,name="returnbook"),
    path("renewbook/",views.renewbook,name="renewbook"),
    path("issuebooks/",views.issuebooks,name="issuebooks"),
    path("adminrenewalbooks/",views.adminrenewalbooks,name="adminrenewalbooks"),
    path("history/",views.history,name="history"),
    path("adminhistory/",views.adminhistory,name="adminhistory"),
    path("domainbooks/",views.domainbooks,name="domainbooks"),
    path("domainsearch/",views.domainsearch,name="domainsearch"),
    path("domainbooksearch/",views.domainbooksearch,name="domainbooksearch"),
    path("book/",views.book,name="book"),
    path("user/",views.user,name="user"),
    path("borrowbook/",views.borrowbook,name="borrowbook"),
    path("insertbook/",views.insertbook,name="insertbook"),
    path("renewal/",views.renewal,name="renewal"),
    path("search/",views.booksearch,name="search"),
    path("mail/",views.mail,name="mail"),
]