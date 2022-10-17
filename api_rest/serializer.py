from rest_framework import serializers
from .models import *


class CeniSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Ceni
        fields = '__all__'



class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = '__all__'
        extra_kwargs = {
            'password': {
                'write_only': True
            },
            'user_permissions': {
                'write_only': True
            },
            'groups': {
                'write_only': True
            }
        }



class EquipeSecoursSerializer(serializers.ModelSerializer):

    user = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=False)

    class Meta:
        model = EquipeSecours
        fields = '__all__'


    def to_representation(self, instance):
        self.fields['user'] = CustomUserSerializer(read_only=True)
        return super(EquipeSecoursSerializer, self).to_representation(instance)



class UtilisateurSerializer(serializers.ModelSerializer):

    user = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=False)

    class Meta:
        model = Utilisateur
        fields = '__all__'
        
    def to_representation(self, instance):
        self.fields['user'] = CustomUserSerializer(read_only=True)
        return super(UtilisateurSerializer, self).to_representation(instance)



class AssociationSerializer(serializers.ModelSerializer):

    user = serializers.PrimaryKeyRelatedField(queryset=CustomUser.objects.all(), many=False)
    
    class Meta:
        model = Association
        fields = '__all__'

    def to_representation(self, instance):
        self.fields['user'] = CustomUserSerializer(read_only=True)
        return super(AssociationSerializer, self).to_representation(instance)



class ParkingSerializer(serializers.ModelSerializer):

    association = serializers.PrimaryKeyRelatedField(queryset=Association.objects.all(), many=False)

    class Meta:
        model = Parking
        fields = '__all__'

    def to_representation(self, instance):
        self.fields['association'] = AssociationSerializer(read_only=True)
        return super(ParkingSerializer, self).to_representation(instance)


class MembreEquipeSecoursSerializer(serializers.ModelSerializer):

    equipe_secours = serializers.PrimaryKeyRelatedField(queryset=EquipeSecours.objects.all(), many=False)

    class Meta:
        model = MembreEquipeSecours
        fields = '__all__'

    def to_representation(self, instance):
        self.fields['equipe_secours'] = MembreEquipeSecoursSerializer(read_only=True)
        return super(MembreEquipeSecoursSerializer, self).to_representation(instance)


class MotardSerializer(UtilisateurSerializer):

    parking = serializers.PrimaryKeyRelatedField(queryset=Parking.objects.all(), many=False)

    class Meta:
        model = Motard
        fields = '__all__'
    

    def to_representation(self, instance):
        self.fields['parking'] = ParkingSerializer(read_only=True)
        return super(MotardSerializer, self).to_representation(instance)



class ClientSerializer(UtilisateurSerializer):
    class Meta:
        model = Client
        fields = '__all__'



class CourseSerializer(serializers.ModelSerializer):

    motard = serializers.PrimaryKeyRelatedField(queryset=Motard.objects.all(), many=False)
    client = serializers.PrimaryKeyRelatedField(queryset=Client.objects.all(), many=False)

    class Meta:
        model = Course
        fields = '__all__'

    def to_representation(self, instance):
        self.fields['motard'] = MotardSerializer(read_only=True)
        self.fields['client'] = ClientSerializer(read_only=True)
        return super(CourseSerializer, self).to_representation(instance)



class AlerteSerializer(serializers.ModelSerializer):

    utilisateur = serializers.PrimaryKeyRelatedField(queryset=Utilisateur.objects.all(), many=False)

    class Meta:
        model = Alerte
        fields = '__all__'
        
    def to_representation(self, instance):
        self.fields['utilisateur'] = UtilisateurSerializer(read_only=True)
        return super(AlerteSerializer, self).to_representation(instance)



class InterventionSerializer(serializers.ModelSerializer):

    alerte = serializers.PrimaryKeyRelatedField(queryset=Alerte.objects.all(), many=False)
    equipe_secours = serializers.PrimaryKeyRelatedField(queryset=EquipeSecours.objects.all(), many=False)

    class Meta:
        model = Intervention
        fields = '__all__'
       
       
    def to_representation(self, instance):
        self.fields['alerte'] = AlerteSerializer(read_only=True)
        self.fields['equipe_secours'] = EquipeSecoursSerializer(read_only=True)
        return super(InterventionSerializer, self).to_representation(instance)