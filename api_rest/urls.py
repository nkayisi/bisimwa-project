from django.urls import path, include

from rest_framework import routers


from .views import *



route = routers.DefaultRouter()


route.register('equipeSecours', EquipeSecoursViewSet)
route.register('utilisateur', UtilisateurViewSet)
route.register('association', AssociationViewSet)
route.register('parking', ParkingViewSet)
route.register('motard', MotardViewSet)
route.register('client', ClientViewSet)
route.register('course', CourseViewSet)
route.register('alerte', AlerteViewSet)
route.register('intervention', InterventionViewSet)



urlpatterns = [
    path('', include(route.urls)),
]
