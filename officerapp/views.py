from email.message import EmailMessage
from pyexpat.errors import messages
import smtplib
from urllib import request

from django.http import HttpResponse, JsonResponse
from django.shortcuts import redirect, render

from adminapp.models import Tbl_agriofficer, Tbl_product
from farmerapp.models import Tbl_Request, Tbl_insurance, Tbl_insurancepolicy, Tbl_pay
from officerapp.models import Tbl_notification, Tbl_service, Tbl_training

# Create your views here.
def officerindex(request):
    return render(request, "Officer/officerindex.html")


def notification(request):
    product=Tbl_product.objects.all()
    return render(request, 'Officer/notification.html',{'product':product})

def noti_process(request):
    if request.method == "POST":
        pnoti=request.POST.get("noti")
        tdate=request.POST.get("todate")
        fdate=request.POST.get("frdate")
        cnt=request.POST.get("count")
        amt=request.POST.get("amount")
        pid=request.POST.get("productid")
        ofid=Tbl_agriofficer.objects.get(loginid=request.session['loginid'])
        pro = Tbl_product.objects.get(productid=pid)
        noti=Tbl_notification()
        noti.notification=pnoti
        noti.frdate=fdate
        noti.todate=tdate
        noti.count=cnt
        noti.amount=amt
        noti.officerid=ofid
        noti.productid=pro
        if len(request.FILES)!=0:
           img=request.FILES['images']
        else:
            img='images/default.jpg'
        noti.image=img
        noti.save()
        return HttpResponse("<script>alert('Successfully Registered');window.location='/Agricare/viewnoti';</script>")
    
def viewnoti(request):
    agriid = Tbl_agriofficer.objects.get(loginid = request.session['loginid'])
    noti=Tbl_notification.objects.filter(officerid=agriid)
    return render(request,"Officer/viewnoti.html",{'noti':noti})

def editnoti(request, notiid):
    if request.method == 'POST':
        nname = request.POST.get("notiname")
        fdate = request.POST.get("fdate")
        tdate = request.POST.get("tdate")
        count = request.POST.get("count")
        amount = request.POST.get("amount")
        cimage = request.POST.get("oldimage")

        n = Tbl_notification.objects.get(notiid=notiid)
        n.notification = nname
        n.count = count
        n.amount = amount

        # Handle Image
        if 'cimage' in request.FILES:
            n.image = request.FILES["cimage"]
        else:
            n.image = request.POST.get("oldimage")

        # Handle From Date
        if fdate:
            n.frdate = fdate

        # Handle To Date
        if tdate:
            n.todate = tdate

        n.save()
        return viewnoti(request)

    n = Tbl_notification.objects.get(notiid=notiid)
    return render(request, "Officer/editnoti.html", {'n': n})


def deletenoti(request,notiid):
    noti = Tbl_notification.objects.get(notiid=notiid)
    noti.delete()
    return HttpResponse("<script>alert('Successfully Deleted..');window.location='/Agricare/viewnoti'</script>")


def viewrequest(request):
    agriid = Tbl_agriofficer.objects.get(loginid = request.session['loginid'])
    requestss=Tbl_Request.objects.filter(notiid__officerid=agriid,status='Requested')
    return render(request,"Officer/viewrequest.html",{'requestss':requestss})

def requestaccept(request, id):
    try:
        # Get the request object
        requests = Tbl_Request.objects.get(reqid=id)
        
        # Get the related notification object
        notification = requests.notiid

        # Check if enough quantity is available
        if notification.count >= requests.quantity:
            # Reduce the product count
            notification.count -= requests.quantity
            notification.save()

            # Update request status
            requests.status = 'Confirmed'
            requests.save()

            return viewacceptedrejectedpro(request)
        else:
            # Handle case where there is not enough quantity
            messages.error(request, "Insufficient product quantity available.")
            return redirect('notification_viewmore')  # Redirect to the view more page
    except Tbl_Request.DoesNotExist:
        messages.error(request, "Request not found.")
        return redirect('notification_viewmore')
    except Exception as e:
        messages.error(request, f"An error occurred: {e}")
        return redirect('notification_viewmore')


def requestreject(request,id):
    requests = Tbl_Request.objects.get(reqid=id)
    requests.status='Rejected'
    requests.save()
    return viewacceptedrejectedpro(request)

def viewacceptedrejectedpro(request):
    agriid = Tbl_agriofficer.objects.get(loginid = request.session['loginid'])
    requestss=Tbl_Request.objects.filter(notiid__officerid=agriid)
    return render(request,"Officer/viewacceptedrejectedpro.html",{'requestss':requestss})

def service(request):
    return render(request, 'Officer/service.html')

def service_process(request):
    if request.method == "POST":
        srname=request.POST.get("servicename")
        srob = Tbl_service()
        srob.servicename = srname 
         

        if Tbl_service.objects.filter(servicename=srname).exists():
            return HttpResponse("<script>alert('Already Exists..');window.location='/Officer/service';</script>")
        else:
            srob.save()
            return HttpResponse("<script>alert('Successfully Inserted');window.location='/Agricare/viewservice';</script>")
        
        
def viewservice(request):
    service=Tbl_service.objects.all()
    return render(request,"Officer/viewservice.html",{'service':service})

def deleteservice(request,serviceid):
    srob = Tbl_service.objects.get(serviceid=serviceid)
    srob.delete()
    return HttpResponse("<script>alert('Successfully Deleted..');window.location='/Agricare/viewservice'</script>")


def viewinsurance(request):
    # Get the logged-in officer's information
    agriid = Tbl_agriofficer.objects.get(loginid=request.session['loginid'])

    # Get the status filter from the GET request (if provided)
    status_filter = request.GET.get('status', '')  # default to empty string if not selected

    # Filter the insurance policies based on the officer and the status (if provided)
    if status_filter:
        insurance = Tbl_insurancepolicy.objects.filter(Officerid=agriid, status=status_filter)
    else:
        # Get all insurance policies for the officer if no filter is applied
        insurance = Tbl_insurancepolicy.objects.filter(Officerid=agriid)

    return render(request, 'Officer/viewinsurance.html', {'insurance': insurance})


def viewmoreinsurance(request,applyid):
    insurance = Tbl_insurancepolicy.objects.filter(applyid=applyid)
    return render(request,"Officer/viewmoreinsurance.html",{'insurance':insurance} )

def insuranceaccept(request,applyid):
    insurance = Tbl_insurancepolicy.objects.get(applyid=applyid)
    date=request.POST.get("date")
    if request.method=="POST":
        insurance.remarkdate=date
        insurance.status='Confirmed'
        insurance.save()
       
        return HttpResponse("<script>alert('requested successfully ');window.location='/Agricare/viewinsurance';</script>")

    return render(request,"Officer/remark.html" )

def insurancereject(request,applyid):
    insurance = Tbl_insurancepolicy.objects.get(applyid=applyid)
    insurance.status='Rejected'
    insurance.save()
    return viewinsurance(request)

def viewinsuranceapp(request):
    agriid=Tbl_agriofficer.objects.get(loginid = request.session['loginid'])
    insuranceapplication=Tbl_insurance.objects.filter(applyid__Officerid=agriid,status='Requested')
    return render(request, 'Officer/viewinsuranceapplication.html',{'insuranceapplication':insuranceapplication})

def viewmoreinsuranceapp(request,insid):
    insurance = Tbl_insurance.objects.filter(insuranceid=insid)
    return render(request,"Officer/viewmoreapp.html",{'insurance':insurance} )

def insuranceappaccept(request,insid):
    insurance = Tbl_insurance.objects.get(insuranceid=insid)
    date=request.POST.get("date")
    if request.method=="POST":
        insurance.remarkdate=date
        insurance.status='Confirmed'
        insurance.save()

    
        return HttpResponse("<script>alert('Confirmed successfully ');window.location='/Agricare/acceptedinsuranceapp';</script>")

    return render(request,"Officer/checkdate.html" )

def insuranceappreject(request,insid):
    insurance = Tbl_insurance.objects.get(insuranceid=insid)
    insurance.status='Rejected'
    insurance.save()
    return viewinsuranceapp(request)


def acceptedinsuranceapp(request):
    agriid=Tbl_agriofficer.objects.get(loginid = request.session['loginid'])
    insuranceapplication=Tbl_insurance.objects.filter(applyid__Officerid=agriid,status='Confirmed')
    return render(request, 'Officer/acceptedinsuranceapp.html',{'insuranceapplication':insuranceapplication})


def acceptedinsuranceviewmore(request,insid):
    insurance = Tbl_insurance.objects.filter(insuranceid=insid)
    return render(request,"Officer/acceptedinsuranceviewmore.html",{'insurance':insurance} )

def insurancecompletion(request,insid):
    insurance = Tbl_insurance.objects.get(insuranceid=insid)
    amt=request.POST.get("amount")
    if request.method=="POST":
        insurance.amount=amt
        insurance.status='Visited'
        insurance.save()
        return HttpResponse("<script>alert('Completed');window.location='/Agricare/officerindex';</script>")

    return render(request,"Officer/insurancecompletion.html",{'insurance':insurance})

def addtraining(request):
    ofid=Tbl_agriofficer.objects.get(loginid=request.session['loginid'])
    tname=request.POST.get("tname")
    desc=request.POST.get("desc")
    date=request.POST.get("date")
    training = Tbl_training()
    if request.method=='POST':
        training.trainingname=tname
        training.description=desc
        training.date=date
        training.officerid=ofid
        training.status='Published'
        if len(request.FILES)!=0:
           img=request.FILES['images']
        else:
            img='images/default.jpg'
        training.image=img
        training.save()
        return HttpResponse("<script>alert('Successfully Inserted..');window.location='/Agricare/viewtariningclass'</script>")
    return render(request,"Officer/addtraining.html")



def viewtariningclass(request):
    agriid = Tbl_agriofficer.objects.get(loginid=request.session['loginid'])
    train = Tbl_training.objects.filter(officerid=agriid, status='Published')
    return render(request, 'Officer/viewtrainingclass.html', {'train': train})


def edittraining(request,trainingid):
    if request.method=='POST':
        tname=request.POST.get("trainingname")
        desc=request.POST.get("description")
        date=request.POST.get("date")
        cimage=request.POST.get("oldimage")
        tra = Tbl_training.objects.get(trainingid=trainingid)
        tra.trainingname = tname
        tra.description = desc
        tra.date=date
        tra.image = cimage
        if 'cimage' in request.FILES:
            tra.image = request.FILES["cimage"]
        else:
            tra.image = request.POST.get("oldimage")

        tra.save()
        return viewtariningclass(request)
    tra = Tbl_training.objects.get(trainingid=trainingid)
    return render(request,"Officer/edittraining.html",{'tra':tra})


def deletetraining(request,trainingid):
    train = Tbl_training.objects.get(trainingid=trainingid)
    train.delete()
    return HttpResponse("<script>alert('Successfully Deleted..');window.location='/Agricare/viewtariningclass'</script>")



def viewpayment(request):
    agriid = Tbl_agriofficer.objects.get(loginid=request.session['loginid'])
    pay = Tbl_pay.objects.filter(reqid__notiid__officerid=agriid)
    return render(request, 'Officer/viewpayment.html', {'pay': pay})


def viewprofile(request):
   officerid = Tbl_agriofficer.objects.get(loginid=request.session['loginid']).officerid
   officer = Tbl_agriofficer.objects.get(officerid=officerid)
   return render(request, "Officer/viewprofile.html", {'officer': officer})


def editoffprofile(request,officerid):
    if request.method=='POST':
        oname=request.POST.get("officername")
        em=request.POST.get("email")
        cn=request.POST.get("phone")
        off = Tbl_agriofficer.objects.get(officerid=officerid)
        off.officername = oname
        off.email = em
        off.contactno = cn
        off.save()
        return HttpResponse("<script>alert('Save changes succesfully');window.location='/Agricare/viewprofile';</script>")
        
    off = Tbl_agriofficer.objects.get(officerid=officerid)
    return render(request,"Officer/editoffprofile.html",{'officer':off})
