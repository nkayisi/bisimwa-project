from rest_framework import viewsets
from rest_framework import status
from django.shortcuts import get_object_or_404

from helpers.helpers import matriculeGenerator

from rest_framework.authtoken.models import Token

from .models import *
from .serializer import *



class CeniViewSet(viewsets.ModelViewSet):

    def get_queryset(self):
        numero_national = self.request.GET.get('numero_national')
        if numero_national is not None :
            queryset = Ceni.objects.filter(numero_national=numero_national)
        else:
            queryset = Ceni.objects.all()
    
        return queryset
    
    serializer_class = CeniSerializer




class CurrentUserViewSet(viewsets.ModelViewSet):
        
    serializer_class = CustomUserSerializer

    def get_queryset(self):
        user_token = self.request.GET.get('token')
        if user_token is not None :
            data = Token.objects.get(key=user_token)

            queryset = CustomUser.objects.filter(pk=data.user.id)
            
        return queryset





class EquipeSecoursViewSet(viewsets.ModelViewSet):
    queryset = EquipeSecours.objects.all()
    serializer_class = EquipeSecoursSerializer

    def create(self, request, *args, **kwargs):
        api_data = request.data

        api_data._mutable=True
    
        username = api_data.pop('username')
        password = api_data.pop('password')

        user = CustomUser.objects.create_user(
            username=username[0], 
            password=password[0]
        )

        user.equipe_secours = True
        user.save()

        api_data['user'] = user.id

        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
    
    
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class UtilisateurViewSet(viewsets.ModelViewSet):

    def get_queryset(self):
        numero_national = self.request.GET.get('numero_national')
        if numero_national is not None :
            queryset = Utilisateur.objects.filter(numero_national=numero_national)
        else :
            queryset = Utilisateur.objects.all()
            
        return queryset

    serializer_class = UtilisateurSerializer



class MembreEquipeSecoursViewSet(viewsets.ModelViewSet):
    serializer_class = MembreEquipeSecoursSerializer

    def get_queryset(self):
        equipe_secours = self.request.GET.get('equipe_secours')
        if equipe_secours is not None :
            queryset = MembreEquipeSecours.objects.filter(equipe_secours=equipe_secours)
        else :
            queryset = MembreEquipeSecours.objects.all()
            
        return queryset


    def create(self, request, *args, **kwargs):
        api_data = request.data

        api_data._mutable=True
    
        username = api_data.pop('username')
        password = api_data.pop('password')

        user = CustomUser.objects.create_user(
            username=username[0], 
            password=password[0]
        )

        user.is_membre_equipe_secours = True
        user.save()

        api_data['user'] = user.id


        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
    
    
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class AssociationViewSet(viewsets.ModelViewSet):
    queryset = Association.objects.all()
    serializer_class = AssociationSerializer


    def create(self, request, *args, **kwargs):
        api_data = request.data

        api_data._mutable=True
    
        username = api_data.pop('username')
        password = api_data.pop('password')

        user = CustomUser.objects.create_user(
            username=username[0], 
            password=password[0]
        )

        user.is_association = True
        user. save()

        api_data['user'] = user.id

        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
    
    
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class ParkingViewSet(viewsets.ModelViewSet):
    serializer_class = ParkingSerializer

    def get_queryset(self):
        association = self.request.GET.get('association')
        if association is not None :
            queryset = Parking.objects.filter(association=association)
        else :
            queryset = Parking.objects.all()
            
        return queryset

    
    def create(self, request, *args, **kwargs):

        api_data = request.data
        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        
        
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)




class MotardViewSet(viewsets.ModelViewSet):
    serializer_class = MotardSerializer

    def get_queryset(self):
        association = self.request.GET.get('association')
        matricule = self.request.GET.get('matricule')
        if association is not None :
            queryset = Motard.objects.filter(association=association)
        if matricule is not None :
            queryset = Motard.objects.filter(matricule=matricule)
        else :
            queryset = Motard.objects.all()
            
        return queryset


    def create(self, request, *args, **kwargs):
        api_data = request.data

        api_data._mutable=True
    
        username = api_data.pop('username')
        password = api_data.pop('password')

        user = CustomUser.objects.create_user(
            username=username[0], 
            password=password[0]
        )

        user.motard = True
        user.save()

        api_data['user'] = user.id
        api_data['matricule'] = matriculeGenerator()

        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
    
    
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all()
    serializer_class = ClientSerializer

    def create(self, request, *args, **kwargs):
        api_data = request.data

        # api_data._mutable=True
    
        username = api_data.pop('username')
        password = api_data.pop('password')
        birthday = api_data['date_naissance'].split(' ')[0]
        

        user = CustomUser.objects.create_user(
            username=username, 
            password=password
        )

        user.client = True
        user.save()

        client = Client.objects.create(
            adresse=api_data['adresse'],
            date_naissance=birthday,
            etat_civil=api_data['etat_civil'],
            genre=api_data['genre'],
            nom=api_data['nom'],
            numero_national=api_data['numero_national'],
            photo='',
            post_nom=api_data['post_nom'],
            prenom=api_data['prenom'],
            profession=api_data['profession'],
            telephone=api_data['telephone'],
            user=user
        )
    
        serializer = ClientSerializer(client)
    
        return Response(serializer.data, status=status.HTTP_201_CREATED)
        # return Response([])



class CourseViewSet(viewsets.ModelViewSet):
    # queryset = Course.objects.all()
    serializer_class = CourseSerializer

    def get_queryset(self):
        user_token = self.request.GET.get('token')
        if user_token is not None :
            data = Token.objects.get(key=user_token)

            queryset = Course.objects.filter(client=data.user.id)
        else:
            queryset = Course.objects.all()
            
        return queryset
    

    def create(self, request, *args, **kwargs):
        api_data = request.data
        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        
        
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class AlerteViewSet(viewsets.ModelViewSet):
    queryset = Alerte.objects.all()
    serializer_class = AlerteSerializer

    def create(self, request, *args, **kwargs):
        api_data = request.data
        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        
        
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)



class InterventionViewSet(viewsets.ModelViewSet):
    serializer_class = InterventionSerializer

    def get_queryset(self):
        equipe_secours = self.request.GET.get('equipe_secours')
        if equipe_secours is not None :
            queryset = Intervention.objects.filter(equipe_secours=equipe_secours)
        else :
            queryset = Intervention.objects.all()
            
        return queryset

    
    def create(self, request, *args, **kwargs):
        api_data = request.data
        serializer = self.get_serializer(data=api_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        
        
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)