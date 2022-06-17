
from unicodedata import name
from django.shortcuts import redirect, render
import smtplib


# Create your views here.
from django.core.mail import send_mail, BadHeaderError
from django.http import HttpResponse, HttpResponseRedirect
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import  Response
from istlib import settings

from istlib.settings import EMAIL_HOST_USER
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

@api_view(['POST'])
def liblogin(request):
    data = {"success":False, "data":[], "description":None, "err":None}

    id=request.data.get('userid',None)
    password=request.data.get('password',None)
    try:
        if id!=None and password!=None:
            obj=Librarian.objects.get(userid=id)
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

@api_view(['GET'])
def books(request):
    obj = Book.objects.all()
    serializer = BookSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def adminhistory(request):
    obj = BookInstance.objects.all()
    serializer = BookInstanceSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def adminrenewalbooks(request):
    obj = Renewal.objects.all()
    serializer = RenewalSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def lendbooks(request):
    id=request.data.get('userid')
    obj = BookInstance.objects.filter(borrower=id,status = 'Not Available')
    serializer = BookInstanceSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def issuebooks(request):
    # id=request.data.get('userid')
    obj = BookInstance.objects.filter(status = 'Not Available')
    serializer = BookInstanceSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def history(request):
    id=request.data.get('userid')
    obj = BookInstance.objects.filter(borrower=id)
    serializer = BookInstanceSerializers(obj, many=True)
    return Response(serializer.data)
    
@api_view(['POST'])
def updatebooks(request):
    data = {"success":False, "data":[], "description":None, "err":None}

    id = request.data.get('bookid')

    try:
        if id!=None:
            obj=Book.objects.filter(bookid=id)
            obj.update(title=request.data.get('title'))
            obj.update(author1=request.data.get('author1'))
            obj.update(author2=request.data.get('author2'))
            obj.update(author3=request.data.get('author3'))
            obj.update(edition=request.data.get('edition'))
            obj.update(edition=request.data.get('publisher'))
            obj.update(domain=request.data.get('domain'))
            obj.update(status=request.data.get('status'))
            obj.update(rack=request.data.get('rack'))
            data['success']=True
            data["description"]="Book Update Successfully"
        else:
            data['err']="Book not Update"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['POST'])
def createbooks(request):
    data = {"success":False, "data":[], "description":None, "err":None}
   
    try:
        ser=BookSerializers(data=request.data)
        if ser.is_valid():
            ser.save()
            data['success']=True
            data["description"]="Book Created Successfully"

            
        else:
            data['err']=ser.errors
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['POST'])
def deletebook(request):
    data = {"success":False, "data":[], "description":None, "err":None}
    id=request.data.get('bookid')
    try:
        if id != None:
            obj = Book.objects.get(bookid=id)
            obj.delete()
            data['success']=True
            data["description"]="Book Deleted Successfully"
        else:
            data['err']="Book Doesn't exist"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['POST'])
def renewbook(request):
    data = {"success":False, "data":[], "description":None, "err":None}
    id=request.data.get('bookid')
    user=request.data.get('borrower')
    date=request.data.get('date')
    try:
        if id != None and user != None:
            obj = BookInstance.objects.filter(bookid=id).filter(borrower=user).update(date=date)
            Renewal.objects.get(bookid=id).delete()
            data['success']=True
            data["description"]="Book Deleted Successfully"
        else:
            data['err']="Book Doesn't exist"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['POST'])
def user(request):
    id=request.data.get('userid')
    obj = LibUser.objects.get(userid=id)
    serializer = LibUserSerializers(obj, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def book(request):
    id=request.data.get('bookid')
    obj = Book.objects.get(bookid=id)
    serializer = BookSerializers(obj, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def domainbooks(request):
    id=request.data.get('domain')
    obj = Book.objects.filter(domain=id)
    serializer = BookSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def booksearch(request):
    name=request.data.get('title')
    obj = Book.objects.filter(title__contains=name)
    serializer = BookSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def domainsearch(request):
    domain=request.data.get('domain')
    obj = Book.objects.filter(domain__startswith=domain)
    serializer = BookSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def domainbooksearch(request):
    domain=request.data.get('domain')
    name=request.data.get('title')
    obj = Book.objects.filter(domain=domain).filter(title__startswith=name)
    serializer = BookSerializers(obj, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def returnbook(request):
    
    
    data = {"success":False, "data":[], "description":None, "err":None}

    try:
        id=request.data.get('bookid')
        user=request.data.get('userid')

        if user != '' and id != '':
           
            BookInstance.objects.filter(bookid=id).filter(borrower=user).update(status = 'Available')
            Book.objects.filter(bookid=id).update(status = 'Available')
            
            data['success']=True
            data["description"]="Book Return Successfully"
        else:
            data['err']="Book not available"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['POST'])
def borrowbook(request):
    data = {"success":False, "data":[], "description":None, "err":None}

    try:
        id = request.data.get('bookid')
        # print(id)
        ser=BookInstanceSerializers(data=request.data)
        
        if ser.is_valid() and request.data.get('status')=='Not Available':
            # request.data.update(status = 'o')
            # print(request.data.get('status'))
            # serial = BookInstanceSerializers(data=request.data)
            Book.objects.filter(bookid=id).update(status = 'Not Available')
            ser.save()
            
            data['success']=True
            data["description"]="Book Rented Successfully"
        else:
            data['err']="Book not available"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)


@api_view(['POST'])
def renewal(request):
    data = {"success":False, "data":[], "description":None, "err":None}
   
    try:
        ser=RenewalSerializers(data=request.data)
        if ser.is_valid():
            ser.save()
            data['success']=True
            data["description"]="Renewal book"

            # data["data"]=obj.email+" "+"User Created Successfully"
        else:
            data['err']=ser.errors
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

@api_view(['GET'])
def insertbook(request):
    from script import create
    create()
    return Response({})

@api_view(['POST'])
def mail(request):

    # send_mail( 'hai', 'hai', 'kalaiselvanjayavel@gmail.com', ['mani37105@gmail.com'] )
    # return redirect('/api/returnbook')
    data = {"success":False, "data":[], "description":None, "err":None}
    
    user=request.data.get('borrower')
    subject=request.data.get('subject')
    message=request.data.get('message')
    try:
        if user != None:
            field_name = 'email'
            obj = LibUser.objects.get(userid=user)
            field_object = LibUser._meta.get_field(field_name)
            field_value = field_object.value_from_object(obj)
            send_mail( subject, message, 'kalaiselvanjayavel@gmail.com', [field_value] )
            data['success']=True
            data["description"]="Mail sent Successfully"
        else:
            data['err']="Mail Doesn't send"
    except Exception as e:
        data["err"]=str(e)
    # print(data)
    return Response(data)

# subject = ['welcome to GFG world']
# message = 'Hi , thank you for registering in geeksforgeeks.'
# email_from = settings.EMAIL_HOST_USER
# recipient_list = ['karthickmassj12@gmail.com' ]

    # subject = request.POST.get('subject','hai')
    # message = request.POST.get('message','hai')
    # from_email = request.POST.get('from_email','kalaiselvanjayavel@gmail.com')
    # if subject and message and from_email:
    #     try:
    #         send_mail(subject, message, from_email, ['karthickmassj12@gmail.com.com'])
    #     except BadHeaderError:
    #         return HttpResponse('Invalid header found.')
    #     return HttpResponseRedirect()
    #     return ('success')
    # else:
    #     # In reality we'd use a form class
    #     # to get proper validation errors.
    #     return HttpResponse('Make sure all fields are entered and valid.')