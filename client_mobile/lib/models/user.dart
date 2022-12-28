// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int id;
  DateTime last_login;
  DateTime date_joined;
  String username;
  String first_name;
  String last_name;
  String email;
  bool is_staff;
  bool is_active;
  bool is_superuser;
  bool is_association;
  bool equipe_secours;
  bool motard;
  bool client;
  User({
    required this.id,
    required this.last_login,
    required this.date_joined,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.is_staff,
    required this.is_active,
    required this.is_superuser,
    required this.is_association,
    required this.equipe_secours,
    required this.motard,
    required this.client,
  });

  User copyWith({
    int? id,
    DateTime? last_login,
    DateTime? date_joined,
    String? username,
    String? first_name,
    String? last_name,
    String? email,
    bool? is_staff,
    bool? is_active,
    bool? is_superuser,
    bool? is_association,
    bool? equipe_secours,
    bool? motard,
    bool? client,
  }) {
    return User(
      id: id ?? this.id,
      last_login: last_login ?? this.last_login,
      date_joined: date_joined ?? this.date_joined,
      username: username ?? this.username,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      is_staff: is_staff ?? this.is_staff,
      is_active: is_active ?? this.is_active,
      is_superuser: is_superuser ?? this.is_superuser,
      is_association: is_association ?? this.is_association,
      equipe_secours: equipe_secours ?? this.equipe_secours,
      motard: motard ?? this.motard,
      client: client ?? this.client,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'last_login': last_login.millisecondsSinceEpoch,
      'date_joined': date_joined.millisecondsSinceEpoch,
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'is_staff': is_staff,
      'is_active': is_active,
      'is_superuser': is_superuser,
      'is_association': is_association,
      'equipe_secours': equipe_secours,
      'motard': motard,
      'client': client,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map["id"] ?? 0) as int,
      last_login:
          DateTime.fromMillisecondsSinceEpoch((map["last_login"] ?? 0) as int),
      date_joined:
          DateTime.fromMillisecondsSinceEpoch((map["date_joined"] ?? 0) as int),
      username: (map["username"] ?? '') as String,
      first_name: (map["first_name"] ?? '') as String,
      last_name: (map["last_name"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      is_staff: (map["is_staff"] ?? false) as bool,
      is_active: (map["is_active"] ?? false) as bool,
      is_superuser: (map["is_superuser"] ?? false) as bool,
      is_association: (map["is_association"] ?? false) as bool,
      equipe_secours: (map["equipe_secours"] ?? false) as bool,
      motard: (map["motard"] ?? false) as bool,
      client: (map["client"] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, last_login: $last_login, date_joined: $date_joined, username: $username, first_name: $first_name, last_name: $last_name, email: $email, is_staff: $is_staff, is_active: $is_active, is_superuser: $is_superuser, is_association: $is_association, equipe_secours: $equipe_secours, motard: $motard, client: $client)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.last_login == last_login &&
        other.date_joined == date_joined &&
        other.username == username &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.email == email &&
        other.is_staff == is_staff &&
        other.is_active == is_active &&
        other.is_superuser == is_superuser &&
        other.is_association == is_association &&
        other.equipe_secours == equipe_secours &&
        other.motard == motard &&
        other.client == client;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        last_login.hashCode ^
        date_joined.hashCode ^
        username.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        email.hashCode ^
        is_staff.hashCode ^
        is_active.hashCode ^
        is_superuser.hashCode ^
        is_association.hashCode ^
        equipe_secours.hashCode ^
        motard.hashCode ^
        client.hashCode;
  }
}
