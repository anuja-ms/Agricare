from django.db import models

# Create your models here.
class Tbl_login(models.Model):
    loginid = models.AutoField(primary_key=True)
    username = models.CharField(max_length=25)
    password = models.CharField(max_length=25)
    role = models.CharField(max_length=25)

from adminapp.models import Tbl_panchayath

class Tbl_farmer(models.Model):
    farmerid = models.AutoField(primary_key=True)
    farmername = models.CharField(max_length=25)
    address = models.CharField(max_length=40)
    email = models.CharField(max_length=25)
    contactno = models.BigIntegerField()
    regdate = models.DateField(auto_now_add=True)
    panchayathid = models.ForeignKey(Tbl_panchayath,on_delete=models.CASCADE) 
    loginid = models.ForeignKey(Tbl_login,on_delete=models.CASCADE)



    
