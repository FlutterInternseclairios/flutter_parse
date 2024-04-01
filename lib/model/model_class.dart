import 'dart:convert';

class ModelClass {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? username;
  String? password;
  String? email;
 
  ModelClass({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.password,
    this.username,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'objectId': objectId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'username': username,
      'password': password,
      'email': email,
    };
  }

  factory ModelClass.fromMap(Map<String, dynamic> map) {
    return ModelClass(
      objectId: map['objectId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelClass.fromJson(String source) => ModelClass.fromMap(json.decode(source));
}