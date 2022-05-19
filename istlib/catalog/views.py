from django.shortcuts import render


# Create your views here.
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import  Response
from .models import *
from .serializers import *


@api_view(['POST'])
def signup(request):
    data = {"success":False, "data":[], "description":None, "err":None}
   
    try:
        ser=LibUserSerializers(data=request.data)
        if ser.is_valid():
            ser.save()
            data['success']=True
            data["description"]="User Created Successfully"

            # data["data"]=obj.email+" "+"User Created Successfully"
        else:
            data['err']=ser.errors
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)


@api_view(['POST'])
def login(request):
    data = {"success":False, "data":[], "description":None, "err":None}

    id=request.data.get('userid',None)
    password=request.data.get('password',None)
    try:
        if id!=None and password!=None:
            obj=LibUser.objects.get(userid=id)
            if obj.password == password:
                data['success']=True
                data['description']='login successfully'
            else:
                data['err']='password mismatch'
        else:
            data["err"]="missing fields ."
    except Exception as e:
        data["err"]=str(e)
    
    return Response(data)


# def index(request):
#     """View function for home page of site."""
#     # Generate counts of some of the main objects
#     num_books = Book.objects.all().count()
#     num_instances = BookInstance.objects.all().count()
#     # Available copies of books
#     num_instances_available = BookInstance.objects.filter(status__exact='a').count()
    
#     # Number of visits to this view, as counted in the session variable.
#     num_visits = request.session.get('num_visits', 1)
#     request.session['num_visits'] = num_visits+1

#     # Render the HTML template index.html with the data in the context variable.
#     return render(
#         request,
#         'index.html',
#         context={'num_books': num_books, 'num_instances': num_instances,
#                  'num_instances_available': num_instances_available, 
#                  'num_visits': num_visits},
#     )


# from django.views import generic


# class BookListView(generic.ListView):
#     """Generic class-based view for a list of books."""
#     model = Book
#     paginate_by = 10


# class BookDetailView(generic.DetailView):
#     """Generic class-based detail view for a book."""
#     model = Book





# from django.contrib.auth.mixins import LoginRequiredMixin


# class LoanedBooksByUserListView(LoginRequiredMixin, generic.ListView):
#     """Generic class-based view listing books on loan to current user."""
#     model = BookInstance
#     template_name = 'catalog/bookinstance_list_borrowed_user.html'
#     paginate_by = 10

#     def get_queryset(self):
#         return BookInstance.objects.filter(borrower=self.request.user).filter(status__exact='o').order_by('due_back')


# # Added as part of challenge!
# from django.contrib.auth.mixins import PermissionRequiredMixin


# class LoanedBooksAllListView(PermissionRequiredMixin, generic.ListView):
#     """Generic class-based view listing all books on loan. Only visible to users with can_mark_returned permission."""
#     model = BookInstance
#     permission_required = 'catalog.can_mark_returned'
#     template_name = 'catalog/bookinstance_list_borrowed_all.html'
#     paginate_by = 10

#     def get_queryset(self):
#         return BookInstance.objects.filter(status__exact='o').order_by('due_back')


# from django.shortcuts import get_object_or_404
# from django.http import HttpResponseRedirect
# from django.urls import reverse
# import datetime
# from django.contrib.auth.decorators import login_required, permission_required

# # from .forms import RenewBookForm
# from catalog.forms import RenewBookForm


# @login_required
# @permission_required('catalog.can_mark_returned', raise_exception=True)
# def renew_book_librarian(request, pk):
#     """View function for renewing a specific BookInstance by librarian."""
#     book_instance = get_object_or_404(BookInstance, pk=pk)

#     # If this is a POST request then process the Form data
#     if request.method == 'POST':

#         # Create a form instance and populate it with data from the request (binding):
#         form = RenewBookForm(request.POST)

#         # Check if the form is valid:
#         if form.is_valid():
#             # process the data in form.cleaned_data as required (here we just write it to the model due_back field)
#             book_instance.due_back = form.cleaned_data['renewal_date']
#             book_instance.save()

#             # redirect to a new URL:
#             return HttpResponseRedirect(reverse('all-borrowed'))

#     # If this is a GET (or any other method) create the default form
#     else:
#         proposed_renewal_date = datetime.date.today() + datetime.timedelta(weeks=3)
#         form = RenewBookForm(initial={'renewal_date': proposed_renewal_date})

#     context = {
#         'form': form,
#         'book_instance': book_instance,
#     }

#     return render(request, 'catalog/book_renew_librarian.html', context)


# from django.views.generic.edit import CreateView, UpdateView, DeleteView
# from django.urls import reverse_lazy
# from .models import Book






# class BookCreate(PermissionRequiredMixin, CreateView):
#     model = Book
#     fields = ['title', 'author', 'summary', 'isbn', 'genre', 'language']
#     permission_required = 'catalog.can_mark_returned'


# class BookUpdate(PermissionRequiredMixin, UpdateView):
#     model = Book
#     fields = ['title', 'author1', 'summary', 'isbn', 'genre', 'language']
#     permission_required = 'catalog.can_mark_returned'


# class BookDelete(PermissionRequiredMixin, DeleteView):
#     model = Book
#     success_url = reverse_lazy('books')
#     permission_required = 'catalog.can_mark_returned'
