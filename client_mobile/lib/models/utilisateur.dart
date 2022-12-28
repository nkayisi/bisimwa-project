// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client_mobile/models/user.dart';

class Utilisateur {
  User user;
  String nom;
  String post_nom;
  String prenom;
  String photo;
  DateTime date_naissance;
  String genre;
  String adresse;
  String telephone;
  String etat_civil;
  String numero_national;
  String profession;
  Utilisateur({
    required this.user,
    required this.nom,
    required this.post_nom,
    required this.prenom,
    required this.photo,
    required this.date_naissance,
    required this.genre,
    required this.adresse,
    required this.telephone,
    required this.etat_civil,
    required this.numero_national,
    required this.profession,
  });

  Utilisateur copyWith({
    User? user,
    String? nom,
    String? post_nom,
    String? prenom,
    String? photo,
    DateTime? date_naissance,
    String? genre,
    String? adresse,
    String? telephone,
    String? etat_civil,
    String? numero_national,
    String? profession,
  }) {
    return Utilisateur(
      user: user ?? this.user,
      nom: nom ?? this.nom,
      post_nom: post_nom ?? this.post_nom,
      prenom: prenom ?? this.prenom,
      photo: photo ?? this.photo,
      date_naissance: date_naissance ?? this.date_naissance,
      genre: genre ?? this.genre,
      adresse: adresse ?? this.adresse,
      telephone: telephone ?? this.telephone,
      etat_civil: etat_civil ?? this.etat_civil,
      numero_national: numero_national ?? this.numero_national,
      profession: profession ?? this.profession,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'nom': nom,
      'post_nom': post_nom,
      'prenom': prenom,
      'photo': photo,
      'date_naissance': date_naissance.millisecondsSinceEpoch,
      'genre': genre,
      'adresse': adresse,
      'telephone': telephone,
      'etat_civil': etat_civil,
      'numero_national': numero_national,
      'profession': profession,
    };
  }

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      user: User.fromMap((map["user"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
      nom: (map["nom"] ?? '') as String,
      post_nom: (map["post_nom"] ?? '') as String,
      prenom: (map["prenom"] ?? '') as String,
      photo: (map["photo"] ?? '') as String,
      date_naissance: DateTime.fromMillisecondsSinceEpoch(
          (map["date_naissance"] ?? 0) as int),
      genre: (map["genre"] ?? '') as String,
      adresse: (map["adresse"] ?? '') as String,
      telephone: (map["telephone"] ?? '') as String,
      etat_civil: (map["etat_civil"] ?? '') as String,
      numero_national: (map["numero_national"] ?? '') as String,
      profession: (map["profession"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Utilisateur.fromJson(String source) =>
      Utilisateur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Utilisateur(user: $user, nom: $nom, post_nom: $post_nom, prenom: $prenom, photo: $photo, date_naissance: $date_naissance, genre: $genre, adresse: $adresse, telephone: $telephone, etat_civil: $etat_civil, numero_national: $numero_national, profession: $profession)';
  }

  @override
  bool operator ==(covariant Utilisateur other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.nom == nom &&
        other.post_nom == post_nom &&
        other.prenom == prenom &&
        other.photo == photo &&
        other.date_naissance == date_naissance &&
        other.genre == genre &&
        other.adresse == adresse &&
        other.telephone == telephone &&
        other.etat_civil == etat_civil &&
        other.numero_national == numero_national &&
        other.profession == profession;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        nom.hashCode ^
        post_nom.hashCode ^
        prenom.hashCode ^
        photo.hashCode ^
        date_naissance.hashCode ^
        genre.hashCode ^
        adresse.hashCode ^
        telephone.hashCode ^
        etat_civil.hashCode ^
        numero_national.hashCode ^
        profession.hashCode;
  }
}
