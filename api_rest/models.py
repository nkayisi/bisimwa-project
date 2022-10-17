from django.contrib.auth.models import AbstractUser
from django.db import models
from rest_framework.response import Response


from django.core.mail import send_mail
from django.contrib.auth.models import (PermissionsMixin, AbstractUser, BaseUserManager)
# from django.contrib.auth.base_user import AbstractBaseUser

# from django.contrib.auth.models import (AbstractUser, PermissionsMixin,
# BaseUserManager, Group, Permission)


from django.conf import settings




class Ceni(models.Model):
    numero_national = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.numero_national



class CustomUser(AbstractUser):

    is_association = models.BooleanField(default=False)
    equipe_secours = models.BooleanField(default=False)
    motard = models.BooleanField(default=False)
    client = models.BooleanField(default=False)
    is_membre_equipe_secours = models.BooleanField(default=False)

    def __str__(self):
        return self.username




class EquipeSecours(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, primary_key=True, on_delete=models.CASCADE)
    nom = models.CharField(max_length=50)
    position = models.CharField(max_length=50)
    nombre_member = models.IntegerField()


    def __str__(self):
        return self.nom
    


class Utilisateur(models.Model):

    GENRE = (
        ('Femme', 'Femme'),
        ('Homme', 'Homme')
    )

    ETAT_CIVIL = (
        ('Celibataire', 'Celibataire'),
        ('Marié', 'Marié'),
        ('Veuf', 'Veuf')
    )

    user = models.OneToOneField(settings.AUTH_USER_MODEL, primary_key=True, on_delete=models.CASCADE)
    nom = models.CharField(max_length=50)
    post_nom = models.CharField(max_length=50)
    prenom = models.CharField(max_length=50)
    photo = models.ImageField(upload_to='profils/', height_field=None, width_field=None, max_length=200, blank=True, null=True)
    date_naissance = models.DateField()
    genre = models.CharField(max_length=10, choices=GENRE)
    adresse = models.CharField(max_length=250, blank=True, null=True)
    telephone = models.CharField(max_length=50, blank=True, null=True)
    etat_civil = models.CharField(max_length=50, choices=ETAT_CIVIL)
    numero_national = models.CharField(max_length=50, unique=True)
    profession = models.CharField(max_length=50, blank=True, null=True)


    def __str__(self):
        return self.nom
    



class MembreEquipeSecours(Utilisateur):
    equipe_secours = models.ForeignKey(EquipeSecours, on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return self.nom


class Association(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, primary_key=True, on_delete=models.CASCADE)
    nom = models.CharField(max_length=50)
    president = models.CharField(max_length=50)
    vice_president = models.CharField(max_length=50)
    adresse = models.CharField(max_length=250)
    numero_impot = models.CharField(max_length=50)
    date_creation = models.DateField()

    def __str__(self):
        return self.nom



class Parking(models.Model):
    nom = models.CharField(max_length=50)
    adresse = models.CharField(max_length=250)
    association = models.ForeignKey(Association, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom
    



class Motard(Utilisateur):
    matricule = models.CharField(max_length=50)
    parking = models.ForeignKey(Parking, on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return self.matricule




class Client(Utilisateur):
    def __str__(self):
        return self.nom



class Course(models.Model):

    TYPE = (
        ('Personne', 'Personne'),
        ('Colit', 'Colit')
    )

    STATUT = (
        ('En cours', 'En cours'),
        ('Effectué', 'Effectué'),
        ('En entente', 'En entente')
    )

    date = models.DateField(auto_now_add=True)
    type = models.CharField(max_length=20, choices=TYPE)
    statut = models.CharField(max_length=20, choices=STATUT)
    motard = models.ForeignKey(Motard, on_delete=models.SET_NULL, null=True)
    client = models.ForeignKey(Client, on_delete=models.SET_NULL, null=True)


    def __str__(self):
        return self.statut
    

    

class Alerte(models.Model):
    date = models.DateField(auto_now_add=True)
    longitude = models.CharField(max_length=50)
    latitude = models.CharField(max_length=50)
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.SET_NULL, null=True)
    
    def __str__(self):
        return self.date
    



class Intervention(models.Model):
    date = models.DateField(auto_now_add=True)
    alerte = models.OneToOneField(Alerte, on_delete=models.CASCADE)
    equipe_secours = models.ForeignKey(EquipeSecours, on_delete=models.SET_NULL, null=True)


    def __str__(self):
        return self.date
    



    

