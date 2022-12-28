// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client_mobile/models/association.dart';

class Parking {
  String nom;
  String adresse;
  Association association;
  Parking({
    required this.nom,
    required this.adresse,
    required this.association,
  });

  Parking copyWith({
    String? nom,
    String? adresse,
    Association? association,
  }) {
    return Parking(
      nom: nom ?? this.nom,
      adresse: adresse ?? this.adresse,
      association: association ?? this.association,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'adresse': adresse,
      'association': association.toMap(),
    };
  }

  factory Parking.fromMap(Map<String, dynamic> map) {
    return Parking(
      nom: (map["nom"] ?? '') as String,
      adresse: (map["adresse"] ?? '') as String,
      association: Association.fromMap((map["association"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Parking.fromJson(String source) =>
      Parking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Parking(nom: $nom, adresse: $adresse, association: $association)';

  @override
  bool operator ==(covariant Parking other) {
    if (identical(this, other)) return true;

    return other.nom == nom &&
        other.adresse == adresse &&
        other.association == association;
  }

  @override
  int get hashCode => nom.hashCode ^ adresse.hashCode ^ association.hashCode;
}
