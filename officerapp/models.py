from django.db import models

from adminapp.models import Tbl_agriofficer, Tbl_product

class Tbl_notification(models.Model):
    notiid = models.AutoField(primary_key=True)
    productid = models.ForeignKey(Tbl_product,on_delete=models.CASCADE) 
    notification = models.CharField(max_length=100)
    frdate = models.DateField()
    todate = models.DateField()
    count = models.IntegerField()
    amount = models.DecimalField(max_digits=5, decimal_places=2)
    officerid = models.ForeignKey(Tbl_agriofficer, on_delete=models.CASCADE, null=True, blank=True)
    image = models.ImageField(null=True, blank=True)

class Tbl_service(models.Model):
    serviceid = models.AutoField(primary_key=True)
    servicename = models.CharField(max_length=50)

class Tbl_training(models.Model):
    trainingid = models.AutoField(primary_key=True)
    trainingname = models.CharField(max_length=50)
    description = models.CharField(max_length=1050)
    status = models.CharField(max_length=30,null=True)
    date = models.DateField()
    cdate = models.DateField(auto_now_add=True)
    image = models.ImageField(null=True, blank=True)
    officerid = models.ForeignKey(Tbl_agriofficer, on_delete=models.CASCADE, null=True, blank=True)
