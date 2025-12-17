from django.urls import path
from guestapp import views
urlpatterns = [

path('',views.guestindex,name='guestindex'),
path('login',views.login,name='login'),
path('login_process',views.login_process,name='login_process'),
path('Farmerreg',views.Farmerreg,name='Farmerreg'),
path('Farmer_process',views.Farmer_process,name='Farmer_process'),




]