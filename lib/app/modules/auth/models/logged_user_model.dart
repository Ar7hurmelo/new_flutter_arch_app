// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoggedUserModel {
  String id;
  String name;
  String email;
  String? photoUrl;
  String token;

  LoggedUserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.token,
  });

  LoggedUserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) {
    return LoggedUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'token': token,
    };
  }

  factory LoggedUserModel.fromMap(Map<String, dynamic> map) {
    return LoggedUserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUserModel.fromJson(String source) =>
      LoggedUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoggedUserModel(id: $id, name: $name, email: $email, photoUrl: $photoUrl, token: $token)';
  }

  @override
  bool operator ==(covariant LoggedUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        token.hashCode;
  }
}
