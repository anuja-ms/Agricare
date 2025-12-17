from decimal import Decimal, InvalidOperation
from django.http import HttpResponse, JsonResponse
from django.shortcuts import redirect, render
from django.views.decorators.cache import cache_control

from adminapp.models import Tbl_agriofficer, Tbl_panchayath, Tbl_product
from farmerapp.models import Tbl_Request, Tbl_insurance, Tbl_insurancepolicy, Tbl_pay
from guestapp.models import Tbl_farmer
from officerapp.models import Tbl_notification, Tbl_training

# Create your views here.

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def farmerindex(request):
    loginid=request.session.get('loginid')
    if loginid:
        return render(request, "Farmer/farmerindex.html")
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def viewproductss(request):
    loginid=request.session.get('loginid')
    if loginid:
        pv = Tbl_product.objects.all()
        return render(request, "Farmer/viewproductss.html", {'product': pv})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def viewnotifications(request,id):
    loginid=request.session.get('loginid')
    if loginid:
        request.session['productid'] = id
        noti = Tbl_notification.objects.filter(productid=id)
        return render(request,"Farmer/viewnotifications.html", {'noti':noti} )
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


from  datetime import datetime


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def sendrequest(request, notiid):
    loginid=request.session.get('loginid')
    if loginid:
        farmer = Tbl_farmer.objects.get(loginid=request.session['loginid'])
        request.session['notiid'] = notiid
        noti = Tbl_notification.objects.get(notiid=notiid)
        return render(request, "Farmer/sendrequest.html", {'farmer': farmer, 'noti': noti})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


from decimal import Decimal, InvalidOperation

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def sendrequest_process(request):
    loginid=request.session.get('loginid')
    if loginid:
        if request.method == "POST":
            farmerid = request.POST.get("farmer")
            notificationid = request.POST.get("notification")
            totalamount = request.POST.get("totalamount")
            quantity = request.POST.get("quantity")

            # Convert totalamount to a Decimal before saving it
            try:
                totalamount = Decimal(totalamount)
            except InvalidOperation:
                totalamount = Decimal(0.0)  # Fallback if conversion fails

            # Convert quantity to an integer
            try:
                quantity = int(quantity)
            except ValueError:
                quantity = 0  # Fallback if conversion fails, or you can handle it differently

            # Now save the request
            req = Tbl_Request()
            req.status = "Requested"
            req.totalamount = totalamount
            req.quantity = quantity
            req.farmerid = Tbl_farmer.objects.get(farmerid=farmerid)
            req.notiid = Tbl_notification.objects.get(notiid=notificationid)
            req.save()

            # After saving the request, decrease the count of the notification
            notification = req.notiid  # This is the notification object related to the request
            notification.save()  # Save the updated notification
            return HttpResponse("<script>alert('requested successfully ');window.location='/Agricare/notificationviewss';</script>")

        return render(request, "Farmer/sendrequest.html")
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def notificationviewss(request):
    loginid=request.session.get('loginid')
    if loginid:
    
        loginid = request.session.get('loginid')

        if not loginid:
            # Handle the case where the user is not logged in
            return redirect('login')  # Redirect to the login page or show an error

        # Check if the logged-in user is a farmer or an officer
        try:
            # Try to get the farmer by loginid
            farmer = Tbl_farmer.objects.get(loginid=loginid)
            panchayathid = farmer.panchayathid  # Get the panchayath of the farmer
        except Tbl_farmer.DoesNotExist:
            # If the user is not a farmer, try to get the officer
            try:
                officer = Tbl_agriofficer.objects.get(loginid=loginid)
                panchayathid = officer.panchayathid  # Get the panchayath of the officer
            except Tbl_agriofficer.DoesNotExist:
                # If the user is neither a farmer nor an officer, handle appropriately
                return redirect('login')  # Redirect to the login page or show an error

        # Filter notifications based on panchayathid of the logged-in user
        noti = Tbl_notification.objects.filter(officerid__panchayathid=panchayathid)

        # Return the filtered notifications to the template
        return render(request, "Farmer/notificationview.html", {'noti': noti})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def farmerrequest(request):
    loginid=request.session.get('loginid')
    if loginid:
        farmerid = Tbl_farmer.objects.get(loginid = request.session['loginid'])
        requestss=Tbl_Request.objects.filter(farmerid=farmerid)
        return render(request,"Farmer/farmerrequests.html",{'requestss':requestss})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def viewmore(request, notiid):
    loginid=request.session.get('loginid')
    if loginid:
        notification = Tbl_notification.objects.get(notiid=notiid)
        return render(request,"Farmer/viewmore.html",{'n':notification} )
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def payment(request):
    loginid=request.session.get('loginid')
    if loginid:
        farid= Tbl_farmer.objects.get(loginid=request.session['loginid'])
        
        return render(request, "Farmer/payment.html", {'farrid' : farid})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def viewaccept(request):
    loginid=request.session.get('loginid')
    if loginid:
        agriid = Tbl_farmer.objects.get(loginid = request.session['loginid'])
        requestss=Tbl_Request.objects.filter(farmerid=agriid)
        return render(request,"Farmer/viewaccept.html",{'requestss':requestss})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def payment(request,reqid ):
    loginid=request.session.get('loginid')
    if loginid:
        farid= Tbl_farmer.objects.get(loginid=request.session['loginid'])
        req=Tbl_Request.objects.filter(farmerid=farid,reqid=reqid)
        return render(request, "Farmer/payment.html", {'req':req})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def paymentinsert(request):
    loginid=request.session.get('loginid')
    if loginid:
        if request.method == 'POST':
            
            totalamount = request.POST.get("total_amount")
            req = request.POST.get("request")
            
            payment =Tbl_pay()
            payment.status="paid"
            payment.totalamount=totalamount
            payment.reqid=Tbl_Request.objects.get(reqid=req)
            payment.save()
            request=Tbl_Request.objects.get(reqid=req)
            request.status="Paid"
            request.save()
            return HttpResponse("<script>alert('payment successfully completed');window.location='/Agricare/farmerindex';</script>")
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def insuranceapplication(request):
    loginid=request.session.get('loginid')
    if loginid:
        if request.method=='POST':
            farid= Tbl_farmer.objects.get(loginid=request.session['loginid'])
            landdetails=request.POST.get("landdetails")
            cropdetails=request.POST.get("cropdetails")
            description=request.POST.get("description")
            photo1 = request.FILES.get("photo1")
            photo2=request.FILES.get("photo2")
            
            insurance = Tbl_insurancepolicy()
            insurance.Officerid=Tbl_agriofficer.objects.get(officerid=request.POST.get("officer"))
            insurance.status = "Requested"
            insurance.landdetails=landdetails
            insurance.cropdetails=cropdetails
            insurance.description=description
            insurance.photo1=photo1
            insurance.photo2=photo2
            insurance.farmerid=farid
            insurance.save()
            return HttpResponse("<script>alert('successfully completed');window.location='/Agricare/farmerindex';</script>")
        farmer = Tbl_farmer.objects.filter(loginid=request.session['loginid']).first()
        panchayath = Tbl_panchayath.objects.filter(panchayathid=farmer.panchayathid.panchayathid) if farmer else Tbl_panchayath.objects.none()
        return render(request, 'Farmer/insuranceapplication.html', {'panchayath': panchayath})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")
   

@cache_control(no_cache=True, must_revalidate=True, no_store=True)       
def fillofficer(request):
    loginid=request.session.get('loginid')
    if loginid:
        
        did=int(request.POST.get("did"))
        officer= Tbl_agriofficer.objects.filter(panchayathid=did).values()
        return JsonResponse(list(officer),safe=False)    
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")
    
    # return render(request,"Farmer/insuranceform.html")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def insuranceview(request):
    loginid=request.session.get('loginid')
    if loginid:
        farmerid=Tbl_farmer.objects.get(loginid = request.session['loginid'])
        insurance = Tbl_insurancepolicy.objects.filter(farmerid=farmerid, status__in=["Requested", "Confirmed"])
        return render(request, 'farmer/insuranceview.html',{'insurance':insurance})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def insuranceviewmore(request,applyid):
    loginid=request.session.get('loginid')
    if loginid:
        applyid=int(applyid)
        insurance = Tbl_insurancepolicy.objects.get(applyid=applyid)  # This will throw an error if not found    # return HttpResponse(insurance)
        return render(request,"Farmer/insuranceviewmore.html",{'i':insurance,'applyid':applyid} )
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def applyinsurance(request,applyid):
    loginid=request.session.get('loginid')
    if loginid:
        insurance = Tbl_insurancepolicy.objects.get(applyid=applyid)
        return render(request,"Farmer/applyinsurance.html",{'insurance':insurance})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def insuranceprocess(request):
    loginid=request.session.get('loginid')
    if loginid:
        if request.method=='POST':
            applyid = request.POST.get("apply")
            type=request.POST.get("disaster")
            description=request.POST.get("description")
            photo1 = request.FILES.get("photo1")
            photo2=request.FILES.get("photo2")  

            insu = Tbl_insurance()
            insu.type=type
            insu.description=description
            insu.photo1=photo1
            insu.photo2=photo2
            insu.status='Requested'
            insu.applyid = Tbl_insurancepolicy.objects.get(applyid=applyid)
            insu.save()
            return HttpResponse("<script>alert('Submission completed');window.location='/Agricare/insuranceview';</script>")

        return render(request,"Farmer/applyinsurance.html")
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def myinsurance(request):
    loginid=request.session.get('loginid')
    if loginid:
        farmerid=Tbl_farmer.objects.get(loginid = request.session['loginid'])
        insurance=Tbl_insurance.objects.filter(applyid__farmerid=farmerid, status__in=["Visited", "Confirmed"])
        return render(request, 'farmer/myinsurance.html',{'insurance':insurance})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def myinsuranceviewmore(request,insuranceid):
    loginid=request.session.get('loginid')
    if loginid:
        insurance = Tbl_insurance.objects.get(insuranceid=insuranceid)  # This will throw an error if not found    # return HttpResponse(insurance)
        return render(request,"Farmer/myinsuranceviewmore.html",{'i':insurance})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")




@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def viewtraining(request):
    loginid = request.session.get('loginid')

    if loginid:
        try:
            # Get the logged-in farmer
            farmer = Tbl_farmer.objects.get(loginid=loginid)

            # Filter training classes where officer's panchayath matches farmer's panchayath
            trainings = Tbl_training.objects.filter(officerid__panchayathid=farmer.panchayathid)

            return render(request, "Farmer/viewtraining.html", {'training': trainings})

        except Tbl_farmer.DoesNotExist:
            return HttpResponse("<script>alert('Farmer not found. Please check your account.');window.location='/login';</script>")
    else:
        return HttpResponse("<script>alert('Authentication required, please login first.');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)       
def viewmoretraining(request,trainingid):
    loginid=request.session.get('loginid')
    if loginid:
        training = Tbl_training.objects.get(trainingid=trainingid)
        return render(request,"Farmer/viewmoretraining.html",{'training':training})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def farmerprofile(request):
    loginid=request.session.get('loginid')
    if loginid:
        farmerid = Tbl_farmer.objects.get(loginid=request.session['loginid']).farmerid
        farmer = Tbl_farmer.objects.get(farmerid=farmerid)
        return render(request, "Farmer/farmerprofile.html", {'farmer': farmer})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def editprofile(request,farmerid):
    loginid=request.session.get('loginid')
    if loginid:
        loginid=request.session.get('loginid')
        if loginid:
            if request.method=='POST':
                fname=request.POST.get("farmername")
                em=request.POST.get("email")
                cn=request.POST.get("phone")
                off = Tbl_farmer.objects.get(farmerid=farmerid)
                off.farmername = fname
                off.email = em
                off.contactno = cn
                off.save()
                return HttpResponse("<script>alert('Save changes succesfully');window.location='/Agricare/farmerprofile';</script>")
                
            off = Tbl_farmer.objects.get(farmerid=farmerid)
            return render(request,"Farmer/editprofile.html",{'farmer':off})
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def logout(request):
    loginid=request.session.get('loginid')
    if loginid:
        request.session.clear()
        return redirect('/')     
    else:
        return HttpResponse("<script>alert('authentication required,please login first');window.location='/login';</script>")




