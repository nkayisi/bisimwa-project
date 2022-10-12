from django.urls import path, include

from rest_framework import routers


from .views import *



route = routers.DefaultRouter()


route.register('equipeSecours', EquipeSecoursViewSet, basename='equipeSecourse')
route.register('utilisateur', UtilisateurViewSet, basename='utilisateur')
route.register('membreEquipeSecours', MembreEquipeSecoursViewSet, 'membreEquipeSecours')
route.register('association', AssociationViewSet, basename='association')
route.register('parking', ParkingViewSet, basename='parking')
route.register('motard', MotardViewSet, basename='motard')
route.register('client', ClientViewSet, basename='client')
route.register('course', CourseViewSet, basename='course')
route.register('alerte', AlerteViewSet, basename='alerte')
route.register('intervention', InterventionViewSet, basename='intervention')
route.register('currentUser', CurrentUserViewSet, basename='currentUser')



urlpatterns = [
    path('', include(route.urls)),
    path('auth/', include('dj_rest_auth.urls'))
]
