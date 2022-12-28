// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client_mobile/models/parking.dart';
import 'package:client_mobile/models/user.dart';
import 'package:client_mobile/models/utilisateur.dart';

class Motard extends Utilisateur {
  String matricule;
  Parking parking;

  Motard({
    required this.matricule,
    required this.parking,
    required super.user,
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
    required super.profession,
  });

  @override
  Motard copyWith({
    String? matricule,
    Parking? parking,
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
    return Motard(
      matricule: matricule ?? this.matricule,
      parking: parking ?? this.parking,
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

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricule': matricule,
      'parking': parking.toMap(),
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

  factory Motard.fromMap(Map<String, dynamic> map) {
    return Motard(
      matricule: (map["matricule"] ?? '') as String,
      parking: Parking.fromMap((map["parking"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
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

  @override
  String toJson() => json.encode(toMap());

  factory Motard.fromJson(String source) =>
      Motard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Motard(matricule: $matricule, parking: $parking)';

  @override
  bool operator ==(covariant Motard other) {
    if (identical(this, other)) return true;

    return other.matricule == matricule && other.parking == parking;
  }

  @override
  int get hashCode => matricule.hashCode ^ parking.hashCode;
}
