from django.db import models

from adminapp.models import Tbl_agriofficer
from guestapp.models import Tbl_farmer
from officerapp.models import Tbl_notification

# Create your models here.

class Tbl_Request(models.Model):
    reqid = models.AutoField(primary_key=True)
    farmerid = models.ForeignKey(Tbl_farmer,on_delete=models.CASCADE) 
    quantity = models.IntegerField()
    notiid = models.ForeignKey(Tbl_notification,on_delete=models.CASCADE)
    status = models.CharField(max_length=50)
    totalamount = models.IntegerField(default=0)

class Tbl_pay(models.Model):
    paymentid = models.AutoField(primary_key=True)
    reqid = models.ForeignKey(Tbl_Request,on_delete=models.CASCADE)
    totalamount = models.IntegerField()
    paydate = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=50)

class Tbl_insurancepolicy(models.Model):
    applyid=models.AutoField(primary_key=True)
    farmerid = models.ForeignKey(Tbl_farmer,on_delete=models.CASCADE)
    Officerid = models.ForeignKey(Tbl_agriofficer,on_delete=models.CASCADE,default='')
    landdetails = models.TextField()
    cropdetails = models.TextField()
    applydate = models.DateField(auto_now_add=True)
    description = models.TextField()
    status = models.CharField(max_length=25)
    remarkdate = models.DateField(null=True)
    photo1 = models.ImageField()
    photo2 = models.ImageField()


class Tbl_insurance(models.Model):
    insuranceid = models.AutoField(primary_key=True)
    applyid = models.ForeignKey(Tbl_insurancepolicy,on_delete=models.CASCADE)
    description = models.TextField()
    type = models.CharField(max_length=50, default=0)
    photo1 = models.ImageField()
    photo2 = models.ImageField()
    remarkdate = models.DateField(null=True)
    amount = models.IntegerField(null=True)
    status = models.CharField(max_length=50)