from django.db import models
from django.contrib.auth.models import User




class EquipeSecours(models.Model):
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

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    nom = models.CharField(max_length=50)
    post_nom = models.CharField(max_length=50)
    prenom = models.CharField(max_length=50)
    photo = models.CharField(max_length=250)
    date_naissance = models.DateField()
    genre = models.CharField(max_length=10, choices=GENRE)
    adresse = models.CharField(max_length=250)
    telephone = models.CharField(max_length=50)
    etat_civil = models.CharField(max_length=50, choices=ETAT_CIVIL)
    numero_national = models.CharField(max_length=50)
    profession = models.CharField(max_length=50)



class Association(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
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
    


