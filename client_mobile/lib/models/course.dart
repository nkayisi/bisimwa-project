// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:client_mobile/models/client.dart';
import 'package:client_mobile/models/motard.dart';

class Course {
  int id;
  DateTime date;
  String type;
  String statut;
  Motard motard;
  Client client;
  Course({
    required this.id,
    required this.date,
    required this.type,
    required this.statut,
    required this.motard,
    required this.client,
  });

  Course copyWith({
    int? id,
    DateTime? date,
    String? type,
    String? statut,
    Motard? motard,
    Client? client,
  }) {
    return Course(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      statut: statut ?? this.statut,
      motard: motard ?? this.motard,
      client: client ?? this.client,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'type': type,
      'statut': statut,
      'motard': motard.toMap(),
      'client': client.toMap(),
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: (map["id"] ?? 0) as int,
      date: DateTime.fromMillisecondsSinceEpoch((map["date"] ?? 0) as int),
      type: (map["type"] ?? '') as String,
      statut: (map["statut"] ?? '') as String,
      motard: Motard.fromMap((map["motard"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
      client: Client.fromMap((map["client"] ?? Map<String, dynamic>.from({}))
          as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id, date: $date, type: $type, statut: $statut, motard: $motard, client: $client)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.type == type &&
        other.statut == statut &&
        other.motard == motard &&
        other.client == client;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        type.hashCode ^
        statut.hashCode ^
        motard.hashCode ^
        client.hashCode;
  }
}
