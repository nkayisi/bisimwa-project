import 'package:client_mobile/models/utilisateur.dart';

class Client extends Utilisateur {
  Client(
      {required super.user,
      required super.nom,
      required super.post_nom,
      required super.prenom,
      required super.photo,
      required super.date_naissance,
      required super.genre,
      required super.adresse,
      required super.telephone,
      required super.etat_civil,
      required super.numero_national,
      required super.profession});

  static fromMap(Map<String, dynamic> map) {}
}
