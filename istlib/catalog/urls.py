from django.urls import path, include
from . import views

urlpatterns = [
    # path('catalog/', include('catalog.urls')),
    path("signup/",views.signup,name="signup"),
    path("login/",views.login,name="login"),
]