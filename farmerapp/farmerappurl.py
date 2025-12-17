from django.urls import path
from farmerapp import views
urlpatterns = [

path('farmerindex',views.farmerindex,name='farmerindex'),
path('viewproductss',views.viewproductss,name='viewproductss'),
path('viewnotifications/<id>',views.viewnotifications,name='viewnotifications'),
path('sendrequest/<notiid>',views.sendrequest,name='sendrequest'),
path('sendrequest_process',views.sendrequest_process,name='sendrequest_process'),
path('farmerrequest/',views.farmerrequest,name='farmerrequest'),
path('notificationviewss/',views.notificationviewss,name='notificationviewss'),
path('viewmore/<notiid>',views.viewmore,name='viewmore'),
path('viewaccept/', views.viewaccept, name='viewaccept'),
path('payment/<reqid>',views.payment,name='payment'),
path('paymentinsert',views.paymentinsert,name='paymentinsert'),
path('insuranceapplication',views.insuranceapplication,name='insuranceapplication'),
path('fillofficer',views.fillofficer,name='fillofficer'),
path('insuranceview',views.insuranceview,name='insuranceview'),
path('insuranceviewmore/<applyid>',views.insuranceviewmore,name='insuranceviewmore'),
path('applyinsurance/<applyid>',views.applyinsurance,name='applyinsurance'),
path('insuranceprocess',views.insuranceprocess,name='insuranceprocess'),
path('myinsurance',views.myinsurance,name='myinsurance'),
path('myinsuranceviewmore/<insuranceid>',views.myinsuranceviewmore,name='myinsuranceviewmore'),
path('viewtraining',views.viewtraining,name='viewtraining'),
path('viewmoretraining/<trainingid>',views.viewmoretraining,name='viewmoretraining'),
path('farmerprofile/',views.farmerprofile,name='farmerprofile'),
path('editprofile/<farmerid>',views.editprofile,name='editprofile'),
path('logout/',views.logout,name='logout'),










]