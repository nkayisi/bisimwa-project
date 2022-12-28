// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client_mobile/models/user.dart';

class Association {
  User user;
  String nom;
  String president;
  String vice_president;
  String adresse;
  String numero_impot;
  DateTime date_creation;
  Association({
    required this.user,
    required this.nom,
    required this.president,
    required this.vice_president,
    required this.adresse,
    required this.numero_impot,
    required this.date_creation,
  });

  Association copyWith({
    User? user,
    String? nom,
    String? president,
    String? vice_president,
    String? adresse,
    String? numero_impot,
    DateTime? date_creation,
  }) {
    return Association(
      user: user ?? this.user,
      nom: nom ?? this.nom,
      president: president ?? this.president,
      vice_president: vice_president ?? this.vice_president,
      adresse: adresse ?? this.adresse,
      numero_impot: numero_impot ?? this.numero_impot,
      date_creation: date_creation ?? this.date_creation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'nom': nom,
      'president': president,
      'vice_president': vice_president,
      'adresse': adresse,
      'numero_impot': numero_impot,
      'date_creation': date_creation.millisecondsSinceEpoch,
    };
  }

  factory Association.fromMap(Map<String, dynamic> map) {
    return Association(
      user: User.fromMap((map["user"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
      nom: (map["nom"] ?? '') as String,
      president: (map["president"] ?? '') as String,
      vice_president: (map["vice_president"] ?? '') as String,
      adresse: (map["adresse"] ?? '') as String,
      numero_impot: (map["numero_impot"] ?? '') as String,
      date_creation: DateTime.fromMillisecondsSinceEpoch(
          (map["date_creation"] ?? 0) as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Association.fromJson(String source) =>
      Association.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Association(user: $user, nom: $nom, president: $president, vice_president: $vice_president, adresse: $adresse, numero_impot: $numero_impot, date_creation: $date_creation)';
  }

  @override
  bool operator ==(covariant Association other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.nom == nom &&
        other.president == president &&
        other.vice_president == vice_president &&
        other.adresse == adresse &&
        other.numero_impot == numero_impot &&
        other.date_creation == date_creation;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        nom.hashCode ^
        president.hashCode ^
        vice_president.hashCode ^
        adresse.hashCode ^
        numero_impot.hashCode ^
        date_creation.hashCode;
  }
}
