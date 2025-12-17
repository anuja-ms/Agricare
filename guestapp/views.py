from django.http import HttpResponse
from django.shortcuts import redirect, render
from adminapp.models import Tbl_panchayath
from guestapp.models import Tbl_farmer, Tbl_login
# Create your views here.


def guestindex(request):
    return render(request, "Guest/guestindex.html")

def login(request):
    return render(request, "Guest/login.html")


def login_process (request):
    if request.method == 'POST':
        username = request.POST.get("username")
        password = request.POST.get("password")
        if Tbl_login.objects.filter(username=username, password=password).exists():
            logindata = Tbl_login.objects.get(username=username,password=password)
            request.session['loginid'] = logindata.loginid
            role = logindata.role
            if role == 'admin':
                return redirect('/Agricare/index')
            elif role == 'officer':
                return redirect('/Agricare/officerindex')
            elif role == 'farmer':
                return redirect('/Agricare/farmerindex')
        else :
            return HttpResponse("<script>alert('Invalid Username or Password');window.location='/Agricare/login';</script>")
            
            
def Farmerreg(request):
    panchayath=Tbl_panchayath.objects.all()
    return render(request, 'Guest/Farmerreg.html',{'panchayath':panchayath})




def Farmer_process(request):
    if request.method == "POST":
        lob = Tbl_login()
        lob.username = request.POST.get("username")
        lob.password = request.POST.get("password") 
        lob.role = "farmer"
        if Tbl_login.objects.filter(username=request.POST.get("username")).exists():
            return HttpResponse("<script>alert('Already Exists..');window.location='/Agricare/Farmerreg';</script>")
        else:
            lob.save()
            aob = Tbl_farmer()
            aob.farmername = request.POST.get("name")
            aob.address = request.POST.get("address")
            aob.email = request.POST.get("email")
            aob.contactno = request.POST.get("cno")

            aob.panchayathid = Tbl_panchayath.objects.get(panchayathid=request.POST.get("panchayathname"))
            aob.loginid = lob
            aob.save()
            return HttpResponse("<script>alert('Successfully Registered');window.location='/guestindex';</script>")
